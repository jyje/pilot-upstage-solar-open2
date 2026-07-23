#!/usr/bin/env bash
#
# Verifies Hermes Agent -> Upstage -> Solar Open 2, deployed via the
# community jyje/hermes-agent-helm chart onto an ephemeral kind cluster:
#   A. the chart's own declarative `tests.chat` Helm-test Job (a gated,
#      exact-string round trip)
#   B. a live `kubectl exec ... hermes chat` reasoning round trip against
#      the running gateway pod itself, not just the test Job
#   C. asking Hermes itself, running on Solar Open 2, to describe in its
#      own words the strengths the model gives it as an agent -- captured
#      in full (not truncated) since the point is the real, substantive
#      answer, not just a pass/fail check
#
# This runs the gateway pod directly and does not connect a messenger
# (Telegram/Discord) -- see README.md for how to add one via BotFather if
# you want to go further; that's out of scope for this case's verification.
#
# Owns its own kind cluster end to end: creates it at the start, deletes it
# on exit (success or failure) via trap. Installs from the chart's
# published OCI artifact, pinned to $HELM_CHART_VERSION (default: the
# version this script was last verified against), not a git clone of the
# chart's source repo.
#
# Model under test: $SOLAR_MODEL, defaulting to solar-open2.
#
# Requires: docker (daemon running), kind, kubectl, helm on PATH,
# UPSTAGE_API_KEY set.

set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

SOLAR_MODEL="${SOLAR_MODEL:-solar-open2}"
HELM_CHART_VERSION="${HELM_CHART_VERSION:-0.12.0}"
CHART="oci://ghcr.io/jyje/hermes-agent-helm/hermes-agent"
NS="hermes-agent"
RELEASE="hermes-agent"
KIND_CLUSTER="pilot-solar-open2-$$"
CTX="kind-$KIND_CLUSTER"

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

# backoff <attempt> — flat 30s before a retry. This repo's cases share one
# Upstage account/rate limit, so a failure here can just mean another
# case's run is still in flight.
backoff() {
  printf '  attempt %s failed (possibly rate-limited) — retrying in 30s\n' "$attempt" >&2
  sleep 30
}

cleanup() {
  kind delete cluster --name "$KIND_CLUSTER" >/dev/null 2>&1 || true
}
trap cleanup EXIT

[ -n "${UPSTAGE_API_KEY:-}" ] || fail "UPSTAGE_API_KEY is not set"
command -v docker >/dev/null 2>&1 || fail "docker is not installed"
docker info >/dev/null 2>&1 || fail "Docker daemon is not available"
command -v kind >/dev/null 2>&1 || fail "kind is not installed (https://kind.sigs.k8s.io/docs/user/quick-start/#installation)"
command -v kubectl >/dev/null 2>&1 || fail "kubectl is not installed"
command -v helm >/dev/null 2>&1 || fail "helm is not installed"

echo "== Model under test: $SOLAR_MODEL (hermes-agent chart v$HELM_CHART_VERSION) =="

echo
echo "== Creating ephemeral kind cluster: $KIND_CLUSTER =="
kind create cluster --name "$KIND_CLUSTER" --wait 90s
ok "kind cluster is ready"

echo
echo "== Installing hermes-agent-helm from the published OCI chart =="
helm upgrade --install "$RELEASE" "$CHART" \
  --version "$HELM_CHART_VERSION" \
  --kube-context "$CTX" \
  --namespace "$NS" --create-namespace \
  -f values-solar-open2.yaml \
  --set-string config.model.default="$SOLAR_MODEL" \
  --set-string env.UPSTAGE_API_KEY="$UPSTAGE_API_KEY" \
  --wait --timeout 5m
ok "chart installed and the gateway pod is ready"

echo
echo "== Method A: the chart's own tests.chat Helm-test Job =="
# helm test's own hook watch can stall for many minutes on a CI runner
# (per jyje/hermes-agent-helm's own CI comments) -- render the test hook
# and poll its Job status directly instead of trusting `helm test --wait`.
job="$RELEASE-test"
run_hook_test() {
  helm get hooks "$RELEASE" -n "$NS" --kube-context "$CTX" > /tmp/hermes-helm-hooks.yaml
  kubectl --context "$CTX" delete job "$job" -n "$NS" --ignore-not-found
  kubectl --context "$CTX" create -n "$NS" -f /tmp/hermes-helm-hooks.yaml
  for _ in $(seq 1 150); do
    conds=$(kubectl --context "$CTX" get job "$job" -n "$NS" \
      -o jsonpath='{.status.conditions[?(@.status=="True")].type}' 2>/dev/null || true)
    case "$conds" in
      *Complete*) return 0 ;;
      *Failed*)   return 1 ;;
    esac
    sleep 2
  done
  return 1
}

test_out=""
for attempt in 1 2 3 4 5; do
  run_hook_test || true
  test_out="$(kubectl --context "$CTX" logs -n "$NS" -l app.kubernetes.io/component=test --tail=-1 2>&1 || true)"
  printf '%s' "$test_out" | grep -q 'hermes-k8s-ready' && break
  [ "$attempt" -lt 5 ] && backoff
done
printf '%s' "$test_out" | grep -q 'hermes-k8s-ready' \
  || fail "the chart's chat test Job did not report hermes-k8s-ready after 5 attempts: $test_out"
ok "the chart's own Helm test Job completed a live $SOLAR_MODEL round trip"
preview "$test_out"

echo
echo "== Method B: live chat round trip against the running gateway pod =="
pod="$(kubectl --context "$CTX" get pod -n "$NS" -l app.kubernetes.io/name=hermes-agent \
  -o jsonpath='{.items[0].metadata.name}')"
chat_out=""
for attempt in 1 2 3 4 5; do
  if chat_out="$(kubectl --context "$CTX" exec -n "$NS" "$pod" -- \
    hermes chat --provider upstage --model "$SOLAR_MODEL" \
    --query 'Explain step by step why the sum of the first 50 positive integers equals 1275. Show your reasoning.' \
    --max-turns 2 --quiet --ignore-rules 2>&1)" \
    && printf '%s' "$chat_out" | grep -q '1275'; then
    break
  fi
  [ "$attempt" -lt 5 ] && backoff
done
printf '%s' "$chat_out" | grep -q '1275' \
  || fail "$SOLAR_MODEL reasoning answer did not contain 1275 after 5 attempts: $chat_out"
ok "the running gateway pod reasoned through the sum correctly via $SOLAR_MODEL"
preview "$chat_out"

echo
echo "== Method C: Hermes, in its own words, on the Solar Open 2 synergy =="
synergy_out=""
for attempt in 1 2 3 4 5; do
  if synergy_out="$(kubectl --context "$CTX" exec -n "$NS" "$pod" -- \
    hermes chat --provider upstage --model "$SOLAR_MODEL" \
    --query 'You are Hermes Agent, currently running on Upstage Solar Open 2 as your backend model. In your own words, describe the specific strengths this model gives you as an agent -- think about reasoning, tool use, and coding ability. Be concrete and thorough.' \
    --max-turns 2 --quiet --ignore-rules 2>&1)"; then
    lines="$(printf '%s' "$synergy_out" | grep -c '[^[:space:]]')"
    [ "$lines" -ge 10 ] && break
  fi
  [ "$attempt" -lt 5 ] && backoff
done
lines="$(printf '%s' "$synergy_out" | grep -c '[^[:space:]]')"
[ "$lines" -ge 10 ] \
  || fail "Hermes's self-reflection answer had fewer than 10 non-empty lines after 5 attempts: $synergy_out"
ok "Hermes described its own Solar Open 2 strengths in $lines non-empty lines"
printf '%s\n' "$synergy_out"

echo
ok "All checks passed."
