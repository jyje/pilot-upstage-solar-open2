# Case 08 — Solar Open 2 x omp

[English](README.md) / [한국어](README-ko.md)

[← back to repo overview](../README.md) · Want to run this yourself?
See [`REPRODUCE.md`](REPRODUCE.md) for step-by-step local setup.

**Status:** Verified — [omp (oh-my-pi)](https://github.com/can1357/oh-my-pi)
runs real prompts against Solar Open 2 as a custom model provider, and
actually builds a working, spec-compliant app when asked to. Methods A-C
pass in CI; Method D (the Sudoku build) is a multi-minute agentic build
that's verified locally instead and published as a playable app in
[`../gallery/`](../gallery/) rather than re-run on every CI pass. One
required, non-obvious fix: without `compat.supportsStore: false` on the
provider entry, every request 400s.

## Goal

Determine whether [omp](https://omp.sh) — a ~20k-star terminal coding
agent (forked from [Pi](https://github.com/badlogic/pi-mono)) that
markets itself as "IDE wired in" — can run against **Solar Open 2** as
a custom model provider, and whether that "IDE wired in" claim holds up
under a real, moderately complex build task, not just a one-line reply.

## How it works

omp reads custom provider/model definitions from
`$PI_CODING_AGENT_DIR/models.yml` (default `~/.omp/agent/models.yml`)
and the default model role from `$PI_CODING_AGENT_DIR/config.yml`:

```yaml
# models.yml
providers:
  upstage:
    baseUrl: https://api.upstage.ai/v1/solar
    api: openai-completions
    apiKey: UPSTAGE_API_KEY
    compat:
      supportsStore: false
    models:
      - id: solar-open2
        name: Solar Open 2 (Upstage)
        contextWindow: 1000000
        maxTokens: 8192
```

```yaml
# config.yml
modelRoles:
  default: upstage/solar-open2
```

`apiKey: UPSTAGE_API_KEY` is the literal env var *name*, not a
`$UPSTAGE_API_KEY` interpolation — omp resolves a custom provider's
`apiKey` as "env var name if one exists, else the literal string," so
the real secret never has to be written into the file itself.

[`scripts/verify.sh`](scripts/verify.sh) points `$PI_CODING_AGENT_DIR`
at a throwaway temp directory holding generated copies of both files,
instead of touching the real `~/.omp/agent` — the same isolation
pattern Case 02 uses for Hermes Agent's home directory and Case 06 uses
for `$GROK_HOME`.

## Finding: every request 400s without `compat.supportsStore: false`

The first attempt at Method A failed every time with:

```text
400 Unrecognized request arguments supplied: store
```

omp's `openai-completions` client defaults to sending `store: false` on
requests to any endpoint that doesn't look like a known non-standard
host — a parameter from OpenAI's own newer Chat Completions API for
server-side conversation storage. Upstage's endpoint doesn't recognize
it and rejects the whole request. omp's own docs
([`docs/models.md`](https://github.com/can1357/oh-my-pi/blob/main/docs/models.md))
document `compat.supportsStore` as exactly this toggle — setting it to
`false` on the provider entry fixes every method immediately. Without
this one line, Case 08 doesn't work at all.

## Finding: an underspecified win condition produced a fragile first attempt

Method D's prompt originally just said "when the board is full and has
no conflicts, show Solved!" On that wording, the app Solar Open 2 built
checked whether the filled board matched the *one specific solution*
it remembered from puzzle generation — not whether the board was
actually valid. A 6x6 puzzle with half its cells removed can have more
than one legal completion, so filling in a different, equally correct
solution (which is exactly what this case's Playwright check does,
since it solves the puzzle independently rather than reading the app's
own answer) left the app stuck reporting "not solved" on a genuinely
solved board.

Rewriting the requirement to explicitly say *"check the rules
dynamically, do not compare against a remembered solution array"*
fixed it on the very next attempt — the rebuilt app implements a real
per-row/column/box rule check and passes every method below, including
the negative test. Kept here because it's a real, observed data point
on how Solar Open 2 responds to spec precision on a coding task, not
just a note about prompt-writing.

## Four methods

### Method A — deterministic single-turn reply

```bash
omp --print --auto-approve --model "upstage/solar-open2" "Reply with exactly: omp-solar-ready"
```

A plain non-tool-using round trip through omp's headless mode
(`--print`), checked for an exact string.

### Method B — reasoning-heavy prompt

```bash
omp --print --auto-approve --model "upstage/solar-open2" "Explain step by step why the sum of the first 50 positive integers equals 1275. Show your reasoning."
```

Just Solar Open 2's own reasoning, checked for the correct numeric
answer.

### Method C — a small coding task

```bash
omp --print --auto-approve --model "upstage/solar-open2" "Write a Python function named is_prime(n) that returns True if n is a prime number and False otherwise. Include a brief docstring. Output only the code in a single fenced code block."
```

Checked for `def is_prime` in the response.

### Method D — a real development task: a working 6x6 Mini Sudoku app

```bash
omp --print --auto-approve --max-time 8m --model "upstage/solar-open2" "$(cat scripts/sudoku-prompt.txt)"
```

The other three methods only check that a string appears in a text
reply. Method D asks omp — via `write`/`edit`/`bash`, its own built-in
tools, no manual file-writing on this repo's side — to build a single
self-contained `index.html` implementing a playable 6x6 Sudoku (digits
1-6, 2x3 boxes): puzzle generation, live conflict highlighting, win
detection, and a "New Puzzle" button, with an exact DOM contract
(`#cell-R-C` inputs, `#status`, `#new-puzzle`) specified so the result
can be graded deterministically instead of by eye. See
[`scripts/sudoku-prompt.txt`](scripts/sudoku-prompt.txt) for the full
requirement text handed to the model verbatim.

[`scripts/verify-sudoku.mjs`](scripts/verify-sudoku.mjs) then opens the
real output file in headless Chromium (Playwright) and actually plays
it: reads all 36 cells, confirms the generated givens don't already
break the rules, solves the puzzle independently with a small
backtracking solver, fills in every editable cell through the real UI
(so the app's own listeners fire), confirms `#status` reports `Solved!`
with the `solved` class, then breaks one cell and confirms that status
clears — proving win detection isn't a no-op that always reports
success.

## Verified methods

| Method | Result |
| --- | --- |
| A — single-turn reply | `omp-solar-ready` |
| B — reasoning-heavy prompt | Correctly derived `1275` via the Gauss formula (full transcript in CI's own output) |
| C — coding task | A correct, working `is_prime(n)` implementation with docstring (full code in CI's own output) |
| D — build a working Sudoku app | Real `index.html`, opened in headless Chromium: correct puzzle generation, live conflict highlighting, working win detection, working "New Puzzle" — all verified functionally, not just by grepping the source |

See [Evidence run](#evidence-run) below for the real, unedited
transcript.

A note on what this case did *not* observe: unlike Cases 05/06, none of
omp's real tool calls here (Method D writes, reads, and shell-checks
its own output through omp's built-in tools) ever hit the Upstage
streamed `tool_call` function-name-drop bug documented in
[Case 05's Finding 2](../05-langchain-openwiki-solar-open2/README.md#finding-2-solar-open-2-drops-the-tool_call-function-name-when-streaming).
That's not a confirmed absence of the bug — just not something this
case's own testing triggered.

## Verification

[`scripts/verify.sh`](scripts/verify.sh) runs `omp` headlessly against
Solar Open 2 (Methods A–D, all gated by default). It exits non-zero if
Method A's reply doesn't contain `omp-solar-ready`, Method B's answer
doesn't contain `1275`, Method C's code doesn't contain `def is_prime`,
or Method D's generated app fails any of the Playwright checks above.
Methods A–C retry up to 5 times with a 30s backoff (this repo's shared
Tier-0 rate limit can cause a transient failure); Method D retries up
to 3 times only on an omp-process-level failure (auth/rate-limit
shaped) — once omp itself succeeds, a Playwright check failure is
treated as a real result, not retried away.

Setting `SKIP_METHOD_D` (any non-empty value) skips Method D entirely
and gates only on A–C. **CI always sets this** — Method D is a
multi-minute agentic build needing a headless browser, which doesn't
fit a step meant to run alongside seven other cases on every dispatch.
It's still verified, just locally rather than in CI, and its result is
published as a playable app in [`../gallery/`](../gallery/) instead of
being re-run each time. See [Evidence run](#evidence-run) below for
that local transcript.

Run locally with `UPSTAGE_API_KEY` set, `omp` installed
(`curl -fsSL https://omp.sh/install | sh`), and Node 18+ on `PATH`:

```bash
UPSTAGE_API_KEY="..." ./scripts/verify.sh              # Methods A-D
UPSTAGE_API_KEY="..." SKIP_METHOD_D=1 ./scripts/verify.sh  # Methods A-C only, matches CI
```

The script installs its own Playwright dependency and Chromium browser
on first run (see [`scripts/package.json`](scripts/package.json)) unless
`SKIP_METHOD_D` is set.

Runs in CI (manual dispatch, solar-open2 only, Methods A-C only) two
ways: as a step in
[`verify-all-sequential.yml`](../.github/workflows/verify-all-sequential.yml)
alongside every other case, and on its own via
[`verify-08-omp-solar-open2.yml`](../.github/workflows/verify-08-omp-solar-open2.yml) —
both reuse the same `UPSTAGE_API_KEY` repository secret and install
`omp` via its official installer.

## Evidence run

**Evidence run:** [`verify` job](https://github.com/jyje/pilot-upstage-solar-open2/actions/workflows/verify-08-omp-solar-open2.yml)
(link filled in after the first CI run of this case; covers Methods A-C
only, see [Verification](#verification) above for why Method D isn't
in that run). Real, unedited output from a local run against the live
Upstage API, all four methods:

**Method A**

> omp-solar-ready

**Method B**

> # Sum of the First 50 Positive Integers
>
> The sum $1 + 2 + 3 + \cdots + 50 = 1275$. Here's why, step by step.
>
> ## Method 1: The Formula
>
> The sum of the first $n$ positive integers is given by:
>
> $$S_n = \frac{n(n+1)}{2}$$
>
> For $n = 50$:
>
> $$S_{50} = \frac{50 \times (50 + 1)}{2}$$
>
> $$S_{50} = \frac{50 \times 51}{2}$$
>
> ## Step 3: Calculate
>
> $$50 \times 51 = 2550$$
>
> $$\frac{2550}{2} = 1275$$
>
> ...(truncated)

**Method C**

> ```python
> def is_prime(n: int) -> bool:
>     """Return True if n is a prime number, False otherwise.
>
>     A prime number is a natural number greater than 1 that has no
>     positive divisors other than 1 and itself.
>     """
>     if n < 2:
>         return False
>     if n < 4:
>         return True
>     if n % 2 == 0 or n % 3 == 0:
>         return False
>     i = 5
>     while i * i <= n:
>         if n % i == 0 or n % (i + 2) == 0:
>             return False
>         i += 6
>     return True
> ```

**Method D**

```
✓ omp wrote an index.html for the Sudoku app
✓ found all 36 cell inputs with the expected id contract
✓ 18 given cells form a legal partial grid (no conflicts)
✓ computed a valid full solution consistent with the given cells
✓ #status shows "Solved!" with the solved class after a correct completion
✓ negative test passed: breaking a correct cell clears the "Solved!" status
✓ "New Puzzle" generated a different set of given cells (not hardcoded)

All Method D checks passed.
```

See the repo-level [`PLAN.md`](../PLAN.md) for full context.
