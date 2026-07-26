<div align="center">

# Solar Open 2 Agent Harnesses — Slides

Slidev presentation for the seven Solar Open 2 agent-harness experiments.

[English](./README.md) / [한국어](./README-ko.md)

</div>

## Overview

This directory contains the technical presentation for
[`jyje/pilot-upstage-solar-open2`](https://github.com/jyje/pilot-upstage-solar-open2).
It introduces Solar Open 2, then walks through the seven independently
verified agent-harness cases, shared findings, CI evidence, and next steps.

The entry point is [`slides.md`](./slides.md). The numbered Markdown files
are maintained as section-level source copies for easier editing and review.
The `<Localized>` component chooses English or Korean from the URL path, so
the same source stays aligned across both language builds.

## Languages and URLs

The GitHub Pages build emits two static decks and a language selector:

| Language | Path | Slide 1 URL |
| --- | --- | --- |
| English | `/en/` | `/en/#1` |
| Korean | `/ko/` | `/ko/#1` |

Hash routing is intentional. GitHub Pages is static hosting and cannot
rewrite a history route such as `/en/1` back to a Slidev entry file.

## Design system

The deck adapts the visual language of the
[Upstage website](https://www.upstage.ai/): a near-black navy canvas,
electric-violet action color, lime signal color, cyan supporting color,
large editorial headings, and generous whitespace.

The reusable design tokens and component styles live in
[`styles/upstage.css`](./styles/upstage.css):

| Token | Value | Role |
| --- | --- | --- |
| Ink | `#11111f` | Primary canvas |
| Violet | `#4c2fff` | Primary emphasis |
| Lime | `#c6ff72` | Signals, labels, and section rule |
| Cyan | `#8fe7d1` | Supporting headings and links |
| Paper | `#f7f7f2` | Light-surface reserve color |

The cover also uses `upstage-eyebrow`, `upstage-stat-grid`, and
`upstage-stat` as small reusable presentation primitives.

## Requirements

- Node.js 22 or later
- npm 10 or later

The project uses Slidev and the `slidev-theme-kitty` runtime theme. Install
the dependencies before starting the deck.

## Run locally

```bash
cd slide
npm install
npm run dev
```

Slidev prints the local URL when the development server starts (normally
`http://localhost:3030`). Use the presentation controls or arrow keys to
navigate. Click through incremental content to reveal each `v-click` block.

To preview a specific language path, use one of these commands:

```bash
npm run dev:en  # http://localhost:3030/en/#1
npm run dev:ko  # http://localhost:3031/ko/#1
```

## Build

```bash
cd slide
npm run build
```

The static presentation is written to `slide/dist/`, which is intentionally
ignored by Git.

## GitHub Pages

Build both localized decks and the language selector with:

```bash
cd slide
npm run build:pages
```

This writes `dist/index.html`, `dist/en/`, and `dist/ko/`. The
[`deploy-slides-pages.yml`](../.github/workflows/deploy-slides-pages.yml)
workflow uploads that directory to GitHub Pages after a change under
`slide/` lands on `main`. In CI it automatically adds the repository-name
base path required by a GitHub project Pages URL.

To serve the language selector and both language paths locally from one
port, run:

```bash
npm run preview:pages
```

Then open `http://localhost:3030/` for the language-selector landing
page (what `jyje.github.io/pilot-upstage-solar-open2` serves), or go
straight to a deck with `http://localhost:3030/en/#1` or
`http://localhost:3030/ko/#1`.

`npm run dev` does not produce this landing page — it always jumps
straight into slide 1 of the live-editable deck. Use `preview:pages`
whenever you need to check the landing page itself.

## Verification notes

`npm run build` is the current deterministic validation command for the
deck. The underlying agent cases have their own live verification workflow
in the repository root; this presentation does not call those remote checks.

For visual review, run the local server and inspect the cover, a dense
case slide, and the CI slide at the target presentation size. The browser
automation environment used during initial styling could inspect Upstage's
public site, but could not reach the isolated local Slidev port; therefore,
local visual review should be repeated on the developer machine before a
public presentation release.

## Project scripts

| Command | Purpose |
| --- | --- |
| `npm run dev` | Start Slidev in development mode |
| `npm run dev:en` | Start the English route on port 3030 |
| `npm run dev:ko` | Start the Korean route on port 3031 |
| `npm run build` | Produce a static Slidev build in `dist/` |
| `npm run build:pages` | Build the language selector plus `/en/` and `/ko/` Pages output |
| `npm run preview:pages` | Serve the language-selector landing page plus both localized Pages builds on port 3030 |
| `npm run preview` | Build, then serve the static output |
| `npm run test:e2e` | Reserved for a future slide-level browser test |

`test:e2e` currently has no implementation. Do not treat it as a passing
quality gate until `test-slidev.mjs` is added.
