#!/usr/bin/env bash
# Starts a local-only LiteLLM proxy for Codex. The Upstage key stays in the
# container environment and is never written to the repository.

set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

[ -n "${UPSTAGE_API_KEY:-}" ] || {
  printf 'UPSTAGE_API_KEY is not set\n' >&2
  exit 1
}

export LITELLM_MASTER_KEY="${LITELLM_MASTER_KEY:-sk-local-solar-open2}"

exec docker run --rm --name codex-solar-lab \
  -p 127.0.0.1:4000:4000 \
  -e UPSTAGE_API_KEY \
  -e LITELLM_MASTER_KEY \
  -v "$PWD/config/litellm-config.yaml:/app/config.yaml:ro" \
  docker.litellm.ai/berriai/litellm:latest \
  --config /app/config.yaml
