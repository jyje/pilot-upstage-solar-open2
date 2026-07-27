// Functional check for Method D's output: loads the omp-generated
// index.html in a real headless browser and plays it, rather than just
// grepping the source for expected strings. This is the only case in
// this repo that needs a browser to verify its output, since it's the
// only one asking the model to build something with a UI.
//
// Usage: node verify-sudoku.mjs <path-to-index.html>

import { chromium } from 'playwright';
import { pathToFileURL } from 'node:url';
import path from 'node:path';

const htmlPath = process.argv[2];
if (!htmlPath) {
  console.error('usage: node verify-sudoku.mjs <path-to-index.html>');
  process.exit(2);
}

const fail = (msg) => {
  console.error(`✗ ${msg}`);
  process.exit(1);
};
const ok = (msg) => console.log(`✓ ${msg}`);

// 6x6 backtracking solver, 2x3 boxes (2 rows x 3 cols per box). Used to
// compute a valid completion for whatever givens the app generated --
// this repo doesn't know the app's puzzle in advance, so it solves it
// independently rather than assuming a fixed fixture.
function isSafe(grid, r, c, v) {
  for (let i = 0; i < 6; i++) {
    if (grid[r][i] === v || grid[i][c] === v) return false;
  }
  const br = Math.floor(r / 2) * 2;
  const bc = Math.floor(c / 3) * 3;
  for (let i = br; i < br + 2; i++) {
    for (let j = bc; j < bc + 3; j++) {
      if (grid[i][j] === v) return false;
    }
  }
  return true;
}
function solve(grid) {
  for (let r = 0; r < 6; r++) {
    for (let c = 0; c < 6; c++) {
      if (grid[r][c] === 0) {
        for (let v = 1; v <= 6; v++) {
          if (isSafe(grid, r, c, v)) {
            grid[r][c] = v;
            if (solve(grid)) return true;
            grid[r][c] = 0;
          }
        }
        return false;
      }
    }
  }
  return true;
}

const browser = await chromium.launch();
const page = await browser.newPage();
const fileUrl = pathToFileURL(path.resolve(htmlPath)).href;
await page.goto(fileUrl);

// 1. Every cell must exist with the id/data-given contract the prompt required.
const cells = await page.$$eval('input[id^="cell-"]', (els) =>
  els.map((el) => ({
    id: el.id,
    value: el.value,
    given: el.getAttribute('data-given'),
    readonly: el.hasAttribute('readonly'),
  })),
);
if (cells.length !== 36) fail(`expected 36 cell inputs (id="cell-R-C"), found ${cells.length}`);
ok('found all 36 cell inputs with the expected id contract');

// 2. The given cells (as generated) must not already violate the rules.
const grid = Array.from({ length: 6 }, () => Array(6).fill(0));
let givenCount = 0;
for (const cell of cells) {
  const m = cell.id.match(/^cell-(\d)-(\d)$/);
  if (!m) fail(`cell id "${cell.id}" doesn't match cell-R-C`);
  const r = Number(m[1]);
  const c = Number(m[2]);
  if (cell.given === 'true') {
    givenCount++;
    if (!cell.readonly) fail(`given cell ${cell.id} is missing the readonly attribute`);
    const v = Number(cell.value);
    if (!v || v < 1 || v > 6) fail(`given cell ${cell.id} has invalid value "${cell.value}"`);
    if (!isSafe(grid, r, c, v)) fail(`given cells conflict at ${cell.id} (puzzle generation is broken)`);
    grid[r][c] = v;
  }
}
if (givenCount === 0 || givenCount === 36) fail(`givenCount=${givenCount} looks wrong (expected roughly half the board)`);
ok(`${givenCount} given cells form a legal partial grid (no conflicts)`);

// 3. Solve it independently -- don't assume the app's own remembered
// solution, since a puzzle this size can have more than one valid
// completion and any rule-valid one must count.
const solved = structuredClone(grid);
if (!solve(solved)) fail('the given cells have no valid 6x6 completion (unsolvable puzzle)');
ok('computed a valid full solution consistent with the given cells');

// 4. Fill every editable cell through the real UI, so the app's own
// input/change listeners fire exactly as they would for a person typing.
for (const cell of cells) {
  if (cell.given === 'true') continue;
  const m = cell.id.match(/^cell-(\d)-(\d)$/);
  const r = Number(m[1]);
  const c = Number(m[2]);
  await page.fill(`#${cell.id}`, String(solved[r][c]));
}
await page.waitForTimeout(300);

// 5. Win detection must actually fire.
const status = await page.$eval('#status', (el) => ({
  text: el.textContent,
  classes: Array.from(el.classList),
}));
if (status.text !== 'Solved!') fail(`#status text is "${status.text}", expected exactly "Solved!"`);
if (!status.classes.includes('solved')) fail(`#status is missing the "solved" class (has: ${status.classes.join(',')})`);
ok('#status shows "Solved!" with the solved class after a correct completion');

// 6. Negative test: win detection must not be a no-op that always
// reports success regardless of the actual board state.
const firstEditable = cells.find((c) => c.given !== 'true');
if (!firstEditable) fail('no editable cells found to run the negative test against');
{
  const m = firstEditable.id.match(/^cell-(\d)-(\d)$/);
  const r = Number(m[1]);
  const c = Number(m[2]);
  const correct = solved[r][c];
  const wrong = (correct % 6) + 1;
  await page.fill(`#${firstEditable.id}`, String(wrong));
  await page.waitForTimeout(300);
  const statusText = await page.$eval('#status', (el) => el.textContent);
  if (statusText === 'Solved!') fail('negative test failed: #status still shows "Solved!" after breaking a cell -- win detection is not real');
  ok('negative test passed: breaking a correct cell clears the "Solved!" status');
  await page.fill(`#${firstEditable.id}`, String(correct));
}

// 7. Bonus: the "New Puzzle" button must actually regenerate, not just
// reset to the same fixed puzzle every time.
const beforeGivens = cells.filter((c) => c.given === 'true').map((c) => `${c.id}=${c.value}`).sort();
await page.click('#new-puzzle');
await page.waitForTimeout(300);
const afterGivens = await page.$$eval('input[id^="cell-"][data-given="true"]', (els) =>
  els.map((el) => `${el.id}=${el.value}`).sort(),
);
if (JSON.stringify(beforeGivens) === JSON.stringify(afterGivens)) {
  console.log('  (note: "New Puzzle" produced the exact same given cells -- possibly coincidence, not gated)');
} else {
  ok('"New Puzzle" generated a different set of given cells (not hardcoded)');
}

await browser.close();
console.log('\nAll Method D checks passed.');
