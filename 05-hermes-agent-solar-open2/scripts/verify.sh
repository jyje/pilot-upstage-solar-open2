#!/usr/bin/env bash
# Verifies Hermes Agent -> Upstage -> Solar Open2 with the official Docker
# image and Hermes's built-in Upstage provider.

set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

fail() { printf '✗ %s\n' "$1" >&2; exit 1; }
ok() { printf '✓ %s\n' "$1"; }

image="${HERMES_IMAGE:-nousresearch/hermes-agent@sha256:bb4d1e414918773b9c40e9a50582d582933beb85029b7050164d125f14e3f417}"
hermes_home="$(mktemp -d)"
cleanup() {
  rm -rf "$hermes_home"
}
trap cleanup EXIT

[ -n "${UPSTAGE_API_KEY:-}" ] || fail "UPSTAGE_API_KEY is not set"
command -v docker >/dev/null 2>&1 || fail "docker is not installed"
docker info >/dev/null 2>&1 || fail "Docker daemon is not available"

cp config.yaml "$hermes_home/config.yaml"
touch "$hermes_home/.env"

hermes() {
  docker run --rm \
    -e UPSTAGE_API_KEY \
    -v "$hermes_home:/opt/data" \
    --entrypoint hermes \
    "$image" "$@"
}

version="$(hermes --version)" || fail "Hermes Agent image did not start"
printf '%s\n' "$version"
printf '%s' "$version" | grep -q 'Hermes Agent' \
  || fail "unexpected Hermes version output"
ok "official Hermes Agent image started"

doctor_output="$(hermes doctor 2>&1)" || {
  printf '%s\n' "$doctor_output" >&2
  fail "hermes doctor failed"
}
printf '%s\n' "$doctor_output"
printf '%s' "$doctor_output" | grep -qi 'upstage' \
  || fail "hermes doctor did not detect the Upstage provider"
ok "Hermes accepted the Upstage configuration"

chat_output="$(hermes chat \
  --provider upstage \
  --model solar-open2 \
  --query 'Reply with exactly: hermes-ready' \
  --max-turns 2 \
  --quiet \
  --ignore-rules 2>&1)" || {
  printf '%s\n' "$chat_output" >&2
  fail "Hermes chat round trip failed"
}
printf '%s\n' "$chat_output"
printf '%s' "$chat_output" | grep -q 'hermes-ready' \
  || fail "Solar Open2 response did not contain hermes-ready"
ok "Hermes completed a live Solar Open2 round trip"
