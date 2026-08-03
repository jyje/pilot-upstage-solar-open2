#!/usr/bin/env bash
#
# Verifies the litellm-proxy bridge: starts it via docker compose, waits
# for it to report healthy, then sends a raw Anthropic Messages API
# request (POST /v1/messages) for each model in litellm-config.yaml —
# solar-open2 (already reachable directly on Upstage's own Anthropic-
# compatible endpoint) and solar-pro4 (not mapped there; this proxy is
# the reason it exists). A real response from both confirms the bridge
# itself works, independent of whether Upstage ever adds solar-pro4 to
# its own Anthropic-compatible path.
#
# Requires: docker (with the compose plugin), curl, UPSTAGE_API_KEY set.

set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")"

fail() { printf '✗ %s\n' "$1" >&2; exit 1; }
ok()   { printf '✓ %s\n' "$1"; }

[ -n "${UPSTAGE_API_KEY:-}" ] || fail "UPSTAGE_API_KEY is not set"
command -v docker >/dev/null 2>&1 || fail "docker not found"
command -v curl >/dev/null 2>&1 || fail "curl not found"

export LITELLM_MASTER_KEY="${LITELLM_MASTER_KEY:-sk-local-solar-proxy}"

cleanup() { docker compose down >/dev/null 2>&1 || true; }
trap cleanup EXIT

docker compose up -d
ok "litellm-proxy container started"

for _ in $(seq 1 30); do
  curl -fsS http://127.0.0.1:4000/health/liveliness >/dev/null 2>&1 && break
  sleep 1
done
curl -fsS http://127.0.0.1:4000/health/liveliness >/dev/null 2>&1 \
  || { docker compose logs; fail "litellm-proxy did not become ready"; }
ok "litellm-proxy is ready"

ask() {
  local model="$1"
  curl -fsS http://127.0.0.1:4000/v1/messages \
    -H "x-api-key: $LITELLM_MASTER_KEY" \
    -H "anthropic-version: 2023-06-01" \
    -H "Content-Type: application/json" \
    -d "{\"model\":\"$model\",\"max_tokens\":64,\"messages\":[{\"role\":\"user\",\"content\":\"Reply with exactly: bridge-ready\"}]}"
}

for model in solar-open2 solar-pro4; do
  echo
  echo "== $model via /v1/messages (Anthropic format) =="
  response="$(ask "$model")" || fail "$model request failed"
  printf '%s\n' "$response" | grep -q 'bridge-ready' \
    || fail "$model response did not contain the expected text: $response"
  ok "$model responded through the Anthropic-shaped bridge"
done

echo
ok "All checks passed."
