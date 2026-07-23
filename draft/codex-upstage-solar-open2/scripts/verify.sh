#!/usr/bin/env bash
# Verifies the full Codex -> LiteLLM Responses bridge -> Upstage Chat
# Completions path. Requires Codex, LiteLLM, curl, and UPSTAGE_API_KEY.

set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

fail() { printf '✗ %s\n' "$1" >&2; exit 1; }
ok() { printf '✓ %s\n' "$1"; }

[ -n "${UPSTAGE_API_KEY:-}" ] || fail "UPSTAGE_API_KEY is not set"
command -v codex >/dev/null 2>&1 || fail "codex CLI not found"
command -v litellm >/dev/null 2>&1 || fail "litellm proxy CLI not found"
command -v curl >/dev/null 2>&1 || fail "curl not found"

# This is authentication only between local Codex and the local proxy. It is
# intentionally distinct from the Upstage credential consumed by LiteLLM.
export LITELLM_MASTER_KEY="${LITELLM_MASTER_KEY:-sk-local-solar-open2}"
proxy_log="$(mktemp)"
codex_home="$(mktemp -d)"
cleanup() {
  [ -n "${proxy_pid:-}" ] && kill "$proxy_pid" 2>/dev/null || true
  rm -f "$proxy_log"
  rm -rf "$codex_home"
}
trap cleanup EXIT

cp config/codex.config.toml "$codex_home/config.toml"
litellm --config config/litellm-config.yaml --port 4000 >"$proxy_log" 2>&1 &
proxy_pid=$!

for _ in {1..30}; do
  curl -fsS http://127.0.0.1:4000/health/liveliness >/dev/null 2>&1 && break
  sleep 1
done
curl -fsS http://127.0.0.1:4000/health/liveliness >/dev/null 2>&1 \
  || { cat "$proxy_log" >&2; fail "LiteLLM proxy did not become ready"; }
ok "LiteLLM proxy is ready"

response="$(curl -fsS http://127.0.0.1:4000/v1/responses \
  -H "Authorization: Bearer $LITELLM_MASTER_KEY" \
  -H 'Content-Type: application/json' \
  -d '{"model":"solar-open2","input":"Reply with exactly: bridge-ready. Do not call tools.","tools":[{"type":"function","name":"noop","description":"Do nothing.","parameters":{"type":"object","properties":{}}}]}')" \
  || { cat "$proxy_log" >&2; fail "LiteLLM Responses bridge request failed"; }
printf '%s' "$response" | grep -q 'bridge-ready' \
  || fail "LiteLLM bridge response did not contain the expected text: $response"
ok "LiteLLM translated a Responses request for Solar Open 2"

output="$(CODEX_HOME="$codex_home" codex exec \
  'Read README.md and reply with only this repository name.' 2>&1)" \
  || { printf '%s\n' "$output" >&2; fail "codex exec failed through LiteLLM"; }
printf '%s' "$output" | grep -q 'pilot-upstage-solar-open2' \
  || fail "Codex did not report the repository name: $output"
ok "Codex read README.md through LiteLLM and Solar Open 2"
