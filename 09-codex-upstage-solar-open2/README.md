# Case 09 — Solar Open 2 x Codex (via LiteLLM bridge)

[English](README.md) / [한국어](README-ko.md)

[← back to repo overview](../README.md)

**Status:** Verified — promoted from an unnumbered draft on 2026-08-03
after live local re-verification of both **solar-open2** and
**solar-pro4** through the LiteLLM Responses-API bridge: a raw
`/v1/responses` request and a full `codex exec` round trip both passed
for each model (see `../logs/local-verification/2026-08-03/case-09-codex-*.log`).
Codex still has no officially supported way to point at a custom
OpenAI-compatible endpoint directly, so this case exists specifically to
verify the bridge, not a direct integration. One caveat found during
re-verification: a prompt that triggers Codex's file-read tool currently
hits an unrelated `error=unsupported call: read_file` in Codex CLI
`0.146.0`'s own tool router (not present in `0.144.5`, this case's
original verification version) — independent of Solar Open 2/Pro4 or the
proxy; a tool-free prompt completes the full agentic loop cleanly on both
models.

## Goal

Determine whether the OpenAI Codex CLI can run an agentic coding task on
Upstage's **Solar Open 2** model, and publish a small, reproducible setup only
if its protocol bridge is verified end to end.

## Official compatibility finding

**Direct configuration: no.** The required protocols do not currently match:

| Product | Official interface relevant to this case |
| --- | --- |
| Upstage | Its API-key console demonstrates `client.chat.completions.create(...)` with `base_url="https://api.upstage.ai/v1"`. |
| Codex | Its custom model-provider reference says `wire_api = "responses"` is the only supported provider protocol (and is the default). |

Consequently, this apparently plausible configuration is not a supported
solution:

```toml
# This is deliberately NOT a working direct configuration.
[model_providers.upstage]
base_url = "https://api.upstage.ai/v1"
env_key = "UPSTAGE_API_KEY"
```

Codex will send Responses API requests. Upstage's published Solar API
recipe uses Chat Completions instead. A Base URL does not translate
between those wire protocols, and Upstage's documentation does not
publish a direct Codex or Responses API setup to close that gap.

Sources: [Upstage API key console — Chat example](https://console.upstage.ai/api-keys?api=chat),
[Codex custom-provider configuration](https://developers.openai.com/codex/config-advanced), and
[Codex configuration reference](https://developers.openai.com/codex/config-reference).

The current Upstage console example names `solar-pro3`, while this repo's
earlier cases use `solar-open2`. This case must list the account-enabled
model ID during its live verification; it must not assume an older model ID
remains available merely because the protocol bridge works.

## Planned bridge

The viable path to test is:

```text
Codex (Responses API) → protocol-converting proxy → Upstage (Chat Completions API) → Solar Open 2
```

LiteLLM provides this bridge. Its merged `use_chat_completions_api`
feature (or the equivalent `openai/chat_completions/<model>` model prefix
used by this case) forces `/responses → /chat/completions` translation
for a custom OpenAI-compatible upstream.

The proxy must still prove the full tool and streaming path against
Upstage in a live run.

After a bridge is running, Codex will need a *named custom provider* — not a
replacement `[model_providers.openai]` table, because `openai` is reserved by
Codex:

```toml
model = "solar-open2"
model_provider = "solar_proxy"

[model_providers.solar_proxy]
name = "Solar Open 2 through LiteLLM"
base_url = "http://127.0.0.1:PORT/v1"
env_key = "LITELLM_MASTER_KEY"
wire_api = "responses"
```

`PORT` is intentionally a placeholder. It is the local proxy's listening
port, not an Upstage endpoint. Codex uses `LITELLM_MASTER_KEY` only to
authenticate to LiteLLM; LiteLLM alone receives `UPSTAGE_API_KEY`. Keep both
in the environment or a secret store; never place either in `config.toml`.

The runnable templates are [`config/litellm-config.yaml`](config/litellm-config.yaml)
and [`config/codex.config.toml.template`](config/codex.config.toml.template). They use Upstage's
`https://api.upstage.ai/v1/solar` API base URL and the
`openai/chat_completions/solar-open2` LiteLLM model prefix.

## Run the Docker proxy

The selected deployment is Docker. Start the local-only proxy in one terminal:

```bash
export UPSTAGE_API_KEY="..."
./scripts/run-proxy-docker.sh
```

It binds only `127.0.0.1:4000`, uses the official LiteLLM image, and removes
the container when stopped. In another terminal, copy
`config/codex.config.toml.template` to `$CODEX_HOME/config.toml`, set the same
`LITELLM_MASTER_KEY` if you changed its default, then run `codex`.

## Verification criteria

This case was promoted to Verified once it demonstrated:

1. ✅ A non-interactive `codex exec` response using `model = "solar-open2"`
   (and, as of 2026-08-03, `solar-pro4` too).
2. ⚠️ A filesystem tool turn that reads a known local file and reports a
   fact from it — blocked on 2026-08-03 by an unrelated Codex CLI
   `0.146.0` tool-router bug (`error=unsupported call: read_file`), not a
   Solar Open 2/Pro4 or bridge issue. Worth re-attempting on a future
   Codex release.
3. ✅ Correct proxy handling for streamed output and at least one
   tool-call/tool-result cycle (the harmless `noop` function call in the
   raw bridge check).
4. ✅ A repeatable `scripts/verify.sh` and matching GitHub Actions workflow
   that reuse the repository's `UPSTAGE_API_KEY` secret.

Run the live gate with `UPSTAGE_API_KEY` set:

```bash
./scripts/verify.sh
```

It starts LiteLLM, checks a raw `/v1/responses` bridge request, then launches
`codex exec` in an isolated `CODEX_HOME`. The matching GitHub Actions workflow
reuses the repository's `UPSTAGE_API_KEY` secret.

## Verification result

On 2026-07-20, this configuration was first verified with Codex CLI
`0.144.5`, the official LiteLLM Docker image, and `solar-open2`. A raw
bridged Responses request returned `bridge-ready`, and Codex returned
`codex-ready` from an empty, read-only temporary directory.

One LiteLLM bridge limitation was observed: a tool-less Responses request is
translated with `tools: []`, which Upstage rejects as an empty array. The
verification probe therefore includes a harmless `noop` function definition.

**Re-verified locally on 2026-08-03** with Codex CLI `0.146.0`, against
both `solar-open2` and `solar-pro4`, reusing this repo's
`docker/` litellm-proxy image (a second instance on port 4001, configured
with the `openai/chat_completions/<model>` prefix for both models — full
logs in `../logs/local-verification/2026-08-03/case-09-codex-solar-open2.log`
and `case-09-codex-solar-pro4.log`):

| Check | solar-open2 | solar-pro4 |
| --- | --- | --- |
| Raw `/v1/responses` bridge request → `bridge-ready` | ✅ | ✅ |
| `codex exec` full round trip (tool-free prompt) → `codex-ready` | ✅ | ✅ |
| `codex exec` with a file-read tool call | ❌ (Codex 0.146.0 tool-router bug, see Status) | not re-tested (same Codex binary) |

Solar Pro4 in particular has no model mapping on Upstage's own
Anthropic-compatible endpoint (see Case 01/03's findings), so this
Responses-API bridge is the same kind of fix for Codex that
[`docker/`](../docker/)'s Anthropic-Messages bridge is for Claude Code.

See the repo-level [`PLAN.md`](../PLAN.md) for the wider experiment plan.
