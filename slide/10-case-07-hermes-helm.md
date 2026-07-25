<!-- slidev:enable-auto-animate -->
# Case 07 — Solar Open 2 × Hermes Agent Helm

## Kubernetes deployment, ephemeral kind cluster

<v-click>

### Goal

Case 02 proved Hermes Agent's Docker image reaches Solar Open 2.
**Does the same provider path work when deployed the way a real operator runs it — as a
Kubernetes workload, installed from a published Helm chart, on an ephemeral kind cluster?**

</v-click>

<v-click>

### How it works

[`values-solar-open2.yaml`](https://github.com/jyje/pilot-upstage-solar-open2/blob/main/07-hermes-agent-helm-solar-open2/values-solar-open2.yaml)
mirrors `hermes-agent-helm`'s own `values-upstage.yaml`, with the model swapped from
`solar-pro3` to `solar-open2` (same `upstage` provider, no other change).

```yaml
config:
  model:
    provider: upstage
    default: solar-open2
  terminal:
    backend: local

env:
  UPSTAGE_API_KEY: "DUMMY_..."  # overridden at install time

tests:
  chat:
    enabled: true
    prompt: "Reply with exactly: hermes-k8s-ready"
    maxTurns: 2
    failOnError: true
```

The chart is installed from its published OCI artifact:
`oci://ghcr.io/jyje/hermes-agent-helm/hermes-agent --version 0.12.0`

</v-click>

<v-click>

### Scope note

The gateway's default entrypoint (`hermes gateway run`) is built around bridging to a
messenger (Telegram, Discord). **This case verifies the deployment itself — not a
messenger integration.** Both methods run against the gateway pod directly.

> See [Going further](#going-further) for how to add Telegram/Discord without
> changing what this case verifies.

</v-click>

<v-click>

### Three methods

| Method | What it proves |
|---|---|
| **A — chart's `tests.chat`** | Declarative Helm-test Job runs `hermes chat` inside the cluster, gated on exact string |
| **B — `kubectl exec`** | Live round trip against the running pod with a reasoning prompt (must return `1275`) |
| **C — self-reflection** | Hermes Agent itself describes Solar Open 2's strengths for agentic work |

</v-click>

<v-click>

### Verified results

| Method | Result |
|---|---|
| A — `tests.chat` Job | `hermes-k8s-ready` + full `hermes doctor` report |
| B — `kubectl exec` reasoning | Correctly derived `1275` via Gauss formula |
| C — self-reflection | 76 non-empty lines on reasoning, tool use, coding ability |

</v-click>

<v-click>

### Going further: connecting a messenger

1. Create a bot with Telegram's [BotFather](https://core.telegram.org/bots#botfather)
2. Adapt `hermes-agent-helm`'s [`values-openai-and-telegram.yaml`](https://github.com/jyje/hermes-agent-helm/blob/v0.12.0/charts/hermes-agent/values-openai-and-telegram.yaml) — swap in `upstage`/`solar-open2` config, set `env.TELEGRAM_BOT_TOKEN`
3. `helm upgrade --install` with the combined values file

**Not gated by this case's verify script.** Also see [`examples/argocd/hermes-agent-upstage.yaml`](https://github.com/jyje/hermes-agent-helm/blob/v0.12.0/examples/argocd/hermes-agent-upstage.yaml) for an ArgoCD GitOps reference.

</v-click>

<!--
Case 07 is an "Extend" case: it pushes Solar Open 2 into the Kubernetes/Helm ecosystem.
The three methods (declarative test, live exec, self-reflection) mirror the pattern from
Cases 01 and 06. The messenger scope note is deliberate — a full Telegram/Discord
integration is a separate, additional verification.
-->
