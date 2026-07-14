# pilot-solar-2

Portfolio/seminar repo hosting three independent agent-harness experiments
built around Upstage's Solar Open2 model and the Claude/LangChain agent
ecosystem. See [`PLAN.md`](PLAN.md) for the full plan and [`README.md`](README.md)
for the public-facing overview.

## Structure

```
pilot-solar-2/
├── .claude/skills/                    # skills available in this repo (see below)
├── PLAN.md                            # full 3-case plan
├── README.md / README-ko.md           # portfolio front page
├── 01-solar-open2-harness/            # Case 01: Claude Code harness on Solar Open2
├── 02-claude-agent-sdk-local/         # Case 02: local Claude Code via Claude Agent SDK
└── 03-langchain-upstage-deepagents/   # Case 03: deepagents init via LangChain Upstage SDK
```

Referred to as **Case 01 / Case 02 / Case 03** in prose and docs — the
numbered directory prefixes (`01-`, `02-`, `03-`) are just filesystem
sort order, not a rename target. Each case directory is a self-contained
experiment with its own `src/` (uv-managed). All three are implemented
and verified, each with its own `scripts/verify.sh` and a matching
`.github/workflows/verify-<case>.yml` that reuses the same
`UPSTAGE_API_KEY` secret. Case 03 pins Python 3.13 instead of 3.14 (the
default elsewhere) — see its README for why.

## Skills available

- `centered-readme` — format README headers as a centered hero block
- `git-commit-helper` — gitmoji + conventional-commit-ish commit message policy
- `python-lint` — ruff + ty + pytest workflow, required for any Python change

## Conventions

- **Language**: all source code and code comments are English only — no
  Korean in code, docstrings, or inline comments.
- **README language**: English is the default for every README's primary
  content. Every scenario — the repo root and each topic (01, 02, 03) —
  gets a Korean twin (`README-ko.md`) with the same language navigator
  style. Everything else (source code, comments, `CLAUDE.md`, `PLAN.md`)
  stays English-only.
- **Python changes**: run the `python-lint` skill's workflow (ruff check,
  ruff format, ty check, pytest) before considering a Python change done.
- **Commits**: follow the `git-commit-helper` skill's gitmoji + type/domain
  format. Never commit or push without explicit user approval.
