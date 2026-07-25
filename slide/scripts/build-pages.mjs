import { execFile } from 'node:child_process';
import { fileURLToPath } from 'node:url';
import { mkdir, rm, writeFile } from 'node:fs/promises';
import { dirname, join, resolve } from 'node:path';
import { promisify } from 'node:util';

const run = promisify(execFile);
const scriptDirectory = dirname(fileURLToPath(import.meta.url));
const slideDirectory = resolve(scriptDirectory, '..');
const outputDirectory = join(slideDirectory, 'dist');
const slidevBinary = join(slideDirectory, 'node_modules', '.bin', 'slidev');
const configuredBasePath = process.env.SLIDEV_BASE_PATH ?? '/';
const siteBasePath = `/${configuredBasePath.replace(/^\/+|\/+$/g, '')}/`.replace('//', '/');

const selectorPage = `<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Solar Open 2 Agent Harnesses</title>
    <style>
      *, *::before, *::after { box-sizing: border-box; }
      :root { color: #f8f7fb; background: #11111f; font-family: Inter, system-ui, sans-serif; }
      body { display: grid; min-height: 100vh; margin: 0; place-items: center; }
      main { width: min(42rem, calc(100% - 3rem)); }
      .eyebrow { display: inline-block; padding: .4rem .65rem; color: #11111f; background: #c6ff72; font-size: .72rem; font-weight: 800; letter-spacing: .08em; }
      h1 { margin: 1.2rem 0 .7rem; font-size: clamp(2.5rem, 8vw, 5rem); letter-spacing: -.07em; line-height: .95; }
      p { max-width: 43rem; color: #c6c3d1; line-height: 1.6; }
      nav { display: flex; flex-wrap: wrap; gap: .8rem; margin-top: 2rem; }
      a { flex: 1 1 8rem; min-width: 0; padding: .9rem 1.1rem; border: 1px solid #4c2fff; color: #fff; text-align: center; text-decoration: none; }
      a:hover, a:focus { color: #11111f; background: #c6ff72; border-color: #c6ff72; }
    </style>
  </head>
  <body>
    <main>
      <div class="eyebrow">UPSTAGE × OPEN SOURCE AGENTS</div>
      <h1>Solar Open 2<br>Agent Harnesses</h1>
      <p>Choose a presentation language.</p>
      <nav aria-label="Presentation language">
        <a href="./en/#1" lang="en">English</a>
        <a href="./ko/#1" lang="ko">한국어</a>
      </nav>
    </main>
  </body>
</html>
`;

await rm(outputDirectory, { force: true, recursive: true });
await mkdir(outputDirectory, { recursive: true });

for (const locale of ['en', 'ko']) {
  const localeBasePath = `${siteBasePath}${locale}/`;

  await run(slidevBinary, [
    'build',
    'slides.md',
    '--base', localeBasePath,
    '--out', join(outputDirectory, locale),
    '--router-mode', 'hash',
    '--without-notes',
  ], { cwd: slideDirectory });
}

await Promise.all([
  writeFile(join(outputDirectory, 'index.html'), selectorPage),
  writeFile(join(outputDirectory, '.nojekyll'), ''),
]);
