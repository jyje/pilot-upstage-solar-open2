# Case 07 — Use Case Guide

[English](REPRODUCE.md) / [한국어](REPRODUCE-ko.md)

[← back to this case's README](README.md) · [← all cases' use case guides](../docs/REPRODUCE.md)

Goal: deploy Hermes Agent via the community `jyje/hermes-agent-helm` Helm
chart onto an ephemeral kind cluster, and verify it reaches Solar Open 2
through its built-in Upstage provider — the same provider path Case 02
verified with the plain Docker image, now on Kubernetes.

Full narrative and verified transcripts: [`README.md`](README.md).

Haven't set up `UPSTAGE_API_KEY` or read about the shared Tier-0 rate
limit yet? Start at [`docs/REPRODUCE.md`](../docs/REPRODUCE.md) first —
this page assumes both are already handled.

## What you need

- [Docker](https://docs.docker.com/get-docker/), with the daemon running
  (kind runs cluster nodes as containers)
- [`kind`](https://kind.sigs.k8s.io/docs/user/quick-start/#installation)
- [`kubectl`](https://kubernetes.io/docs/tasks/tools/#kubectl)
- [`helm`](https://helm.sh/docs/intro/install/) 3+

No Node, no Python, no `git clone` of `hermes-agent-helm` — the chart
installs straight from its published OCI artifact.

## Run it

From the repo root, `cd` into this directory first, then run its script:

```bash
cd 07-hermes-agent-helm-solar-open2
export UPSTAGE_API_KEY="up_..."
./scripts/verify.sh
```

The script creates a throwaway kind cluster (named `pilot-solar-open2-<pid>`)
and deletes it again when the script exits, success or failure — it never
touches your existing kind clusters or `~/.kube/config` contexts beyond
adding and later removing its own.

## What success looks like

```
== Model under test: solar-open2 (hermes-agent chart v0.12.0) ==

== Creating ephemeral kind cluster: pilot-solar-open2-19728 ==
...
✓ kind cluster is ready

== Installing hermes-agent-helm from the published OCI chart ==
...
✓ chart installed and the gateway pod is ready

== Method A: the chart's own tests.chat Helm-test Job ==
...
✓ the chart's own Helm test Job completed a live solar-open2 round trip

== Method B: live chat round trip against the running gateway pod =="
...
✓ the running gateway pod reasoned through the sum correctly via solar-open2

== Method C: Hermes, in its own words, on the Solar Open 2 synergy ==
...
✓ Hermes described its own Solar Open 2 strengths in N non-empty lines

✓ All checks passed.
```

(Method C's line count varies run to run — the script only requires at
least 10; a real run typically produces several dozen.)

A full run takes a few minutes — most of it is the kind cluster coming up
and the chart's image pull, not the model calls themselves.

## If something goes wrong

- **`Docker daemon is not available`** — start Docker Desktop (or your
  Docker engine of choice) and re-run.
- **`kind create cluster` hangs or fails** — often a leftover cluster from
  a previous interrupted run; check `kind get clusters` and
  `kind delete cluster --name <name>` any `pilot-solar-open2-*` entries,
  then retry.
- **Helm install times out waiting for the pod** — check
  `kubectl --context kind-pilot-solar-open2-<pid> get pods -n hermes-agent`
  and `kubectl ... describe pod ...`; usually an image-pull hiccup on a
  fresh cluster, safe to just re-run.
- **Method A or B fails with what looks like a rate limit** — this repo's
  cases share one Upstage account; the script already retries five times
  with a 30s backoff, matching every other case.

## Try it by hand

Once the prerequisites above are installed, this is the same install the
script makes, runnable directly (run from inside
`07-hermes-agent-helm-solar-open2/`):

```bash
kind create cluster --name my-solar-open2-test --wait 90s

helm upgrade --install hermes-agent \
  oci://ghcr.io/jyje/hermes-agent-helm/hermes-agent --version 0.12.0 \
  --kube-context kind-my-solar-open2-test \
  --namespace hermes-agent --create-namespace \
  -f values-solar-open2.yaml \
  --set-string env.UPSTAGE_API_KEY='up_...' \
  --wait

helm test hermes-agent -n hermes-agent \
  --kube-context kind-my-solar-open2-test
kubectl --context kind-my-solar-open2-test \
  logs -n hermes-agent -l app.kubernetes.io/component=test --tail=-1

kind delete cluster --name my-solar-open2-test
```
