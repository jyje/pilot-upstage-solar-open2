# Gallery

[English](README.md) / [한국어](README-ko.md)

[← back to repo overview](../README.md)

Real, playable apps that Solar Open 2 actually built through this repo's
agent-harness cases — checked functionally in a real browser as part of
that case's own verification, not written or edited by hand beyond a
couple of openly-noted, minimal bugfixes (see each entry below).

Live at [jyje.github.io/pilot-upstage-solar-open2/gallery/](https://jyje.github.io/pilot-upstage-solar-open2/gallery/).

## Entries

### 6x6 Mini Sudoku — [`case-08-omp-sudoku/`](case-08-omp-sudoku/)

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
