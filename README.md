<div align="center">

# jyje/pilot-upstage-solar-open2

<img height="300" src="https://raw.githubusercontent.com/jyje/pilot-upstage-solar-open2/main/docs/images/pilot-upstage-solar-open2.png" alt="Claude Code × Upstage Solar Open 2 × Hermes Agent"/>

✨ Testing multiple agent harnesses powered by the Upstage Solar Open 2 model: Claude Code, Hermes Agent (also verified on Kubernetes), Claude Agent SDK, LangChain Deepagents, OpenWiki, Grok Build, and omp

[![verify-all-sequential](https://github.com/jyje/pilot-upstage-solar-open2/actions/workflows/verify-all-sequential.yml/badge.svg)](https://github.com/jyje/pilot-upstage-solar-open2/actions/workflows/verify-all-sequential.yml)
[![Python 3.13](https://img.shields.io/badge/python-3.13-3776AB?logo=python&logoColor=white)](https://docs.python.org/3.13/)
[![License: MIT](https://img.shields.io/badge/license-MIT-c6ff72)](LICENSE)

External links:<br>
[![Model on Hugging Face](https://img.shields.io/badge/🤗_Hugging_Face-upstage/solar--open2--250b-yellow)](https://huggingface.co/upstage/Solar-Open2-250B)
[![Technical Report](https://img.shields.io/badge/📄_Technical_Report-PDF-blue)](https://huggingface.co/upstage/Solar-Open2-250B/blob/main/Solar_Open_2_Tech_Report.pdf)
[![Launch Event](https://img.shields.io/badge/📺_Launch_Event-YouTube-red)](https://www.youtube.com/live/6XX-yR3qomM)

[English](README.md) / [한국어](README-ko.md)

</div>

## Solar Open 2

[Solar Open 2](https://huggingface.co/upstage/Solar-Open2-250B) is Upstage's
open-weight, 250B-A15B (250B total, 15B active) Mixture-of-Experts model.
It's purpose-built for long-horizon agentic tasks — tool use, multi-step
reasoning, end-to-end task execution — over a 1M-token context, via a
hybrid linear/softmax attention stack.

It leads comparably sized open-weight models on MMLU-Pro, LiveCodeBench,
and the APEX-Agents agentic suite. On Korean benchmarks, it posts the
highest average of any model compared, including fast-tier closed APIs.

| Feature | Description |
| --- | --- |
| Parameters | 250B total, 15B active (MoE) |
| Context | 1M tokens |
| License | Upstage Solar License |
| Report | [Solar Open 2 Technical Report](https://huggingface.co/upstage/Solar-Open2-250B/blob/main/Solar_Open_2_Tech_Report.pdf) (Jul 22, 2026) |
| Launch event | [Solar Open Weight Day (YouTube Live)](https://www.youtube.com/live/6XX-yR3qomM) |

This repo doesn't re-explain the model itself — see the
[model card](https://huggingface.co/upstage/Solar-Open2-250B) and
[technical report](https://huggingface.co/upstage/Solar-Open2-250B/blob/main/Solar_Open_2_Tech_Report.pdf)
for full details. What follows is how to build agent harnesses on top of
it.

A single repo hosting several independent, seminar-ready use cases around
building and running agent harnesses on Upstage's Solar Open 2 model across
the Claude, LangChain, OpenWiki, Hermes Agent, Grok Build, and omp ecosystems.
Each case lives in its own top-level directory and can be read, run, and
presented independently.

## Cases

| Case | Category | Summary | CI |
| --- | --- | --- | --- |
| [Case 01 — Solar Open 2 x Claude Code](01-solar-open2-harness/) | Review | Build a Claude Code harness (skills, etc.) backed by Upstage's Solar Open 2 model | [![verify-01](https://github.com/jyje/pilot-upstage-solar-open2/actions/workflows/verify-01-solar-open2-harness.yml/badge.svg)](https://github.com/jyje/pilot-upstage-solar-open2/actions/workflows/verify-01-solar-open2-harness.yml) |
| [Case 02 — Solar Open 2 x Hermes Agent](02-hermes-agent-solar-open2/) | Review | Run Hermes Agent through its officially bundled Upstage provider and the official Docker image | [![verify-02](https://github.com/jyje/pilot-upstage-solar-open2/actions/workflows/verify-02-hermes-agent-solar-open2.yml/badge.svg)](https://github.com/jyje/pilot-upstage-solar-open2/actions/workflows/verify-02-hermes-agent-solar-open2.yml) |
| [Case 03 — Solar Open 2 x Claude Agent SDK](03-claude-agent-sdk-local/) | Extend | Drive a local Claude Code instance programmatically with the Claude Agent SDK | [![verify-03](https://github.com/jyje/pilot-upstage-solar-open2/actions/workflows/verify-03-claude-agent-sdk-local.yml/badge.svg)](https://github.com/jyje/pilot-upstage-solar-open2/actions/workflows/verify-03-claude-agent-sdk-local.yml) |
| [Case 04 — Solar Open 2 x LangChain Deepagents](04-langchain-upstage-deepagents/) | Extend | Initialize deepagents at the code level using the LangChain Upstage SDK | [![verify-04](https://github.com/jyje/pilot-upstage-solar-open2/actions/workflows/verify-04-langchain-upstage-deepagents.yml/badge.svg)](https://github.com/jyje/pilot-upstage-solar-open2/actions/workflows/verify-04-langchain-upstage-deepagents.yml) |
| [Case 05 — Solar Open 2 x LangChain OpenWiki](05-langchain-openwiki-solar-open2/) | Extend | Use `openwiki` to document this repo and answer questions about it, powered by Solar Open 2 | [![verify-05](https://github.com/jyje/pilot-upstage-solar-open2/actions/workflows/verify-05-langchain-openwiki-solar-open2.yml/badge.svg)](https://github.com/jyje/pilot-upstage-solar-open2/actions/workflows/verify-05-langchain-openwiki-solar-open2.yml) |
| [Case 06 — Solar Open 2 x Grok Build](06-grok-build-solar-open2/) | Extend | Run xAI's Grok Build CLI against Solar Open 2 as a custom model provider | [![verify-06](https://github.com/jyje/pilot-upstage-solar-open2/actions/workflows/verify-06-grok-build-solar-open2.yml/badge.svg)](https://github.com/jyje/pilot-upstage-solar-open2/actions/workflows/verify-06-grok-build-solar-open2.yml) |
| [Case 07 — Solar Open 2 x Hermes Agent Helm](07-hermes-agent-helm-solar-open2/) | Extend | Deploy Hermes Agent onto Kubernetes (via the `hermes-agent-helm` Helm chart, on a kind cluster) and verify it reaches Solar Open 2 | [![verify-07](https://github.com/jyje/pilot-upstage-solar-open2/actions/workflows/verify-07-hermes-agent-helm-solar-open2.yml/badge.svg)](https://github.com/jyje/pilot-upstage-solar-open2/actions/workflows/verify-07-hermes-agent-helm-solar-open2.yml) |
| [Case 08 — Solar Open 2 x omp](08-omp-solar-open2/) | Extend | Run omp (oh-my-pi) against Solar Open 2 as a custom model provider, including a real build task graded by a headless browser | [![verify-08](https://github.com/jyje/pilot-upstage-solar-open2/actions/workflows/verify-08-omp-solar-open2.yml/badge.svg)](https://github.com/jyje/pilot-upstage-solar-open2/actions/workflows/verify-08-omp-solar-open2.yml) |
| [Case 09 — Solar Open 2 x Codex](09-codex-upstage-solar-open2/) | Extend | Run OpenAI Codex against Solar Open 2 through a LiteLLM Responses-API bridge, since Codex only speaks the Responses wire protocol | [![verify-09](https://github.com/jyje/pilot-upstage-solar-open2/actions/workflows/verify-09-codex-upstage-solar-open2.yml/badge.svg)](https://github.com/jyje/pilot-upstage-solar-open2/actions/workflows/verify-09-codex-upstage-solar-open2.yml) |

**Review** cases validate that Solar Open 2 works correctly in an
existing, official harness path. **Extend** cases go further, wiring
Solar Open 2 into a broader ecosystem (LangChain, custom agent code)
beyond what those harnesses ship out of the box.

## Composition & intent

Each case demonstrates the same model, Solar Open 2, wired into a
*different* existing, popular agent harness or framework — not a custom
harness built from scratch for this repo. The point is to show that Solar
Open 2 is a drop-in backend for the open agent ecosystem people already
use, not something that requires bespoke tooling:

- **Case 01/03** — Anthropic's own Claude Code CLI and Claude Agent SDK,
  routed at Solar Open 2 instead of Anthropic's models.
- **Case 02** — NousResearch's Hermes Agent, via its own bundled Upstage
  provider.
- **Case 04** — LangChain's `deepagents`, with `langchain-upstage`
  supplying the model.
- **Case 05** — `openwiki` (LangChain AI), an agent-readable-wiki
  generator, documenting this very repo.
- **Case 06** — xAI's Grok Build CLI, via its own "any custom model"
  config mechanism.
- **Case 07** — the community `hermes-agent-helm` Helm chart, deploying
  the same Hermes Agent from Case 02 onto Kubernetes instead of a single
  `docker run`.
- **Case 08** — omp (oh-my-pi), a terminal coding agent forked from Pi,
  via its own custom OpenAI-compatible provider mechanism — the only
  case asked to actually build something, not just answer a prompt.
- **Case 09** — OpenAI's Codex CLI, which only speaks the Responses wire
  protocol, bridged to Solar Open 2's Chat Completions endpoint via a
  local LiteLLM proxy — promoted from an unnumbered draft once the
  bridge was verified end to end.

Every case is self-contained: its own `README.md`/`README-ko.md`, its own
`scripts/verify.sh` that exercises real Upstage API calls (no mocks), and
its own entry in the shared CI workflow. See [`PLAN.md`](PLAN.md) for the
full plan and findings behind each case, [`AGENTS.md`](AGENTS.md) for repo
structure and conventions, and [`CONTRIBUTING.md`](CONTRIBUTING.md) for how
to add a new case or run everything locally.

Want to run a case yourself, step by step, right now? The
[Use Case Guide](docs/REPRODUCE.md) walks through the exact prerequisites
and commands for every case, one case at a time (English/Korean).

## Why Solar Open 2 fits existing agent harnesses

Every case above reached Solar Open 2 through a wire-compatible endpoint a
mainstream framework already speaks, not a custom client:

- Case 01/03 route Claude Code / the Claude Agent SDK at Solar Open 2's
  Anthropic-compatible endpoint via `ANTHROPIC_BASE_URL` +
  `ANTHROPIC_AUTH_TOKEN`. A real finding along the way: `ANTHROPIC_API_KEY`
  hangs against Upstage, `ANTHROPIC_AUTH_TOKEN` is required.
- Case 02's Hermes Agent ships a first-class, built-in `upstage` provider.
  No bridge needed at all.
- Case 04's `ChatUpstage` (from `langchain-upstage`) is a thin
  `BaseChatOpenAI` subclass pointed at Upstage's OpenAI-compatible
  endpoint — no bridge, no proxy.
- Case 05's `openwiki` reaches Solar Open 2 through its generic
  `openai-compatible` provider. Its `anthropic` provider is a confirmed
  dead end here: the client only ever sends `apiKey` (`x-api-key`), never
  `authToken` (`Authorization: Bearer`). Upstage's Anthropic-compatible
  endpoint rejects `x-api-key` outright — see
  [Case 05's README](05-langchain-openwiki-solar-open2/README.md) for the
  full trace.
- Case 06's Grok Build lets a custom model declare its own wire
  protocol (`chat_completions`, `responses`, or `messages`) per entry —
  pointed at `chat_completions`, it reaches Solar Open 2 directly. Basic
  chat works; tool-calling hits the same streamed-response bug as Case
  05's Finding 2, with no client-side fix available since Grok Build is
  closed-source — see
  [Case 06's README](06-grok-build-solar-open2/README.md) for the full
  trace.
- Case 07's `hermes-agent-helm` deploys Hermes Agent onto Kubernetes and
  reaches Solar Open 2 through the exact same `upstage` provider Case 02
  already verified — the deployment layer changes, the wire path to
  Solar Open 2 doesn't. See
  [Case 07's README](07-hermes-agent-helm-solar-open2/README.md) for the
  full trace.
- Case 08's omp registers Solar Open 2 as a custom `openai-completions`
  provider in its own `models.yml` — same OpenAI-compatible wire path as
  Case 04/05/06, no bridge. One required fix: `compat.supportsStore:
  false`, since omp defaults to sending a `store` field Upstage's
  endpoint rejects. See
  [Case 08's README](08-omp-solar-open2/README.md) for the full trace.
- Case 09's Codex only speaks the Responses API, which Upstage doesn't
  implement (Chat Completions is its only surface) — a real protocol
  mismatch, not a config gap. A local LiteLLM proxy bridges
  Responses → Chat Completions (the `openai/chat_completions/<model>`
  model prefix), the same technique [`docker/`](docker/) uses to bridge
  Claude Code's Anthropic Messages protocol for Solar Pro4. See
  [Case 09's README](09-codex-upstage-solar-open2/README.md) for the full
  trace.

The practical upshot: adding a new agent harness to this list is mostly
configuration (base URL, auth style, model ID), not new integration code,
as long as the harness already speaks OpenAI- or Anthropic-shaped wire
formats.

## Solar Pro4

Every case above is also locally re-verified against **Solar Pro4**
(full logs in [`logs/local-verification/`](logs/local-verification/),
2026-08-03). Cases 02, 04-08 reach Solar Pro4 the same way they reach
Solar Open 2 — directly, over Upstage's OpenAI-compatible endpoint, no
proxy involved, since Pro4 is fully supported there.

Cases 01, 03, and 09 are different: they speak Claude Code's Anthropic
Messages protocol or Codex's Responses protocol, and **Upstage's own
Anthropic-compatible endpoint has no model mapping for `solar-pro4`** —
a client pointed there directly gets no response, confirmed via Case 01
first, then a `[codex#01] pilot-upstage-solar-open2` Codex session
independently hitting the same dead end. Pro4 works fine over Upstage's
Chat Completions endpoint (the same one every other case already uses);
it's specifically the Anthropic-shaped entry point that's missing the
mapping.

[`docker/`](docker/) is the fix for that gap: a docker-compose LiteLLM
proxy that speaks Anthropic Messages / Responses API on the client-facing
side and bridges to Upstage's Chat Completions underneath — the same
`use_chat_completions_url_for_anthropic_messages` /
`openai/chat_completions/<model>` techniques Case 09's own bridge uses
for Codex. Point `ANTHROPIC_BASE_URL` at the local proxy instead of
Upstage directly, and Solar Pro4 becomes reachable from Claude Code (or
`claude-upstage`) exactly like Solar Open 2 already is.

| Case | Solar Pro4 path | Result |
| --- | --- | --- |
| 01 — Claude Code | via `docker/`'s Anthropic Messages bridge | ✅ |
| 02 — Hermes Agent | direct (Upstage's built-in provider) | ✅ |
| 03 — Claude Agent SDK | via `docker/`'s Anthropic Messages bridge | ✅ |
| 04 — LangChain Deepagents | direct | ✅ (Methods A/B; Method C rate-limited under heavy same-day testing, not a Pro4 defect) |
| 05 — LangChain OpenWiki | direct | ✅ |
| 06 — Grok Build | direct | ✅ |
| 07 — Hermes Agent Helm | direct | ✅ |
| 08 — omp | direct | ✅ |
| 09 — Codex | via its own Responses-API LiteLLM bridge | ✅ |

## Verified against Tier 0 — limits & mitigations

Every case here runs against Upstage's **default Tier 0** account limits:
100 requests/minute and 50,000 tokens/minute for Solar chat models (see
[Upstage's rate-limit guide](https://console.upstage.ai/ko/docs/guides/rate-limits)).
Building a reliable CI verification loop on top of that surfaced three
real failure modes, and how each is handled:

1. **Leftover budget between cases.** Running all cases back-to-back in
   one sequential job, a case starting right after a heavier one could
   inherit partial headroom. That headroom looked "enough" by a naive
   threshold check, but wasn't. Fixed: every case now waits for the
   token/request budget to be **fully** reset before it starts
   ([`scripts/wait-for-upstage-full-reset.sh`](scripts/wait-for-upstage-full-reset.sh),
   10-minute cap).
2. **A single call exhausting the budget.** Case 05's `openwiki` makes
   several sequential tool-calling round trips per question, each
   resending the full system prompt and tool schemas. One question alone
   was observed to burn 36,440 of a 49,998-token budget. Because
   Upstage's limit is a *rolling* per-minute window, not a fixed reset
   clock, retries kept seeing 0 tokens remaining even past the reported
   reset instant. Fixed: the same full-reset wait now runs before every
   retry attempt inside Case 05, not just once per case.
3. **`solar-pro3` needs more than Tier 0 offers** for Case 05
   specifically. Its agentic loop's cumulative usage across a handful of
   calls exceeds the 50k/minute budget outright, independent of any
   leftover-budget issue. Not a bug in this repo's code — expected to
   work once the account is on **Tier 1 or above**. Full trace in
   [`PLAN.md`](PLAN.md)'s Case 05, Finding 4.

This is why [`verify-all-sequential.yml`](.github/workflows/verify-all-sequential.yml)
runs every case **one at a time**, waiting on real Upstage rate-limit
response headers instead of a fixed guessed delay. Expect a full run to
take on the order of 10-20+ minutes on a Tier-0 account. A higher tier
would make the waits mostly disappear, but nothing here assumes one.

## Verification

The **CI** column in the table above is each case's own dedicated
`verify-0N-*.yml` workflow badge — live, not a static claim, and
clickable straight through to that case's own run history. Each case's
own README also quotes real, unedited excerpts (up to ~700 characters,
10+ wrapped lines per answer) from its **Evidence run** section, so the
model's actual reasoning is visible, not just a pass/fail line.

All cases together, in one sequential run:
[![verify-all-sequential](https://github.com/jyje/pilot-upstage-solar-open2/actions/workflows/verify-all-sequential.yml/badge.svg)](https://github.com/jyje/pilot-upstage-solar-open2/actions/workflows/verify-all-sequential.yml) —
the badge at the top of this page, or browse
[every run](https://github.com/jyje/pilot-upstage-solar-open2/actions/workflows/verify-all-sequential.yml)
directly.

## Contributing

See [`CONTRIBUTING.md`](CONTRIBUTING.md) for repo conventions, local dev
commands for every case, and how to add a new one.

## License

[MIT](LICENSE) — this repo's own code and docs. This does not cover
Solar Open 2 itself, which ships under its own
[Upstage Solar License](https://huggingface.co/upstage/Solar-Open2-250B),
or any third-party harness (Claude Code, Hermes Agent, Grok Build,
omp, etc.), each under its own upstream license.
