# Case 08 — Use Case Guide

[English](REPRODUCE.md) / [한국어](REPRODUCE-ko.md)

[← back to this case's README](README.md) · [← all cases' use case guides](../docs/REPRODUCE.md)

Goal: run omp (oh-my-pi) against Solar Open 2 as a custom OpenAI-compatible
model provider — no bridge, no proxy, just omp's own `models.yml`
mechanism — then ask it to actually build a working app and check the
result functionally in a real browser.

Full narrative, findings, and verified transcripts: [`README.md`](README.md).

Haven't set up `UPSTAGE_API_KEY` or read about the shared Tier-0 rate
limit yet? Start at [`docs/REPRODUCE.md`](../docs/REPRODUCE.md) first —
this page assumes both are already handled.

## What you need

- omp: `curl -fsSL https://omp.sh/install | sh` (macOS/Linux — or
  `brew install can1357/tap/omp`, or
  `bun install -g @oh-my-pi/pi-coding-agent`)
- Node 18+ on `PATH` — Method D's functional check drives a real
  headless browser via Playwright

No Docker, no Python.

## Run it

From the repo root, `cd` into this directory first, then run its script:

```bash
cd 08-omp-solar-open2
export UPSTAGE_API_KEY="up_..."
./scripts/verify.sh
```

The script generates throwaway `models.yml`/`config.yml` files and
points `$PI_CODING_AGENT_DIR` at them for the duration of the run — it
never touches your real `~/.omp/agent`. On first run it also installs
its own Playwright dependency and downloads Chromium
(`scripts/node_modules/`, gitignored) — this can take a minute the
first time, and is a fast no-op afterward.

Method D (the Sudoku build) genuinely takes a few minutes, since it's
asking omp to write, read, and self-check a real file through its own
agentic loop rather than answer a one-line prompt — this is expected,
not a hang.

## What success looks like

```
== Model under test: upstage/solar-open2 ==
...
omp-solar-ready
✓ omp completed a live solar-open2 round trip
...
1275
✓ solar-open2 reasoned through the sum correctly
...
def is_prime
✓ solar-open2 wrote the requested function
...
✓ omp wrote an index.html for the Sudoku app
✓ found all 36 cell inputs with the expected id contract
✓ 18 given cells form a legal partial grid (no conflicts)
✓ computed a valid full solution consistent with the given cells
✓ #status shows "Solved!" with the solved class after a correct completion
✓ negative test passed: breaking a correct cell clears the "Solved!" status
✓ "New Puzzle" generated a different set of given cells (not hardcoded)

All Method D checks passed.

✓ All checks passed.
```

## If something goes wrong

- **`omp CLI not found`** — run the install command above, then make
  sure `omp --version` works in a fresh shell.
- **`400 Unrecognized request arguments supplied: store`** — this
  script's `config/models.yml.template` already sets
  `compat.supportsStore: false` to prevent this (see
  [`README.md`](README.md)'s first Finding); if you're experimenting by
  hand and hit this, you're missing that line.
- **Method D fails on the Playwright checks, not on omp itself** — that
  means omp finished and wrote a file, but the file doesn't actually
  behave correctly (wrong DOM contract, broken win detection, etc.).
  Open `scripts/verify.sh`'s temp `work_dir` output path from the
  failure message directly in a browser to see what was actually
  generated.
- **`node: command not found`** — install Node 18+ first; Method D's
  functional check can't run without it.

## Try it by hand

Once `omp` is installed, this is the same setup the script makes,
runnable directly for your own prompts (run from inside
`08-omp-solar-open2/`):

```bash
agent_dir="$(mktemp -d)"
sed "s/OMP_MODEL_PLACEHOLDER/solar-open2/g" \
  config/models.yml.template > "$agent_dir/models.yml"
sed "s/OMP_MODEL_PLACEHOLDER/solar-open2/g" \
  config/config.yml.template > "$agent_dir/config.yml"

PI_CODING_AGENT_DIR="$agent_dir" omp --print --auto-approve \
  --model "upstage/solar-open2" "Reply with exactly: omp-solar-ready"

rm -rf "$agent_dir"
```
