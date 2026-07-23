#!/usr/bin/env bash
#
# Verifies xAI's Grok Build CLI against Upstage's Solar Open 2 model,
# registered as a custom OpenAI-compatible model provider:
#   A. a deterministic single-turn headless reply
#   B. a reasoning-heavy prompt, to see how the model actually reasons,
#      not just that it responded
#   C. a small coding task (write one Python function), Grok Build's
#      actual reason for existing, kept to plain text output only so it
#      isn't affected by the tool-calling bug below
#
# A real finding along the way, checked but not gated on: Grok Build's
# built-in tool-calling breaks against Solar Open 2 with a 400 "Invalid
# function name: ''" error — the same Upstage-side tool_call
# function-name-drop bug documented in
# 05-langchain-openwiki-solar-open2/README.md's Finding 2, surfacing
# here through a different, closed-source client that can't be patched
# the way the openwiki fork was. See this case's README for the full
# writeup. That check runs for real every time so the finding stays
# honest (and gets noticed if Upstage ever fixes it), but never fails
# this script.
#
# Grok Build only supports custom models in its *user-level*
# config.toml, not a project-local one (confirmed via its own docs:
# "Project configs are limited to MCP servers, plugins, and permission
# rules, not full user configs") — so this script points $GROK_HOME at
# a throwaway temp directory holding a generated config.toml instead of
# touching the real ~/.grok.
#
# Model under test: $SOLAR_MODEL, defaulting to solar-open2.
#
# Requires: `grok` on PATH (https://x.ai/cli/install.sh), UPSTAGE_API_KEY set.

set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

SOLAR_MODEL="${SOLAR_MODEL:-solar-open2}"

fail() { printf '✗ %s\n' "$1" >&2; exit 1; }
ok()   { printf '✓ %s\n' "$1"; }

# preview <text> — up to ~700 chars, wrapped to <=70 cols, so a single
# dense paragraph still renders as 10+ lines in CI logs.
preview() {
  s="$1"
  truncated=""
  if [ "${#s}" -gt 700 ]; then
    s="${s:0:700}"
    truncated=1
  fi
  printf '%s\n' "$s" | fold -s -w 70 | sed 's/^/  /'
  [ -n "$truncated" ] && echo "  ...(truncated)"
  return 0
}

# backoff <attempt> — flat 30s before a retry. This repo's cases share
# one Upstage account/rate limit, so a failure here can just mean
# another case's run is still in flight.
backoff() {
  printf '  attempt %s failed (possibly rate-limited) — retrying in 30s\n' "$attempt" >&2
  sleep 30
}

grok_home="$(mktemp -d)"
cleanup() { rm -rf "$grok_home"; }
trap cleanup EXIT

sed "s/SOLAR_MODEL_PLACEHOLDER/$SOLAR_MODEL/g" \
  config/config.toml.template > "$grok_home/config.toml"

[ -n "${UPSTAGE_API_KEY:-}" ] || fail "UPSTAGE_API_KEY is not set"
command -v grok >/dev/null 2>&1 || fail "grok CLI not found (curl -fsSL https://x.ai/cli/install.sh | bash)"

export GROK_HOME="$grok_home"

echo "== Model under test: $SOLAR_MODEL =="

echo
echo "== grok inspect discovers the generated config =="
inspect_output="$(grok inspect 2>&1)" || fail "grok inspect failed"
printf '%s\n' "$inspect_output" | grep -q "$grok_home/config.toml" \
  || fail "grok inspect did not pick up the generated GROK_HOME config"
ok "grok discovered the Solar Open 2 model config"

echo
echo "== Method A: deterministic single-turn headless reply =="
method_a_out=""
for attempt in 1 2 3 4 5; do
  if method_a_out="$(grok -p 'Reply with exactly: grok-solar-ready' -m "$SOLAR_MODEL" --no-subagents 2>&1)" \
    && printf '%s' "$method_a_out" | grep -q 'grok-solar-ready'; then
    break
  fi
  [ "$attempt" -lt 5 ] && backoff
done
printf '%s' "$method_a_out" | grep -q 'grok-solar-ready' \
  || fail "$SOLAR_MODEL response did not contain grok-solar-ready after 5 attempts: $method_a_out"
ok "grok completed a live $SOLAR_MODEL round trip"
preview "$method_a_out"

echo
echo "== Method B: reasoning-heavy prompt =="
method_b_out=""
for attempt in 1 2 3 4 5; do
  if method_b_out="$(grok -p 'Explain step by step why the sum of the first 50 positive integers equals 1275. Show your reasoning.' -m "$SOLAR_MODEL" --no-subagents 2>&1)" \
    && printf '%s' "$method_b_out" | grep -q '1275'; then
    break
  fi
  [ "$attempt" -lt 5 ] && backoff
done
printf '%s' "$method_b_out" | grep -q '1275' \
  || fail "$SOLAR_MODEL reasoning answer did not contain 1275 after 5 attempts: $method_b_out"
ok "$SOLAR_MODEL reasoned through the sum correctly"
preview "$method_b_out"

echo
echo "== Method C: small coding task =="
method_c_out=""
for attempt in 1 2 3 4 5; do
  if method_c_out="$(grok -p 'Write a Python function named is_prime(n) that returns True if n is a prime number and False otherwise. Include a brief docstring. Output only the code in a single fenced code block.' -m "$SOLAR_MODEL" --no-subagents 2>&1)" \
    && printf '%s' "$method_c_out" | grep -q 'def is_prime'; then
    break
  fi
  [ "$attempt" -lt 5 ] && backoff
done
printf '%s' "$method_c_out" | grep -q 'def is_prime' \
  || fail "$SOLAR_MODEL coding answer did not contain def is_prime after 5 attempts: $method_c_out"
ok "$SOLAR_MODEL wrote the requested function"
preview "$method_c_out"

echo
echo "== Finding check: tool-use against Solar Open 2 (expected to fail, not gated) =="
echo "solar-open2-tool-use-probe" > /tmp/grok-tool-use-facts.txt
tool_use_out="$(grok -p 'Read the file /tmp/grok-tool-use-facts.txt and tell me exactly what it contains. Use your file-reading tool, do not guess.' \
  -m "$SOLAR_MODEL" --no-subagents --permission-mode bypassPermissions 2>&1)" || true
rm -f /tmp/grok-tool-use-facts.txt
if printf '%s' "$tool_use_out" | grep -q "Invalid function name: ''"; then
  echo "  (reproduced: Upstage dropped the tool_call function name, same as Case 05's Finding 2)"
else
  echo "  (did not reproduce the known function-name-drop error this run — see output below)"
fi
preview "$tool_use_out"

echo
ok "All checks passed."
