# Case 09 — Use Case Guide

[English](REPRODUCE.md) / [한국어](REPRODUCE-ko.md)

[← back to this case's README](README.md) · [← all cases' use case guides](../docs/REPRODUCE.md)

Goal: run OpenAI's Codex CLI against Solar Open 2 (and Solar Pro4)
through a local LiteLLM proxy that bridges Codex's Responses API to
Upstage's Chat Completions endpoint.

Full narrative, findings, and verified transcripts: [`README.md`](README.md).

Haven't set up `UPSTAGE_API_KEY` or read about the shared Tier-0 rate
limit yet? Start at [`docs/REPRODUCE.md`](../docs/REPRODUCE.md) first —
this page assumes both are already handled.

## What you need

- Codex CLI: `npm install -g @openai/codex`
- LiteLLM proxy CLI: `pip install 'litellm[proxy]'`

## Run it

From the repo root, `cd` into this directory first, then run its script:

```bash
cd 09-codex-upstage-solar-open2
export UPSTAGE_API_KEY="up_..."
./scripts/verify.sh
```

`SOLAR_MODEL` picks the model (default `solar-open2`; also try
`solar-pro4`, which has no mapping on Upstage's own Anthropic-compatible
endpoint but works fine through this bridge):

```bash
SOLAR_MODEL=solar-pro4 UPSTAGE_API_KEY="up_..." ./scripts/verify.sh
```

The script starts a bare `litellm` proxy on `127.0.0.1:4000`, points an
isolated `$CODEX_HOME` at it (never touching your real Codex config),
and tears both down on exit.

## What success looks like

```
== Model under test: solar-open2 ==
✓ LiteLLM proxy is ready
✓ LiteLLM translated a Responses request for solar-open2
✓ Codex completed a full round trip through LiteLLM and solar-open2
```

## If something goes wrong

- **A prompt that reads a file fails with `unsupported call: read_file`**
  — a known Codex CLI `0.146.0` tool-router regression, not a Solar
  Open 2/Pro4 or bridge issue (see `README.md`'s Status/Verification
  result). `scripts/verify.sh` avoids it with a tool-free prompt.
- **`litellm: command not found`** — install with
  `pip install 'litellm[proxy]'`, not the bare `pip install litellm`.
