# Codex via Upstage Solar Open 2

[English](README.md) / [한국어](README-ko.md)

[← back to repo overview](../README.md)

**Status:** Paused (draft, unnumbered) — Codex has no officially supported
way to point at a custom OpenAI-compatible endpoint yet, so this stays out
of the numbered Case list until that changes. Basic path verified: Docker
LiteLLM successfully routed a Codex response to Solar Open 2. A direct
Codex → Upstage Base URL override remains unsupported; this case verifies
the bridge instead. Workspace-file and tool-result cycles remain pending.

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
and [`config/codex.config.toml`](config/codex.config.toml). They use Upstage's
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
`config/codex.config.toml` to `$CODEX_HOME/config.toml`, set the same
`LITELLM_MASTER_KEY` if you changed its default, then run `codex`.

## Verification criteria

Before this case changes to Verified, the implementation must demonstrate:

1. A non-interactive `codex exec` response using `model = "solar-open2"`.
2. A filesystem tool turn that reads a known local file and reports a fact
   from it.
3. Correct proxy handling for streamed output and at least one tool-call/tool-
   result cycle.
4. A repeatable `scripts/verify.sh` and matching GitHub Actions workflow that
   reuse the repository's `UPSTAGE_API_KEY` secret.

Run the live gate with `UPSTAGE_API_KEY` set:

```bash
./scripts/verify.sh
```

It starts LiteLLM, checks a raw `/v1/responses` bridge request, then launches
`codex exec` in an isolated `CODEX_HOME`. The matching GitHub Actions workflow
reuses the repository's `UPSTAGE_API_KEY` secret.

## Verification result

On 2026-07-20, this configuration was verified with Codex CLI `0.144.5`, the
official LiteLLM Docker image, and `solar-open2`. A raw bridged Responses
request returned `bridge-ready`, and Codex returned `codex-ready` from an
empty, read-only temporary directory.

One LiteLLM bridge limitation was observed: a tool-less Responses request is
translated with `tools: []`, which Upstage rejects as an empty array. The
verification probe therefore includes a harmless `noop` function definition.
This does not establish full tool-cycle compatibility; that must be verified
separately before the case is marked Verified.

See the repo-level [`PLAN.md`](../PLAN.md) for the wider experiment plan.
