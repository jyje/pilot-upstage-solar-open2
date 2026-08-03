# LiteLLM proxy — Anthropic-shaped bridge to Upstage

[← back to repo overview](../README.md)

Unnumbered, not a Case: a small local dev utility, not a portfolio
experiment. Cases 01 and 03 (Claude Code, the Claude Agent SDK) use it to
locally verify `solar-pro4` — see
[`../logs/local-verification/`](../logs/local-verification/) for the
captured transcripts. Case 09 (Codex) hits the same underlying gap but
needs LiteLLM's Responses API bridge instead of this one's Anthropic
Messages bridge, so it ships its own separate, self-contained LiteLLM
setup at
[`../09-codex-upstage-solar-open2/config/`](../09-codex-upstage-solar-open2/config/)
rather than reusing this directory.

## Why this exists

Upstage's own Anthropic Messages-compatible endpoint (the one Claude Code,
`claude-upstage`, and this repo's Case 01 talk to directly) doesn't have
**`solar-pro4`** mapped on it — a `[codex#01] pilot-upstage-solar-open2`
Codex session and this repo's own Case 01 work found the model responds
fine over Upstage's OpenAI-compatible Chat Completions endpoint, but not
over the Anthropic one. `solar-open2` isn't affected; it's already
verified directly in Case 01.

[LiteLLM](https://github.com/BerriAI/litellm) proxy exposes its own
`/v1/messages` route that speaks the Anthropic Messages API on the
client-facing side, no matter what protocol the underlying model actually
needs — so pointing an Anthropic-format client at this proxy instead of
Upstage directly, with the proxy itself calling Upstage over Chat
Completions underneath, closes that gap for `solar-pro4` (and works for
`solar-open2` too, verified here as a control).

```text
Claude Code (Anthropic Messages) → litellm-proxy → Upstage (Chat Completions) → solar-open2 / solar-pro4
```

## Setup

```bash
cd docker
cp .env.sample .env
# edit .env: set UPSTAGE_API_KEY, optionally change LITELLM_MASTER_KEY
docker compose up -d
```

## Point a client at it

```bash
export ANTHROPIC_BASE_URL="http://127.0.0.1:4000"
export ANTHROPIC_AUTH_TOKEN="$LITELLM_MASTER_KEY"   # from .env, default sk-local-solar-proxy
export ANTHROPIC_MODEL="solar-pro4"                 # or solar-open2

claude -p "hello"
```

## Verify

```bash
UPSTAGE_API_KEY="..." ./verify.sh
```

Starts the proxy, waits for `/health/liveliness`, then sends a raw
`/v1/messages` request for both `solar-open2` and `solar-pro4` and checks
for a real response from each — confirming the bridge itself works
independent of whether Upstage ever maps `solar-pro4` on its own
Anthropic-compatible endpoint.

## Finding: LiteLLM's `/v1/messages` needs an explicit opt-out to reach a Chat-Completions-only backend

This LiteLLM image's `/v1/messages` route defaults to bridging **any**
`openai`-provider model through the **Responses API** internally, not
Chat Completions — confirmed live: with a plain `openai/<model>` mapping,
every request 404'd with `OpenAIException - 404 page not found`, because
Upstage has no `/responses` endpoint at all (Chat Completions is its only
documented surface — the same gap
[Case 09](../09-codex-upstage-solar-open2/) hits from Codex's own
Responses API, on the client side instead of here).

The fix is `litellm_settings.use_chat_completions_url_for_anthropic_messages: true`
(already set in [`litellm-config.yaml`](litellm-config.yaml)) — LiteLLM's
own escape hatch (see
`_should_route_to_responses_api` in
`litellm/llms/anthropic/experimental_pass_through/messages/handler.py`)
that routes `/v1/messages` through `litellm.acompletion()` for every
provider instead. Confirmed live both ways: without the flag, a request
with an intentionally-invalid key still 404'd (never reached Upstage);
with it, the same request got a real `401 Your API key is invalid` back
from Upstage — proof the bridge reaches the right endpoint, independent
of whether the key itself is valid.

## Notes

- `LITELLM_MASTER_KEY` only authenticates a client to this local proxy —
  it's never sent to Upstage. `UPSTAGE_API_KEY` is the only credential the
  proxy forwards upstream.
- `.env` is gitignored repo-wide; only `.env.sample` is committed.
- This directory itself stays outside the numbered Case list — it's
  shared dev plumbing, not an independent, presentable experiment. See
  [`../09-codex-upstage-solar-open2/`](../09-codex-upstage-solar-open2/)
  for the same LiteLLM-bridge idea applied to Codex's Responses API
  instead of Claude Code's Anthropic Messages API, as its own numbered
  Case with its own self-contained proxy config.
