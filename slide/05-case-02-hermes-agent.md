<!-- slidev:enable-auto-animate -->
# Case 02 — Solar Open 2 × Hermes Agent

## Official Docker image, built-in Upstage provider

<v-click>

### Official-support finding

Hermes Agent v0.18.2 ships an **`upstage` provider** in its official Docker image
(`solar` is an alias). No local plugin, no LiteLLM proxy, no source patch.

```yaml
model:
  provider: upstage
  default: solar-open2
```

</v-click>

<v-click>

### Important distinction

| Hermes provider support | Upstage model availability |
|---|---|
| ✅ Hermes officially recognizes Solar Open model family | ℹ️ Upstage console examples use `solar-pro3` |
| ✅ Bundled provider routes `solar-open*` to Upstage OpenAI-compatible API | 🔑 Authenticated round-trip is the real authority |

</v-click>

<v-click>

### Verification methods

1. **Version check** — image reports Hermes Agent v0.18.2
2. **`hermes doctor`** — accepts Upstage config, reports `Upstage Solar` healthy
3. **`hermes chat`** — non-interactive round trip returns `hermes-ready`

```bash
hermes chat \
  --provider upstage --model solar-open2 \
  --query "Reply with exactly: hermes-ready" \
  --max-turns 2 --quiet --ignore-rules
```

</v-click>

<v-click>

## Result

Full, untruncated reasoning trace from Solar Open 2 before it settles on the
required reply — proving the model runs through Hermes's actual agentic harness,
not a raw endpoint.

**Verified locally (2026-07-20) and in CI (2026-07-23).**

</v-click>

<!--
Case 02 is a "Review" case: it validates that an existing official harness path
(Hermes Agent's built-in Upstage provider) works with Solar Open 2 without any
modification. The `hermes-ready` check comes back with visible reasoning, confirming
the full agentic loop, not just a ping.
-->
