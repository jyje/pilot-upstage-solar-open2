#!/usr/bin/env bash
#
# Verifies oh-my-pi's `omp` CLI against Upstage's Solar Open 2 model,
# registered as a custom OpenAI-compatible provider:
#   A. a deterministic single-turn headless reply
#   B. a reasoning-heavy prompt, to see how the model actually reasons,
#      not just that it responded
#   C. a small coding task (write one Python function)
#   D. a real development task -- build a working 6x6 Mini Sudoku web
#      app -- verified functionally with a headless browser (Playwright)
#      rather than by grepping the source, since this is the one case
#      in this repo whose output is a UI, not text
#
# A real finding along the way, checked but not gated on: whether omp's
# built-in file-reading tool calls hit the same Upstage streamed
# tool_call-name-drop bug documented in Case 05's Finding 2 / reproduced
# in Case 06. See this case's README for the full writeup either way.
#
# omp reads provider/model definitions from $PI_CODING_AGENT_DIR/models.yml
# and the default model role from $PI_CODING_AGENT_DIR/config.yml --
# this script points $PI_CODING_AGENT_DIR at a throwaway temp directory
# holding generated copies of both, instead of touching the real
# ~/.omp/agent. Same isolation pattern as Case 02's Hermes home,
# Case 03's CODEX_HOME, and Case 06's $GROK_HOME.
#
# A required, non-obvious finding baked into config/models.yml.template:
# omp's openai-completions client defaults to sending `store: false` on
# requests to endpoints it thinks look "standard", and Upstage's
# endpoint 400s on that unrecognized field. `compat.supportsStore: false`
# on the provider entry is what turns it off -- every request fails
# without it. See this case's README for the full trace.
#
# Model under test: $SOLAR_MODEL, defaulting to solar-open2.
#
# Requires: `omp` on PATH (curl -fsSL https://omp.sh/install | sh),
# Node 18+ on PATH (for Method D's Playwright check), UPSTAGE_API_KEY set.
#
# Method D runs a full agentic build (minutes, not seconds) and installs
# a headless browser, so CI skips it (SKIP_METHOD_D=1) and only gates on
# Methods A-C; its result is verified locally instead and published as
# a playable artifact in ../gallery/ rather than re-run on every CI pass.
# Set SKIP_METHOD_D to any non-empty value to reproduce that locally.

set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."
script_dir="$(pwd)/scripts"

SOLAR_MODEL="${SOLAR_MODEL:-solar-open2}"
OMP_MODEL_REF="upstage/${SOLAR_MODEL}"

fail() { printf '✗ %s\n' "$1" >&2; exit 1; }
ok()   { printf '✓ %s\n' "$1"; }

# preview <text> -- up to ~700 chars, wrapped to <=70 cols, so a single
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

# backoff <attempt> -- flat 30s before a retry. This repo's cases share
# one Upstage account/rate limit, so a failure here can just mean
# another case's run is still in flight.
backoff() {
  printf '  attempt %s failed (possibly rate-limited) -- retrying in 30s\n' "$attempt" >&2
  sleep 30
}

agent_dir="$(mktemp -d)"
cleanup() { rm -rf "$agent_dir"; }
trap cleanup EXIT

sed "s/OMP_MODEL_PLACEHOLDER/$SOLAR_MODEL/g" \
  config/models.yml.template > "$agent_dir/models.yml"
sed "s/OMP_MODEL_PLACEHOLDER/$SOLAR_MODEL/g" \
  config/config.yml.template > "$agent_dir/config.yml"

[ -n "${UPSTAGE_API_KEY:-}" ] || fail "UPSTAGE_API_KEY is not set"
command -v omp >/dev/null 2>&1 || fail "omp CLI not found (curl -fsSL https://omp.sh/install | sh)"
command -v node >/dev/null 2>&1 || fail "node not found (needed for Method D's Playwright check)"

export PI_CODING_AGENT_DIR="$agent_dir"

echo "== Model under test: $OMP_MODEL_REF =="

echo
echo "== omp config path discovers the generated agent directory =="
path_output="$(omp config path 2>&1)" || fail "omp config path failed"
[ "$path_output" = "$agent_dir" ] \
  || fail "omp config path returned '$path_output', expected '$agent_dir'"
ok "omp discovered the Solar Open 2 provider config"

echo
echo "== Method A: deterministic single-turn headless reply =="
method_a_out=""
for attempt in 1 2 3 4 5; do
  if method_a_out="$(omp --print --auto-approve --model "$OMP_MODEL_REF" 'Reply with exactly: omp-solar-ready' 2>&1)" \
    && printf '%s' "$method_a_out" | grep -q 'omp-solar-ready'; then
    break
  fi
  [ "$attempt" -lt 5 ] && backoff
done
printf '%s' "$method_a_out" | grep -q 'omp-solar-ready' \
  || fail "$SOLAR_MODEL response did not contain omp-solar-ready after 5 attempts: $method_a_out"
ok "omp completed a live $SOLAR_MODEL round trip"
preview "$method_a_out"

echo
echo "== Method B: reasoning-heavy prompt =="
method_b_out=""
for attempt in 1 2 3 4 5; do
  if method_b_out="$(omp --print --auto-approve --model "$OMP_MODEL_REF" 'Explain step by step why the sum of the first 50 positive integers equals 1275. Show your reasoning.' 2>&1)" \
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
  if method_c_out="$(omp --print --auto-approve --model "$OMP_MODEL_REF" 'Write a Python function named is_prime(n) that returns True if n is a prime number and False otherwise. Include a brief docstring. Output only the code in a single fenced code block.' 2>&1)" \
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
echo "== Method D: real development task -- 6x6 Mini Sudoku =="

if [ -n "${SKIP_METHOD_D:-}" ]; then
  echo "  skipped (SKIP_METHOD_D set) -- see ../gallery/case-08-omp-sudoku-solar-open2/"
  echo "  for the verified, published result of this method."
  echo
  ok "All checks passed (Method D skipped)."
  exit 0
fi

# Playwright needs to be installed once. Fast no-op on repeat runs.
if [ ! -d "$script_dir/node_modules/playwright" ]; then
  echo "  installing Playwright (first run only)..."
  npm install --prefix "$script_dir" --no-audit --no-fund >/dev/null
fi
npx --prefix "$script_dir" playwright install chromium >/dev/null 2>&1 || true

sudoku_prompt="$(cat "$script_dir/sudoku-prompt.txt")"
work_dir="$(mktemp -d)"
cleanup_d() { rm -rf "$work_dir"; }
trap 'cleanup_d; cleanup' EXIT

method_d_out=""
for attempt in 1 2 3; do
  rm -f "$work_dir/index.html"
  if method_d_out="$(cd "$work_dir" && omp --print --auto-approve --max-time 8m --model "$OMP_MODEL_REF" "$sudoku_prompt" 2>&1)"; then
    [ -f "$work_dir/index.html" ] && break
    method_d_out="$method_d_out"$'\n'"(omp exited 0 but wrote no index.html)"
  fi
  [ "$attempt" -lt 3 ] && backoff
done

[ -f "$work_dir/index.html" ] \
  || fail "omp did not produce $work_dir/index.html after 3 attempts. Last output:
$(preview "$method_d_out")"
ok "omp wrote an index.html for the Sudoku app"

# From here, a failure is a spec-compliance finding, not a flaky API
# call -- no further retry. See this case's README for what a failure
# here means and looked like when first observed.
node "$script_dir/verify-sudoku.mjs" "$work_dir/index.html"

echo
ok "All checks passed."
