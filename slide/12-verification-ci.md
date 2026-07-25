<!-- slidev:enable-auto-animate -->
# Verification & CI

## Every case, automatically verified on every relevant commit

<v-click>

### Verification architecture

Each case is **self-contained**:
- Own `scripts/verify.sh` — runs all checks for that case
- Own `README.md` / `README-ko.md` — documentation and evidence
- Own `.github/workflows/verify-XX-*.yml` (where applicable) — standalone CI

All cases also run together in:

```yaml
# .github/workflows/verify-all-sequential.yml
jobs:
  c01: { steps: [./scripts/verify-case.sh 01-...] }
  c02: { steps: [./scripts/verify-case.sh 02-...] }
  # ... through c07
```

</v-click>

<v-click>

### Two execution modes

| Mode | Trigger | Use case |
|---|---|---|
| **Sequential (all cases)** | Push to `main`, PRs | Catch regressions across the full matrix |
| **Single-case manual dispatch** | GitHub Actions UI | Debug one case without waiting for the full run |

All workflows reuse the **same `UPSTAGE_API_KEY` repository secret** —
no per-case secrets, no per-case cost overhead.

</v-click>

<v-click>

### Evidence: real, unedited CI transcripts

Every case's README links to the actual CI run — not a curated extract:

```
Evidence run: verify job, 2026-07-23
https://github.com/jyje/pilot-upstage-solar-open2/actions/runs/...
```

Output is shown **up to ~700 characters** (10+ wrapped lines), specifically
so you can judge how the model *reasons*, not just that it responded.
Nothing is hand-picked or edited.

</v-click>

<v-click>

### Status dashboard

| Case | Status | Category | Workflow |
|---|---|---|---|
| 01 — Claude Code | ✅ Verified | Review | `verify-all-sequential` |
| 02 — Hermes Agent | ✅ Verified | Review | `verify-all-sequential` |
| 03 — Claude Agent SDK | ✅ Verified | Extend | `verify-all-sequential` |
| 04 — LangChain DeepAgents | ✅ Verified | Extend | `verify-all-sequential` |
| 05 — LangChain OpenWiki | ✅ Verified | Extend | `verify-all-sequential` |
| 06 — Grok Build | ✅ Verified | Extend | `verify-all-sequential` + standalone |
| 07 — Hermes Agent Helm | ✅ Verified | Extend | `verify-all-sequential` + standalone |

</v-click>

<!--
The verification story is a first-class part of this project. Every case has
a reproducible local script, a CI workflow, and a linked evidence run.
The ~700-char output cap is a deliberate design choice — it gives enough
context to assess model reasoning without dumping megabytes of raw logs.
-->
