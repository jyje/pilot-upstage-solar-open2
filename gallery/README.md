# Gallery

[English](README.md) / [한국어](README-ko.md)

[← back to repo overview](../README.md)

Real, playable apps that Solar Open 2 actually built through this repo's
agent-harness cases — checked functionally in a real browser as part of
that case's own verification, not written or edited by hand beyond a
couple of openly-noted, minimal bugfixes (see each entry below).

Live at [jyje.github.io/pilot-upstage-solar-open2/gallery/](https://jyje.github.io/pilot-upstage-solar-open2/gallery/).

## Entries

Each entry's path carries the model that built it, and every page says
so on the page itself — the same spec, given to two different Solar
models through the same harness, does not produce the same result.

### 6x6 Mini Sudoku (solar-open2) — [`case-08-omp-sudoku-solar-open2/`](case-08-omp-sudoku-solar-open2/)

Built by Solar Open 2 through [Case 08](../08-omp-solar-open2/)'s
`omp` (oh-my-pi) harness, from a written requirements spec — see
[`08-omp-solar-open2/scripts/sudoku-prompt.txt`](../08-omp-solar-open2/scripts/sudoku-prompt.txt)
for the base spec this build extended with extra visual-design and
structural-contract detail. A single self-contained `index.html`:
puzzle generation, live conflict highlighting, real rule-based win
detection, and a working "New Puzzle" button.

**Honest bugfix note:** the raw output initially had real bugs — the
win-detection status never re-evaluated on every keystroke (it called
the wrong function) and, once fixed, didn't clear the "Solved!" state
after a board was broken again. Those two were fixed by asking `omp`
itself to make a targeted edit describing the exact bug, the same
ask-verify-fix loop this repo's cases already use — no hand-written
code was substituted in.

A third bug was found afterward, by eye rather than by the automated
check: `generatePuzzle()` called `shuffle(positions)` without
reassigning its return value, so the "random" set of given cells was
always the same (the first three grid rows) even though the digit
values differed each time — the puzzle looked freshly generated but
its shape never was. The existing Playwright check only compared given
*values* between two generations, not their *positions*, so it passed
6/6 without catching this. This one was small and unambiguous enough
to fix directly (`const shuffledPositions = shuffle(positions)`) rather
than round-tripping through `omp` again. See [Case 08's README](../08-omp-solar-open2/README.md)
for the same class of finding (and others) documented from this
case's own gated verification, which runs the model's raw output
unedited.

### 6x6 Mini Sudoku (solar-pro4) — [`case-08-omp-sudoku-solar-pro4/`](case-08-omp-sudoku-solar-pro4/)

The same spec, same harness, same 8-minute budget — given to
`solar-pro4` instead. Built 2026-08-04 as a head-to-head against the
entry above; full transcript in
[`logs/local-verification/2026-08-03/case-08-method-d-sudoku-head-to-head.log`](../logs/local-verification/2026-08-03/case-08-method-d-sudoku-head-to-head.log).

**Honest bugfix note:** its raw single-shot output had one defect — a
malformed line, `var positions = shuffle positions = shufflePositions();`,
a hard JavaScript syntax error that killed the whole script so the board
never rendered. Handing that exact line back to `omp` fixed it in a
single round (same ask-verify-fix loop as above, no hand-written code
substituted), after which it passed all 6 Playwright checks.

For contrast, `solar-open2`'s fresh single-shot build in that same
head-to-head did *not* reach a passing state: it had two stacked logic
defects (an inverted given/blank cell set, and a `generateFullGrid()`
that pre-fills three boxes it wrongly assumes are independent — in a
6x6 grid with 2x3 boxes they share columns 0-2), and it twice exhausted
the 8-minute agentic budget without emitting an edit. The open2 entry
published above is the earlier, already-verified build, not that run's
output. One run each is not a benchmark, but the difference was real and
is recorded rather than smoothed over.
