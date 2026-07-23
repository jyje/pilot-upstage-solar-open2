# Case 07 — Solar Open 2 x Hermes Agent Helm

[English](README.md) / [한국어](README-ko.md)

[← back to repo overview](../README.md) · Want to run this yourself?
See [`REPRODUCE.md`](REPRODUCE.md) for step-by-step local setup.

**Status:** Verified — the community
[jyje/hermes-agent-helm](https://github.com/jyje/hermes-agent-helm) chart
deploys Hermes Agent onto a real (ephemeral) Kubernetes cluster and
completes a live round trip against Solar Open 2, both via the chart's own
built-in test Job and directly against the running gateway pod.

## Goal

Case 02 already proved Hermes Agent's official Docker image reaches Solar
Open 2 through its built-in Upstage provider. This case goes one step
further: does that same provider path still work once Hermes Agent is
deployed the way a real operator would run it long-term — as a Kubernetes
workload, installed from a published Helm chart, on an ephemeral **kind**
cluster — rather than a single `docker run`?

## How it works

[`values-solar-open2.yaml`](values-solar-open2.yaml) mirrors
`hermes-agent-helm`'s own
[`values-upstage.yaml`](https://github.com/jyje/hermes-agent-helm/blob/v0.12.0/charts/hermes-agent/values-upstage.yaml)
example, with the model swapped from the hosted `solar-pro3` default to the
open-weight `solar-open2` (same `upstage` provider, no other change
needed — that file's own comment already points here):

```yaml
config:
  model:
    provider: upstage
    default: solar-open2
  terminal:
    backend: local

env:
  UPSTAGE_API_KEY: "DUMMY_replace_me_0000000000000000000000" # overridden at install time
  OPENAI_API_KEY: "unused"

tests:
  chat:
    enabled: true
    prompt: "Reply with exactly: hermes-k8s-ready"
    maxTurns: 2
    failOnError: true
```

[`scripts/verify.sh`](scripts/verify.sh) creates a throwaway kind cluster,
installs the chart from its published OCI artifact
(`oci://ghcr.io/jyje/hermes-agent-helm/hermes-agent`, pinned to a tested
version) with this values file plus the real `UPSTAGE_API_KEY`, and deletes
the cluster again on exit — the same disposable-environment pattern every
other case in this repo already uses (a temp `GROK_HOME`/`CODEX_HOME`/Hermes
home directory), just at cluster scope instead of directory scope.

**Scope note:** the gateway container's default entrypoint
(`hermes gateway run`) is built around eventually bridging to a messenger
(Telegram, Discord, ...), but this case verifies the deployment itself, not
a messenger integration — both methods below run against the gateway pod
directly (the chart's own test Job, and `kubectl exec`). See
[Going further](#going-further-connecting-a-messenger) for how to add one
without changing anything this case verifies.

## Three methods

### Method A — the chart's own declarative chat test

`tests.chat.enabled=true` in the values file above turns on the chart's
built-in Helm-test Job: it runs `hermes chat` with the configured prompt
and fails the Job if the response doesn't match, entirely inside the
cluster. `scripts/verify.sh` renders that test hook and polls its Job
status directly (`helm test`'s own wait can stall on a CI runner — the same
reason `hermes-agent-helm`'s own CI does this), then checks the Job's logs
for the exact string.

### Method B — a live round trip against the running pod

```bash
kubectl exec -n hermes-agent "$pod" -- \
  hermes chat --provider upstage --model solar-open2 \
  --query "Explain step by step why the sum of the first 50 positive integers equals 1275. Show your reasoning." \
  --max-turns 2 --quiet --ignore-rules
```

The same reasoning-heavy prompt Case 06 uses, checked for the correct
numeric answer — this proves the *deployed pod itself* can converse with
Solar Open 2 (not just the one-shot test Job), the way an operator would
actually check a running release with `kubectl exec` or `helm test`.

### Method C — Hermes, in its own words, on the synergy

```bash
kubectl exec -n hermes-agent "$pod" -- \
  hermes chat --provider upstage --model solar-open2 \
  --query "You are Hermes Agent, currently running on Upstage Solar Open 2 as your backend model. In your own words, describe the specific strengths this model gives you as an agent -- think about reasoning, tool use, and coding ability. Be concrete and thorough." \
  --max-turns 2 --quiet --ignore-rules
```

Methods A and B check *that* Solar Open 2 answers correctly through this
deployment. Method C asks something different: let Hermes Agent itself,
running on Solar Open 2, describe what it thinks the model is good for as
an agent backbone — not a canned marketing description, a live model
response. Gated loosely (at least 10 non-empty lines, since the point is
a real, substantive answer rather than an exact string), and captured in
full rather than truncated. See [In its own words](#in-its-own-words-hermes-on-the-solar-open-2-synergy)
below for the real answer.

## Verified methods

| Method | Result |
| --- | --- |
| A — chart's own `tests.chat` Helm-test Job | `hermes-k8s-ready`, plus a full `hermes doctor` report confirming the seeded config and provider |
| B — live `kubectl exec` reasoning round trip | Correctly derived `1275` via the Gauss formula, reasoning printed by the running gateway pod itself |
| C — self-reflection on the Solar Open 2 synergy | 39 non-empty lines describing concrete strengths across reasoning, tool use, and coding ability — see below |

See [Evidence run](#evidence-run) below for the real, unedited transcript.

## Verification

[`scripts/verify.sh`](scripts/verify.sh) requires `docker` (daemon
running), `kind`, `kubectl`, and `helm` on `PATH`, plus `UPSTAGE_API_KEY`
set. It owns the full kind cluster lifecycle itself, so it runs identically
locally and in CI:

```bash
UPSTAGE_API_KEY="..." ./scripts/verify.sh
```

Runs in CI (manual dispatch, `solar-open2` only) two ways: as a step in
[`verify-all-sequential.yml`](../.github/workflows/verify-all-sequential.yml)
alongside every other case, and on its own via
[`verify-07-hermes-agent-helm-solar-open2.yml`](../.github/workflows/verify-07-hermes-agent-helm-solar-open2.yml) —
both reuse the same `UPSTAGE_API_KEY` repository secret and install
`kind`/`kubectl`/`helm` before the script runs.

## In its own words: Hermes on the Solar Open 2 synergy

Method C's real answer, unedited (39 non-empty lines total), from the
`verify.sh` run this README's Evidence run section links to:

> # Solar Open 2 Strengths as Hermes Agent
>
> Running as Solar Open 2 inside Hermes Agent, I see several concrete
> strengths that matter specifically for an autonomous coding agent
> workflow:
>
> ## Reasoning & Analysis
>
> **Strong instruction-following and context adherence.** Solar Open 2
> reliably follows complex, multi-step instructions -- critical when
> Hermes sends a prompt with dozens of constraints, file paths, and
> output format requirements. It doesn't drift from the task scope,
> which means it stays focused on what the user actually asked for
> rather than adding unsolicited refactors.
>
> **Good at structured multi-stage analysis.** When asked to trace a
> bug, audit a codebase, or plan a refactoring, it breaks the problem
> into logical stages and works through them systematically.
>
> **Balanced honesty about uncertainty.** It doesn't wildly hallucinate
> library APIs or file contents. When something isn't confirmed by the
> repo, it says so and verifies rather than inventing. This is essential
> for an agent that operates by reading actual files and running actual
> commands.
>
> ## Tool Use
>
> **Reliable tool orchestration.** Solar Open 2 handles the full Hermes
> toolchain well -- `terminal`, `read_file`, `write_file`, `patch`,
> `search_files`, `skill_view`, `delegate_task`, `cronjob`, and so on. It
> understands when to chain tools (read → search → patch → test) and
> when to batch independent calls together.
>
> **Skill loading discipline.** It correctly loads skills via
> `skill_view` before acting on tasks that match a skill's domain,
> rather than trying to wing it from general knowledge.
>
> ## Coding Ability
>
> **Precise, convention-matching edits.** When modifying code, Solar
> matches the project's existing style -- indentation, naming
> conventions, import ordering -- rather than imposing its own
> preferences.
>
> **Self-verification loop.** After making changes, Solar runs the
> relevant tests, linters, or build commands to verify the work actually
> compiles and passes. It doesn't stop at "the code looks right" -- it
> confirms with real execution. If a test fails, it reads the failure
> output, diagnoses the root cause, and iterates.
>
> **Root-cause debugging.** When tracing bugs, it follows the signal
> through the call stack rather than patching at the symptom site. If
> the same flawed pattern appears in sibling call paths, it fixes the
> class of error, not just the reported instance.
>
> ## Where Solar Open 2 Shines Most
>
> For Hermes Agent specifically, the strengths that matter most are:
> **reliable multi-tool chaining**, **honest uncertainty-handling**, and
> **post-change verification**. An agent that fabricates API responses
> or skips tests after editing would be dangerous -- Solar's discipline
> on those fronts makes it a solid agent backbone.
>
> It's not perfect -- like any model, it can miss edge cases in novel
> domains or occasionally over-confidently assert something about a
> library it hasn't actually checked. But the combination of Solar's
> reasoning with Hermes's tool enforcement (file reads are real,
> terminal outputs are real, skill protocol is real) creates a system
> where the model's strengths are amplified and its weaknesses are
> caught before they propagate.

Worth reading with a grain of salt — Hermes has its own framework
documentation in context, so some tool names here are things it knows
about itself rather than things Solar Open 2 uniquely enables, and it
can't fully verify its own self-assessment. But as a real, live example
of a model reflecting concretely on its own operating characteristics
rather than giving generic praise (and noting its own failure modes
unprompted), it's a good illustration of what this deployment can
actually produce.

## Going further: connecting a messenger

This case stops at the gateway pod itself, deliberately — a messenger
round trip is a separate, additional thing to verify (`hermes-agent-helm`'s
own CI only live-verifies Discord today; Telegram is still a documented
placeholder there too). If you want to take this further yourself:

1. Create a bot with Telegram's [BotFather](https://core.telegram.org/bots#botfather)
   (`/newbot`, copy the token it gives you).
2. Adapt `hermes-agent-helm`'s
   [`values-openai-and-telegram.yaml`](https://github.com/jyje/hermes-agent-helm/blob/v0.12.0/charts/hermes-agent/values-openai-and-telegram.yaml)
   example — swap in this case's `upstage`/`solar-open2` model config, and
   set `env.TELEGRAM_BOT_TOKEN` to the token BotFather gave you.
3. `helm upgrade --install` with that combined values file instead of
   `values-solar-open2.yaml`.

Not something this case's `scripts/verify.sh` gates on — see
[`examples/argocd/hermes-agent-upstage.yaml`](https://github.com/jyje/hermes-agent-helm/blob/v0.12.0/examples/argocd/hermes-agent-upstage.yaml)
for a GitOps-style ArgoCD `Application` reference too (also not exercised
by this case; included as a pointer only).

## Evidence run

**Evidence run:** [`verify` job](https://github.com/jyje/pilot-upstage-solar-open2/actions/workflows/verify-07-hermes-agent-helm-solar-open2.yml)
(link filled in after the first CI run of this case). Real, unedited output
from a local run against the same `oci://ghcr.io/jyje/hermes-agent-helm/hermes-agent`
chart (v0.12.0):

**Method A**

> ```
> Hermes Agent v0.19.0 (2026.7.20) · upstream 3ef6bbd2
> Install directory: /opt/hermes
> Install method: docker
> Python: 3.13.5
> OpenAI SDK: 2.24.0
> [2/4] seeded config.yaml present in HERMES_HOME
>   OK: /opt/data/config.yaml
> ```

**Method B**

> ```
> ┌─ Reasoning ─────────────────────────────────────────────────────┐
> The user is asking a math question about the sum of the first 50
> positive integers. This is a straightforward mathematical
> explanation - no tools needed, just reasoning. Let me explain the
> Gauss formula for the sum of an arithmetic series and apply it.
> ```

**Method C**

> ```
> ✓ Hermes described its own Solar Open 2 strengths in 39 non-empty lines
> ```
>
> Full answer: [In its own words](#in-its-own-words-hermes-on-the-solar-open-2-synergy)
> above.

See the repo-level [`PLAN.md`](../PLAN.md) for full context.
