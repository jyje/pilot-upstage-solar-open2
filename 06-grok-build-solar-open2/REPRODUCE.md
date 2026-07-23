# Case 06 — Use Case Guide

[English](REPRODUCE.md) / [한국어](REPRODUCE-ko.md)

[← back to this case's README](README.md) · [← all cases' use case guides](../docs/REPRODUCE.md)

Goal: run xAI's Grok Build CLI against Solar Open 2 as a custom model
provider — no bridge, no proxy, just Grok Build's own "any custom
model" config mechanism.

Full narrative, findings, and verified transcripts: [`README.md`](README.md).

Haven't set up `UPSTAGE_API_KEY` or read about the shared Tier-0 rate
limit yet? Start at [`docs/REPRODUCE.md`](../docs/REPRODUCE.md) first —
this page assumes both are already handled.

## What you need

- Grok Build's `grok` CLI: `curl -fsSL https://x.ai/cli/install.sh | bash`
  (or `brew install --cask grok-build` on macOS)

No Docker, no Node, no Python.

## Run it

From the repo root, `cd` into this directory first, then run its script:

```bash
cd 06-grok-build-solar-open2
export UPSTAGE_API_KEY="up_..."
./scripts/verify.sh
```

The script generates a throwaway `config.toml` and points `$GROK_HOME`
at it for the duration of the run — it never touches your real
`~/.grok`.

## What success looks like

```
== Model under test: solar-open2 ==
...
grok-solar-ready
✓ grok completed a live solar-open2 round trip
...
1275
✓ solar-open2 reasoned through the sum correctly
...
def is_prime
✓ solar-open2 wrote the requested function
...
(reproduced: Upstage dropped the tool_call function name, same as Case 05's Finding 2)
✓ All checks passed.
```

That last "reproduced" line is expected — it's a known, documented
finding (see [`README.md`](README.md)), not a failure. The script only
fails if Methods A, B, or C themselves don't check out.

## If something goes wrong

- **`grok CLI not found`** — run the install command above, then make
  sure `grok --version` works in a fresh shell.
- **`unknown model id`** — almost always means a custom model was added
  to a project-local `.grok/config.toml` instead of the user-level one.
  This script avoids that entirely via `$GROK_HOME`; if you're
  experimenting by hand, see [Try it by hand](#try-it-by-hand) below.

## Try it by hand

Once `grok` is installed, this is the same setup the script makes,
runnable directly for your own prompts (run from inside
`06-grok-build-solar-open2/`):

```bash
grok_home="$(mktemp -d)"
sed "s/SOLAR_MODEL_PLACEHOLDER/solar-open2/g" \
  config/config.toml.template > "$grok_home/config.toml"

GROK_HOME="$grok_home" grok -p "Reply with exactly: grok-solar-ready" -m solar-open2

rm -rf "$grok_home"
```
