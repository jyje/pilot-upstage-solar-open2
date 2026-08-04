import { execFile } from 'node:child_process';
import { fileURLToPath } from 'node:url';
import { cp, copyFile, mkdir, rm, writeFile } from 'node:fs/promises';
import { dirname, join, resolve } from 'node:path';
import { promisify } from 'node:util';

const run = promisify(execFile);
const scriptDirectory = dirname(fileURLToPath(import.meta.url));
const slideDirectory = resolve(scriptDirectory, '..');
const repoRootDirectory = resolve(slideDirectory, '..');
const outputDirectory = join(slideDirectory, 'dist');
const slidevBinary = join(slideDirectory, 'node_modules', '.bin', 'slidev');
const configuredBasePath = process.env.SLIDEV_BASE_PATH ?? '/';
const siteBasePath = `/${configuredBasePath.replace(/^\/+|\/+$/g, '')}/`.replace('//', '/');
const siteOrigin = process.env.SLIDEV_SITE_ORIGIN ?? 'https://jyje.github.io';
const ogImageUrl = `${siteOrigin}${siteBasePath}images/agent-ecosystem.png`;

const selectorPage = `<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>jyje/pilot-upstage-solar-open2</title>
    <meta name="description" content="A community-powered collection of Solar Open 2 agent-harness use cases.">
    <meta property="og:title" content="jyje/pilot-upstage-solar-open2">
    <meta property="og:description" content="A community-powered collection of Solar Open 2 agent-harness use cases.">
    <meta property="og:image" content="${ogImageUrl}">
    <meta property="og:type" content="website">
    <meta name="twitter:card" content="summary_large_image">
    <meta name="twitter:image" content="${ogImageUrl}">
    <style>
      *, *::before, *::after { box-sizing: border-box; }
      :root { color: #f8f7fb; background: #11111f; font-family: Inter, system-ui, sans-serif; }
      body { display: flex; flex-direction: column; align-items: center; min-height: 100vh; margin: 0; padding: 3rem 1.5rem; text-align: center; }
      main { width: min(38rem, 100%); }
      .brand { display: flex; align-items: center; justify-content: center; gap: .55rem; margin-bottom: 1.45rem; }
      .brand-jyje { display: inline-flex; align-items: center; gap: .32rem; }
      .brand-jyje img { height: 1.5rem; width: 1.5rem; border-radius: .25rem; }
      .brand-jyje span { font-size: 1.1rem; font-weight: 800; letter-spacing: -.02em; }
      .brand-x { color: #a7a5b8; font-size: 1.1rem; font-weight: 600; }
      .brand-upstage { display: inline-flex; align-items: center; gap: .42rem; }
      .brand-upstage img:first-child { height: 1.47rem; width: auto; }
      .brand-upstage img:last-child { height: 1.12rem; width: auto; filter: brightness(0) invert(1); }
      h1 { margin: 1.2rem 0 .95rem; font-size: clamp(1.92rem, 5.89vw, 3.2rem); letter-spacing: -.04em; line-height: 1.1; white-space: nowrap; }
      .hero-image { width: 90%; margin: 0 auto 1rem; border: 1px solid rgba(255,255,255,.13); border-radius: .5rem; box-shadow: 0 .7rem 1.8rem rgba(0,0,0,.22); }
      p.tagline { max-width: 100%; margin: 0 0 1.3rem; color: #fff; font-size: 1.203rem; font-weight: 600; line-height: 1.4; }
.cases-scroll { width: 100%; margin: 0 0 1rem; overflow-x: auto; border: 1px solid rgba(255,255,255,.14); border-radius: .5rem; background: rgba(255,255,255,.035); }
      table.cases { width: 100%; min-width: 30rem; border-collapse: separate; border-spacing: 0; text-align: left; }
      table.cases th, table.cases td { padding: .5rem .65rem; border-bottom: 1px solid rgba(255,255,255,.14); font-size: 1.024rem; white-space: nowrap; vertical-align: middle; }
      table.cases th { color: #c6ff72; font-weight: 700; letter-spacing: .04em; text-transform: uppercase; font-size: .87rem; }
      table.cases tr:last-child td { border-bottom: 0; }
      table.cases td.case-name { color: #fff; font-weight: 600; white-space: normal; }
      table.cases td.case-category { color: #a7a5b8; }
      table.cases td.case-ci img { height: 1.15rem; }
      p.gallery-link { margin: 1.1rem 0 0; font-size: 1.024rem; }
      p.gallery-link a { color: #c6ff72; text-decoration: none; font-weight: 600; }
      p.gallery-link a:hover, p.gallery-link a:focus { text-decoration: underline; }
      p.nav-label { margin: 1.6rem 0 0; color: #a7a5b8; font-size: .87rem; font-weight: 700; letter-spacing: .1em; text-transform: uppercase; }
      nav { display: flex; flex-wrap: wrap; justify-content: center; gap: .8rem; margin-top: .7rem; width: 100%; }
      a.lang { flex: 1 1 8rem; min-width: 0; padding: .9rem 1.1rem; border: 1px solid #4c2fff; color: #fff; text-align: center; text-decoration: none; }
      a.lang:hover, a.lang:focus { color: #11111f; background: #c6ff72; border-color: #c6ff72; }
      footer { margin-top: 2.5rem; padding-top: 1.4rem; border-top: 1px solid rgba(255,255,255,.14); color: #a7a5b8; font-size: 1.024rem; }
      footer p { margin: 0 0 .4rem; }
      footer p:last-child { margin-bottom: 0; }
      footer a { color: #a7a5b8; text-decoration: underline; text-decoration-color: rgba(167,165,184,.5); }
      footer a:hover, footer a:focus { color: #fff; }
    </style>
  </head>
  <body>
    <main>
      <div class="brand">
        <div class="brand-jyje">
          <img src="https://jyje.online/assets/icons/icon-128x128.png" alt="" />
          <span>jyje</span>
        </div>
        <span class="brand-x">×</span>
        <div class="brand-upstage">
          <img src="https://raw.githubusercontent.com/lobehub/lobe-icons/f07e9be35aef452ce735f95ea8204a14ecc513f7/packages/static-svg/icons/upstage-color.svg" alt="" />
          <img src="https://raw.githubusercontent.com/lobehub/lobe-icons/f07e9be35aef452ce735f95ea8204a14ecc513f7/packages/static-svg/icons/upstage-text.svg" alt="Upstage" />
        </div>
      </div>
      <h1>jyje/pilot-upstage-solar-open2</h1>
      <img class="hero-image" src="./images/agent-ecosystem.png" alt="Solar Open 2 agent ecosystem" />
      <p class="tagline">✨ Testing multiple agent harnesses powered by Upstage's Solar Open 2 and Solar Pro4 models: Claude Code, Hermes Agent (also verified on Kubernetes), Claude Agent SDK, LangChain Deepagents, OpenWiki, Grok Build, omp, and Codex</p>
      <div class="cases-scroll">
        <table class="cases" aria-label="Use cases">
          <thead>
            <tr><th>Case</th><th>Category</th><th>Verification</th></tr>
          </thead>
          <tbody>
            <tr>
              <td class="case-name">01 — Claude Code</td>
              <td class="case-category">Review</td>
              <td class="case-ci"><a href="https://github.com/jyje/pilot-upstage-solar-open2/actions/workflows/verify-01-solar-open2-harness.yml" target="_blank" rel="noreferrer"><img src="https://img.shields.io/github/actions/workflow/status/jyje/pilot-upstage-solar-open2/verify-01-solar-open2-harness.yml?label=&logo=github&logoColor=white" alt="verify-01 status" /></a></td>
            </tr>
            <tr>
              <td class="case-name">02 — Hermes Agent</td>
              <td class="case-category">Review</td>
              <td class="case-ci"><a href="https://github.com/jyje/pilot-upstage-solar-open2/actions/workflows/verify-02-hermes-agent-solar-open2.yml" target="_blank" rel="noreferrer"><img src="https://img.shields.io/github/actions/workflow/status/jyje/pilot-upstage-solar-open2/verify-02-hermes-agent-solar-open2.yml?label=&logo=github&logoColor=white" alt="verify-02 status" /></a></td>
            </tr>
            <tr>
              <td class="case-name">03 — Claude Agent SDK</td>
              <td class="case-category">Extend</td>
              <td class="case-ci"><a href="https://github.com/jyje/pilot-upstage-solar-open2/actions/workflows/verify-03-claude-agent-sdk-local.yml" target="_blank" rel="noreferrer"><img src="https://img.shields.io/github/actions/workflow/status/jyje/pilot-upstage-solar-open2/verify-03-claude-agent-sdk-local.yml?label=&logo=github&logoColor=white" alt="verify-03 status" /></a></td>
            </tr>
            <tr>
              <td class="case-name">04 — LangChain DeepAgents</td>
              <td class="case-category">Extend</td>
              <td class="case-ci"><a href="https://github.com/jyje/pilot-upstage-solar-open2/actions/workflows/verify-04-langchain-upstage-deepagents.yml" target="_blank" rel="noreferrer"><img src="https://img.shields.io/github/actions/workflow/status/jyje/pilot-upstage-solar-open2/verify-04-langchain-upstage-deepagents.yml?label=&logo=github&logoColor=white" alt="verify-04 status" /></a></td>
            </tr>
            <tr>
              <td class="case-name">05 — LangChain OpenWiki</td>
              <td class="case-category">Extend</td>
              <td class="case-ci"><a href="https://github.com/jyje/pilot-upstage-solar-open2/actions/workflows/verify-05-langchain-openwiki-solar-open2.yml" target="_blank" rel="noreferrer"><img src="https://img.shields.io/github/actions/workflow/status/jyje/pilot-upstage-solar-open2/verify-05-langchain-openwiki-solar-open2.yml?label=&logo=github&logoColor=white" alt="verify-05 status" /></a></td>
            </tr>
            <tr>
              <td class="case-name">06 — Grok Build</td>
              <td class="case-category">Extend</td>
              <td class="case-ci"><a href="https://github.com/jyje/pilot-upstage-solar-open2/actions/workflows/verify-06-grok-build-solar-open2.yml" target="_blank" rel="noreferrer"><img src="https://img.shields.io/github/actions/workflow/status/jyje/pilot-upstage-solar-open2/verify-06-grok-build-solar-open2.yml?label=&logo=github&logoColor=white" alt="verify-06 status" /></a></td>
            </tr>
            <tr>
              <td class="case-name">07 — Hermes Agent Helm</td>
              <td class="case-category">Extend</td>
              <td class="case-ci"><a href="https://github.com/jyje/pilot-upstage-solar-open2/actions/workflows/verify-07-hermes-agent-helm-solar-open2.yml" target="_blank" rel="noreferrer"><img src="https://img.shields.io/github/actions/workflow/status/jyje/pilot-upstage-solar-open2/verify-07-hermes-agent-helm-solar-open2.yml?label=&logo=github&logoColor=white" alt="verify-07 status" /></a></td>
            </tr>
            <tr>
              <td class="case-name">08 — omp</td>
              <td class="case-category">Extend</td>
              <td class="case-ci"><a href="https://github.com/jyje/pilot-upstage-solar-open2/actions/workflows/verify-08-omp-solar-open2.yml" target="_blank" rel="noreferrer"><img src="https://img.shields.io/github/actions/workflow/status/jyje/pilot-upstage-solar-open2/verify-08-omp-solar-open2.yml?label=&logo=github&logoColor=white" alt="verify-08 status" /></a></td>
            </tr>
            <tr>
              <td class="case-name">09 — Codex</td>
              <td class="case-category">Extend</td>
              <td class="case-ci"><a href="https://github.com/jyje/pilot-upstage-solar-open2/actions/workflows/verify-09-codex-upstage-solar-open2.yml" target="_blank" rel="noreferrer"><img src="https://img.shields.io/github/actions/workflow/status/jyje/pilot-upstage-solar-open2/verify-09-codex-upstage-solar-open2.yml?label=&logo=github&logoColor=white" alt="verify-09 status" /></a></td>
            </tr>
          </tbody>
        </table>
      </div>
      <p class="gallery-link"><a href="./gallery/">→ Gallery: real, playable apps Solar Open 2 &amp; Pro4 built</a></p>
      <p class="nav-label">Start the slides — choose a language</p>
      <nav aria-label="Presentation language">
        <a class="lang" href="./en/#1" lang="en">English</a>
        <a class="lang" href="./ko/#1" lang="ko">한국어</a>
      </nav>
      <footer>
        <p>
          <a href="https://github.com/jyje/pilot-upstage-solar-open2" target="_blank" rel="noreferrer">github.com/jyje/pilot-upstage-solar-open2</a>
          &middot; by <a href="https://github.com/jyje" target="_blank" rel="noreferrer">jyje</a>
        </p>
        <p>Built with Claude and Upstage's Solar Open 2 model.</p>
      </footer>
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

const selectorImagesDirectory = join(outputDirectory, 'images');
await mkdir(selectorImagesDirectory, { recursive: true });

await Promise.all([
  writeFile(join(outputDirectory, 'index.html'), selectorPage),
  writeFile(join(outputDirectory, '.nojekyll'), ''),
  copyFile(
    join(slideDirectory, 'public', 'images', 'agent-ecosystem.png'),
    join(selectorImagesDirectory, 'agent-ecosystem.png'),
  ),
  // Real, playable apps built by Solar Open 2 through this repo's cases
  // (see ../gallery/README.md) -- static files, copied as-is.
  cp(
    join(repoRootDirectory, 'gallery'),
    join(outputDirectory, 'gallery'),
    { recursive: true },
  ),
]);
