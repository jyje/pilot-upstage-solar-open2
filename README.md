<div align="center">

# jyje/pilot-upstage-solar-open2

<img width="96" src="https://unpkg.com/@lobehub/icons-static-svg@1.91.0/icons/upstage-color.svg" alt="Upstage" title="Upstage"/> <img width="96" src="https://unpkg.com/@lobehub/icons-static-svg@1.91.0/icons/claude-color.svg" alt="Claude" title="Claude"/> <img width="96" src="https://unpkg.com/@lobehub/icons-static-svg@1.91.0/icons/nousresearch.svg" alt="Hermes Agent" title="Hermes Agent"/>

🧪 Claude Code, the Claude Agent SDK, LangChain, OpenWiki, and Hermes Agent — every use case built on Upstage Solar Open2!

[![verify-solar-open2-harness](https://github.com/jyje/pilot-upstage-solar-open2/actions/workflows/verify-solar-open2-harness.yml/badge.svg)](https://github.com/jyje/pilot-upstage-solar-open2/actions/workflows/verify-solar-open2-harness.yml)
[![verify-claude-agent-sdk-local](https://github.com/jyje/pilot-upstage-solar-open2/actions/workflows/verify-claude-agent-sdk-local.yml/badge.svg)](https://github.com/jyje/pilot-upstage-solar-open2/actions/workflows/verify-claude-agent-sdk-local.yml)
[![verify-langchain-upstage-deepagents](https://github.com/jyje/pilot-upstage-solar-open2/actions/workflows/verify-langchain-upstage-deepagents.yml/badge.svg)](https://github.com/jyje/pilot-upstage-solar-open2/actions/workflows/verify-langchain-upstage-deepagents.yml)
[![verify-langchain-openwiki-solar-open2](https://github.com/jyje/pilot-upstage-solar-open2/actions/workflows/verify-langchain-openwiki-solar-open2.yml/badge.svg)](https://github.com/jyje/pilot-upstage-solar-open2/actions/workflows/verify-langchain-openwiki-solar-open2.yml)
[![verify-hermes-agent-solar-open2](https://github.com/jyje/pilot-upstage-solar-open2/actions/workflows/verify-hermes-agent-solar-open2.yml/badge.svg)](https://github.com/jyje/pilot-upstage-solar-open2/actions/workflows/verify-hermes-agent-solar-open2.yml)

[English](README.md) / [한국어](README-ko.md)

</div>

A single repo hosting several independent, seminar/portfolio-ready use
cases around building and running agent harnesses on Upstage's Solar Open2
model across the Claude, LangChain, OpenWiki, and Hermes Agent ecosystems.
Each case lives in its own top-level directory and can
be read, run, and presented independently.

## Cases

| Case | Summary | Status |
| --- | --- | --- |
| [Case 01 — Solar Open2 x Claude Code](01-solar-open2-harness/) | Build a Claude Code harness (skills, etc.) backed by Upstage's Solar Open2 model | Verified |
| [Case 02 — Solar Open2 x Claude Agent SDK](02-claude-agent-sdk-local/) | Drive a local Claude Code instance programmatically with the Claude Agent SDK | Verified |
| [Case 03 — Solar Open2 x LangChain Deepagents](03-langchain-upstage-deepagents/) | Initialize deepagents at the code level using the LangChain Upstage SDK | Verified |
| [Case 04 — Solar Open2 x LangChain OpenWiki](04-langchain-openwiki-solar-open2/) | Use `openwiki` to document this repo and answer questions about it, powered by Solar Open2 | Verified |
| [Case 05 — Solar Open2 x Hermes Agent](05-hermes-agent-solar-open2/) | Run Hermes Agent through its officially bundled Upstage provider and the official Docker image | Verified |

See [`PLAN.md`](PLAN.md) for the full plan and [`AGENTS.md`](AGENTS.md) for repo conventions.
