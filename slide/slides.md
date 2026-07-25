---
theme: ./themes/upstage
colorSchema: dark
aspectRatio: 9/16
canvasWidth: 720
routerMode: hash
fonts:
  provider: 'google'
  config:
    heading:
      global: 'Inter'
      bold: true
    body:
      global: 'Inter'
    mono:
      global: 'JetBrains Mono'
---

<div class="upstage-eyebrow">UPSTAGE × OPEN SOURCE AGENTS</div>

# jyje/pilot-upstage-solar-open2

<div class="cover-readme-hero">
  <img class="cover-readme-image" src="/images/agent-ecosystem.png" alt="Solar Open 2 agent ecosystem" />
  <p class="cover-readme-tagline"><Localized en="✨ Testing multiple agent harnesses powered by the Upstage Solar Open 2 model" ko="✨ Upstage Solar Open 2 기반의 다양한 에이전트 하네스를 검증합니다" /></p>
  <div class="cover-badges" aria-label="Project status badges">
    <a href="https://github.com/jyje/pilot-upstage-solar-open2/actions/workflows/verify-all-sequential.yml" target="_blank" rel="noreferrer"><img src="https://github.com/jyje/pilot-upstage-solar-open2/actions/workflows/verify-all-sequential.yml/badge.svg" alt="verify all sequential status" /></a>
    <a href="https://docs.python.org/3.13/" target="_blank" rel="noreferrer"><img src="https://img.shields.io/badge/python-3.13-3776AB?logo=python&amp;logoColor=white" alt="Python 3.13" /></a>
  </div>
</div>

**Solar Open 2 × Agent Harness Experiments**

_<Localized en="A pilot project that verifies Solar Open 2 across agent frameworks and real operating environments." ko="Upstage의 Solar Open 2 모델로 다양한 에이전트 프레임워크를 검증하고, 실제 운영 환경에서의 동작 가능성을 확인하는 파일럿 프로젝트" />_

<div class="upstage-stat-grid">
  <div class="upstage-stat">
    <div class="upstage-stat-value">07</div>
    <div class="upstage-stat-label">Agent harnesses</div>
  </div>
  <div class="upstage-stat">
    <div class="upstage-stat-value">01</div>
    <div class="upstage-stat-label">Solar Open 2 · 250B-A15B MoE</div>
  </div>
  <div class="upstage-stat">
    <div class="upstage-stat-value">CI</div>
    <div class="upstage-stat-label">Verified in GitHub Actions</div>
  </div>
</div>

---

# Solar Open 2

## Upstage's 250B MoE Model

<v-click>

### <Localized en="Model specification" ko="모델 스펙" />

| <Localized en="Attribute" ko="항목" /> | <Localized en="Value" ko="내용" /> |
|------|------|
| **<Localized en="Parameters" ko="파라미터" />** | 250B total / 15B active (MoE) |
| **<Localized en="Context" ko="컨텍스트" />** | 1M tokens |
| **<Localized en="License" ko="라이선스" />** | Upstage Solar License |

</v-click>

<v-click>

### <Localized en="Design goals" ko="설계 목적" />

- **Long-horizon agentic tasks** — <Localized en="tool use, multi-step reasoning, and end-to-end task execution" ko="툴 사용, 다단계 추론, 엔드투엔드 태스크 실행" />
- **Hybrid linear/softmax attention** — <Localized en="efficient processing at 1M context" ko="1M 컨텍스트에서 효율적 처리" />
- **Korean-first** — <Localized en="top Korean benchmark performance" ko="한국어 벤치마크 최상위 성능" />

</v-click>

---

# <Localized en="Project structure" ko="프로젝트 구조" />

## <Localized en="Seven independent cases, one repository" ko="7개 독립 케이스, 1개 리포" />

<v-click>

### <Localized en="Review cases" ko="리뷰 케이스 (Review)" />

- **Case 01** — <Localized en="Route the Claude Code harness to Solar Open 2" ko="Claude Code harness를 Solar Open 2로 라우팅" />
- **Case 02** — <Localized en="Run through the official Hermes Agent provider" ko="Hermes Agent 공식 제공자로 실행" />

</v-click>

<v-click>

### <Localized en="Extended cases" ko="익스텐드 케이스 (Extend)" />

- **Case 03** — <Localized en="Control Claude Code with the Claude Agent SDK" ko="Claude Agent SDK로 Claude Code 제어" />
- **Case 04** — LangChain Deepagents + langchain-upstage
- **Case 05** — <Localized en="Self-document the repository with OpenWiki" ko="OpenWiki로 리포 자기 문서화" />
- **Case 06** — <Localized en="Connect Grok Build CLI to a custom model" ko="Grok Build CLI를 커스텀 모델로 연결" />
- **Case 07** — <Localized en="Deploy the Hermes Agent Helm chart to a kind cluster" ko="Hermes Agent Helm 차트, kind 클러스터 배포" />

</v-click>

---

# Case 01 — Solar Open 2 × Claude Code

## Three ways to route Claude Code through Solar Open 2

<v-click>

### Case 01A — Official CLI (plain env vars)

- `ANTHROPIC_BASE_URL="https://api.upstage.ai"`
- Map every model slot: `ANTHROPIC_DEFAULT_SONNET_MODEL`, `ANTHROPIC_DEFAULT_FABLE_MODEL`, `CLAUDE_CODE_SUBAGENT_MODEL`, …
- **No fork, no patch, no proxy**

### Case 01B — `claude-upstage` wrapper

- Upstage's convenience script sets env vars via `set_claude_env`, then `exec`s stock `claude`
- Same exact binary as 01A — just a thinner wrapper
- **Known limitation:** doesn't pass `-p` through; pipe via stdin instead

### Case 01C — `jyje/claude-docker`

- Community Docker image (`ghcr.io/jyje/claude-docker`) with `claude` at entrypoint
- Same `ANTHROPIC_*` env var recipe as 01A, passed through `docker run -e`

</v-click>

<v-click>

## Key Findings

</v-click>

<v-click>

### 🎯 Skill invocation: explicit beats autonomous

- Without naming the skill: Solar Open 2 **silently drops** the required `gitmoji + type(domain):` format
- With explicit skill name: correct every time — picks up the contract precisely
- **Takeaway:** when running Claude Code on Solar Open 2, name the skill explicitly

</v-click>

<v-click>

### 🔧 Subagents stay on Solar Open 2

- `CLAUDE_CODE_SUBAGENT_MODEL="solar-open2"` keeps Explore/Task-tool calls on the right model
- Verified: subagent listed real files in the directory — not hallucinated

</v-click>

---

# Case 02 — Solar Open 2 × Hermes Agent

## Official Docker image, built-in Upstage provider

<v-click>

### Official-support finding

Hermes Agent v0.18.2 ships an **`upstage` provider** in its official Docker image
(`solar` is an alias). No local plugin, no LiteLLM proxy, no source patch.

```yaml
model:
  provider: upstage
  default: solar-open2
```

</v-click>

<v-click>

### Important distinction

| Hermes provider support | Upstage model availability |
|---|---|
| ✅ Hermes officially recognizes Solar Open model family | ℹ️ Upstage console examples use `solar-pro3` |
| ✅ Bundled provider routes `solar-open*` to Upstage OpenAI-compatible API | 🔑 Authenticated round-trip is the real authority |

</v-click>

<v-click>

### Verification methods

1. **Version check** — image reports Hermes Agent v0.18.2
2. **`hermes doctor`** — accepts Upstage config, reports `Upstage Solar` healthy
3. **`hermes chat`** — non-interactive round trip returns `hermes-ready`

```bash
hermes chat \
  --provider upstage --model solar-open2 \
  --query "Reply with exactly: hermes-ready" \
  --max-turns 2 --quiet --ignore-rules
```

</v-click>

<v-click>

## Result

Full, untruncated reasoning trace from Solar Open 2 before it settles on the
required reply — proving the model runs through Hermes's actual agentic harness,
not a raw endpoint.

**Verified locally (2026-07-20) and in CI (2026-07-23).**

</v-click>

---

# Case 03 — Solar Open 2 × Claude Agent SDK

## Drive Claude Code programmatically from Python

<v-click>

### How it works

`claude-agent-sdk` drives the same `claude` CLI binary as a subprocess.
The **exact same Solar Open 2 env var recipe** from Case 01 applies —
just passed through `ClaudeAgentOptions(env={...})` instead of shell `export`.

```python
from claude_agent_sdk import ClaudeAgentOptions

options = ClaudeAgentOptions(
    model="solar-open2",
    env={
        "ANTHROPIC_BASE_URL": "https://api.upstage.ai",
        "ANTHROPIC_AUTH_TOKEN": upstage_api_key,
    },
)
```

</v-click>

<v-click>

### Finding: SDK docs example doesn't work against Upstage

The SDK docs show `env={"ANTHROPIC_API_KEY": ...}` — that **hangs** against Upstage.

Swapping in `ANTHROPIC_AUTH_TOKEN` (Bearer) works immediately.
Same root cause as Case 01's finding: Upstage's Anthropic-compatible endpoint
rejects `x-api-key`, requires `Authorization: Bearer`.

</v-click>

<v-click>

### Two entry points, three methods

| Method | API | What it proves |
|---|---|---|
| **A** | `query()` | Structured message types (`AssistantMessage`, `ToolUseBlock`, …) — not stdout scraping |
| **B** | `ClaudeSDKClient` | Session memory across turns — turn 2 must recall "42" from turn 1 |
| **C** | `query()` + tool visibility | A real `ToolUseBlock` appears in the message stream — programmatic proof of tool invocation |

</v-click>

<v-click>

### Verified results

| Method | Result |
|---|---|
| A — `query()` | `AssistantMessage`, `ResultMessage`, `SystemMessage` — correct types |
| B — session memory | `42` recalled correctly in turn 2 |
| C — tool visibility | `saw_tool_use=True` — real `ToolUseBlock` in stream |

</v-click>

---

# Case 04 — Solar Open 2 × LangChain DeepAgents

## Pure code-level agent, no Claude CLI involved

<v-click>

### How it works

[`ChatUpstage`](https://pypi.org/project/langchain-upstage/) is a `BaseChatOpenAI`
subclass pointed at Upstage's **OpenAI-compatible** endpoint
(`https://api.upstage.ai/v1/solar`), reading `UPSTAGE_API_KEY` from env automatically.

```python
from langchain_upstage import ChatUpstage
from deepagents import create_deep_agent

model = ChatUpstage(model="solar-open2")
agent = create_deep_agent(model=model, tools=[...], system_prompt="...")
agent.invoke({"messages": [{"role": "user", "content": "..."}]})
```

No `ANTHROPIC_BASE_URL` dance. No `claude` CLI subprocess. LangChain talks to Upstage
directly through Upstage's native OpenAI-compatible endpoint.

</v-click>

<v-click>

### Three methods

| Method | What it proves |
|---|---|
| **A — tool use** | Agent calls a custom `get_weather(city)` tool correctly |
| **B — virtual filesystem** | Agent writes to `deepagents`'s built-in mock filesystem (`/note.txt` → `HELLO-DEEPAGENTS`) |
| **C — subagent delegation** | Main agent delegates arithmetic to a named `math-agent` subagent |

</v-click>

<v-click>

### Finding: Python 3.14 doesn't work (yet)

`langchain-upstage` depends on `tokenizers` (Rust/PyO3). No `cp314` wheel exists
for any release `0.20.3` → `0.23.1`. Source build fails with a real `cargo`/PyO3
compile error — an **upstream ecosystem gap**, not a config workaround.

**This case pins Python 3.13.** Case 03 was moved down to match.

</v-click>

<v-click>

### Verified results

| Method | Result |
|---|---|
| A — tool use | `It's sunny in Seoul!` |
| B — virtual filesystem | `HELLO-DEEPAGENTS` in `result["files"]["/note.txt"]["content"]` |
| C — subagent delegation | `17 + 25 = **42**` from the `math-agent` subagent |

</v-click>

---

# Case 05 — Solar Open 2 × LangChain OpenWiki

## Self-documenting the repo with openwiki

<v-click>

### How it works

`openwiki` builds and maintains an agent-readable wiki for a codebase.
Target: **this repo itself** — document its latest commit, answer questions about it.

To keep the real root untouched, the verify script shallow-clones into a
gitignored `scratch/` directory and runs `openwiki` there.

</v-click>

<v-click>

### Finding 1: `anthropic` provider can't reach Solar Open 2

`openwiki`'s `anthropic` provider uses only `apiKey` (→ `x-api-key` header).
Upstage's Anthropic-compatible endpoint **rejects `x-api-key` with 401**.

**Workaround:** generic `openai-compatible` provider (Bearer-authenticated):

```bash
OPENWIKI_PROVIDER=openai-compatible
OPENAI_COMPATIBLE_BASE_URL=https://api.upstage.ai/v1/solar
OPENWIKI_MODEL_ID=solar-open2
```

</v-click>

<v-click>

### Finding 2: Streaming drops the tool call function name

Every tool-using run failed with `400 Invalid function name: ''`.

Root cause traced via a local logging proxy:
- Request sent all 16 tools correctly named
- **Streamed response** came back with `function.name` = `""` (empty)
- `stream: false` <Localized en="responses include the correct name" ko="응답엔 올바른 이름" /> (`"ls"`)
- **Only streamed responses are affected** — an Upstage/Solar Open 2 bug

**Workaround:** patched fork with `OPENWIKI_DISABLE_STREAMING=true`
(opt-in escape hatch, doesn't affect other providers)

</v-click>

<v-click>

### Finding 3: Full doc gen exceeds default rate limit

`openwiki code --update` sends a ~57KB system prompt per turn and needs
multiple tool-calling round trips — enough to exceed the **50,000 tokens/min**
rate limit in a single run. Capacity constraint, not a code bug.

</v-click>

<v-click>

### Verified: 3 Q&A questions

1. **"What is this repository about?"** — identifies 5 cases, Solar Open 2 specs
2. **"What did the most recent commit change?"** — commit hash, message, intent, co-authors
3. **"How many cases, what does each demonstrate?"** — structured table of all cases

</v-click>

---

# Case 06 — Solar Open 2 × Grok Build

## xAI's terminal coding agent as a custom model

<v-click>

### How it works

Grok Build reads model definitions from `config.toml` at `$GROK_HOME/config.toml`:

```toml
[model.solar-open2]
model = "solar-open2"
base_url = "https://api.upstage.ai/v1/solar"
name = "Solar Open 2 (Upstage)"
env_key = "UPSTAGE_API_KEY"
api_backend = "chat_completions"

[models]
default = "solar-open2"
```

`api_backend = "chat_completions"` is key — unlike Codex (hard-locked to Responses API),
Grok Build lets a custom model **pick its wire protocol** per entry.

</v-click>

<v-click>

### Finding 1: Custom models only work in user-level config

Project-local `.grok/config.toml` is **silently ignored** for `[model.X]` entries.
Docs say: ["project configs are limited to MCP servers, plugins, and permission
rules, not full user configs"](https://docs.x.ai/build/settings).

**Workaround:** set `$GROK_HOME` to a throwaway temp dir with a generated
`config.toml` for the duration of the run — same isolation pattern as Case 02/03.

</v-click>

<v-click>

### Finding 2: Tool-calling breaks — same root cause as Case 05

Asking Grok Build to read a local file with its built-in file tool fails:

```
Invalid function name: ''. Function names can only include alphanumeric...
```

**Same signature as Case 05's Finding 2:** Upstage's streamed responses drop
the `function.name`. Case 05 worked around it (open source, added
`OPENWIKI_DISABLE_STREAMING`). **Grok Build is closed-source** — no client-side
workaround possible. This stays a hard blocker.

</v-click>

<v-click>

### Three methods (no tools involved)

| Method | Command | What it proves |
|---|---|---|
| **A** | `grok -p "Reply with exactly: grok-solar-ready" -m solar-open2` | Exact-string round trip |
| **B** | `grok -p "Explain why sum 1..50 = 1275" -m solar-open2` | Reasoning — must return `1275` |
| **C** | `grok -p "Write is_prime(n) in Python" -m solar-open2` | Coding task — must contain `def is_prime` |

</v-click>

---

# Case 06 — Solar Open 2 × Grok Build

## Verified results

| Method | Result |
|---|---|
| A — single-turn | `grok-solar-ready` |
| B — reasoning | Correctly derived `1275` (Gauss formula + pairing method) |
| C — coding | Working `is_prime(n)` with docstring |
| Finding — tool-calling | Reproducibly fails: `Invalid function name: ''` |

---

# Case 07 — Solar Open 2 × Hermes Agent Helm

## Kubernetes deployment, ephemeral kind cluster

<v-click>

### Goal

Case 02 proved Hermes Agent's Docker image reaches Solar Open 2.
**Does the same provider path work when deployed the way a real operator runs it — as a
Kubernetes workload, installed from a published Helm chart, on an ephemeral kind cluster?**

</v-click>

<v-click>

### How it works

[`values-solar-open2.yaml`](https://github.com/jyje/pilot-upstage-solar-open2/blob/main/07-hermes-agent-helm-solar-open2/values-solar-open2.yaml)
mirrors `hermes-agent-helm`'s own `values-upstage.yaml`, with the model swapped from
`solar-pro3` to `solar-open2` (same `upstage` provider, no other change).

```yaml
config:
  model:
    provider: upstage
    default: solar-open2
  terminal:
    backend: local

env:
  UPSTAGE_API_KEY: "DUMMY_..."  # overridden at install time

tests:
  chat:
    enabled: true
    prompt: "Reply with exactly: hermes-k8s-ready"
    maxTurns: 2
    failOnError: true
```

The chart is installed from its published OCI artifact:
`oci://ghcr.io/jyje/hermes-agent-helm/hermes-agent --version 0.12.0`

</v-click>

<v-click>

### Scope note

The gateway's default entrypoint (`hermes gateway run`) is built around bridging to a
messenger (Telegram, Discord). **This case verifies the deployment itself — not a
messenger integration.** Both methods run against the gateway pod directly.

> See [Going further](#going-further) for how to add Telegram/Discord without
> changing what this case verifies.

</v-click>

<v-click>

### Three methods

| Method | What it proves |
|---|---|
| **A — chart's `tests.chat`** | Declarative Helm-test Job runs `hermes chat` inside the cluster, gated on exact string |
| **B — `kubectl exec`** | Live round trip against the running pod with a reasoning prompt (must return `1275`) |
| **C — self-reflection** | Hermes Agent itself describes Solar Open 2's strengths for agentic work |

</v-click>

---

# Case 07 — Solar Open 2 × Hermes Agent Helm

## Results and next steps

### Verified results

| Method | Result |
|---|---|
| A — `tests.chat` Job | `hermes-k8s-ready` + full `hermes doctor` report |
| B — `kubectl exec` reasoning | Correctly derived `1275` via Gauss formula |
| C — self-reflection | 76 non-empty lines on reasoning, tool use, coding ability |

### Going further: connecting a messenger

1. Create a bot with Telegram's [BotFather](https://core.telegram.org/bots#botfather)
2. Adapt `hermes-agent-helm`'s [`values-openai-and-telegram.yaml`](https://github.com/jyje/hermes-agent-helm/blob/v0.12.0/charts/hermes-agent/values-openai-and-telegram.yaml) — swap in `upstage`/`solar-open2` config, set `env.TELEGRAM_BOT_TOKEN`
3. `helm upgrade --install` with the combined values file

**Not gated by this case's verify script.** Also see [`examples/argocd/hermes-agent-upstage.yaml`](https://github.com/jyje/hermes-agent-helm/blob/v0.12.0/examples/argocd/hermes-agent-upstage.yaml) for an ArgoCD GitOps reference.

---

# Cross-Cutting Learnings

## Patterns that emerged across all 7 cases

<v-click>

### 🔑 Authentication: Bearer, not x-api-key

Upstage's Anthropic-compatible endpoint **rejects `x-api-key`** with 401.

Required: `Authorization: Bearer <key>` via `ANTHROPIC_AUTH_TOKEN`.

| Context | What to set |
|---|---|
| Claude Code CLI / SDK | `ANTHROPIC_AUTH_TOKEN` |
| LangChain `ChatAnthropic` | ❌ Don't use — it sends `x-api-key` |
| LangChain `ChatOpenAI` / `ChatUpstage` | ✅ `OPENAI_COMPATIBLE_API_KEY` (Bearer) |
| Grok Build / Hermes Agent | `UPSTAGE_API_KEY` → Bearer via provider |

</v-click>

<v-click>

### 🐛 Streaming bug: tool call function names dropped

Upstage's **streamed** Chat Completions responses return `function.name = ""`
for tool calls. Non-streamed responses are correct.

Affected cases: **05** (openwiki — patched with `OPENWIKI_DISABLE_STREAMING`),
**06** (Grok Build — no workaround, closed-source).

</v-click>

<v-click>

### 🐍 Python 3.14 ecosystem gap

`langchain-upstage` depends on `tokenizers` — no `cp314` wheel exists.
Source build fails with a real `cargo`/PyO3 compile error.

**All Python cases pin to 3.13** until an upstream wheel ships.

</v-click>

<v-click>

### 🎯 Skill / tool invocation: explicit beats autonomous

Solar Open 2 follows a skill's contract precisely **when explicitly told to load it**.
But it doesn't reliably decide on its own that a skill applies from trigger phrases alone.

**Takeaway:** name the skill explicitly in prompts.

</v-click>

<v-click>

### 🌐 Two wire paths to the same model

| Wire path | Endpoint | Used by |
|---|---|---|
| **Anthropic Messages API** (compat layer) | `https://api.upstage.ai` | Case 01, Case 03 |
| **OpenAI Chat Completions** (native) | `https://api.upstage.ai/v1/solar` | Case 04, Case 05, Case 06, Case 07 |

Both reach Solar Open 2. The OpenAI path avoids the `ANTHROPIC_AUTH_TOKEN` dance.

</v-click>

---

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

---

# Verification & CI

## Status dashboard

| Case | Status | Category | Workflow |
|---|---|---|---|
| 01 — Claude Code | ✅ Verified | Review | `verify-all-sequential` |
| 02 — Hermes Agent | ✅ Verified | Review | `verify-all-sequential` |
| 03 — Claude Agent SDK | ✅ Verified | Extend | `verify-all-sequential` |
| 04 — LangChain DeepAgents | ✅ Verified | Extend | `verify-all-sequential` |
| 05 — LangChain OpenWiki | ✅ Verified | Extend | `verify-all-sequential` |
| 06 — Grok Build | ✅ Verified | Extend | `verify-all-sequential` + standalone |
| 07 — Hermes Agent Helm | ✅ Verified | Extend | `verify-all-sequential` + standalone |

---

# Future Directions

## What's next for Solar Open 2 × agent harnesses

<v-click>

### Immediate

- **Python 3.14 support** — track `tokenizers` `cp314` wheel availability;
  move Cases 03 and 04 back to 3.14 once it ships
- **OpenWiki streaming fix upstream** — `OPENWIKI_DISABLE_STREAMING` is
  currently in a `jyje/openwiki` fork; getting it merged into `langchain-ai/openwiki`
  would unblock the public npm release
- **Upstage streaming bug resolution** — the `function.name = ""` bug affects
  Cases 05 and 06; getting it fixed upstream unblocks tool-calling for the
  entire ecosystem

</v-click>

<v-click>

### Near-term

- **Case 08+** — new harness integrations (more Kubernetes operators, more
  LangChain ecosystem tools, more IDE integrations)
- **Telegram/Discord for Case 07** — messenger integration on top of the
  verified Helm deployment (currently documented but not gated)
- **Rate-limit-aware verification** — Case 05's Finding 3 (50K tokens/min
  ceiling) could be addressed with batched/parallel verification strategies

</v-click>

<v-click>

### Ecosystem growth

- **More agent frameworks** — AutoGen, CrewAI, LlamaIndex, SWE-agent
- **More deployment targets** — EKS, GKE, cloud-managed Kubernetes
- **More model variants** — `solar-pro3`, future Solar Open releases
- **Community contributions** — every case is designed to be independently
  reproducible, extendable, and verifiable by anyone with an Upstage API key

</v-click>

<v-click>

### The bigger picture

This pilot started with a single question:

> *Can Upstage's Solar Open 2 model run through real, production-grade agent
> harnesses — not just a raw API call?*

Seven cases later, the answer is **yes** — across Claude Code, Hermes Agent,
Claude Agent SDK, LangChain, OpenWiki, Grok Build, and Kubernetes/Helm.
The remaining work is scaling that answer to more harnesses, more models,
and more operators.

</v-click>

---

# Appendix

## Quick reference for running any case

<v-click>

### Prerequisites (per case)

| Tool | Used by |
|---|---|
| `Node.js 18+` | Case 01, Case 03 |
| `Docker` | Case 01C, Case 02 |
| `Python 3.13` + `uv` | Case 03, Case 04 |
| `kind` + `kubectl` + `helm` | Case 07 |
| `grok` CLI | Case 06 |

All cases require: **`UPSTAGE_API_KEY`** — get one at
<https://console.upstage.ai/api-keys>

</v-click>

---

# Appendix

## Rate limits and API endpoints

### Rate limits (Tier 0)

| Limit | Value |
|---|---|
| Requests/minute | 100 |
| Tokens/minute | 50,000 |

Rolling window. Case 05's full doc generation can exceed the token limit
in a single run — see Finding 3 in that case's README.

### API endpoints reference

| Protocol | Endpoint | Used by |
|---|---|---|
| Anthropic Messages API (compat) | `https://api.upstage.ai` | Case 01, Case 03 |
| OpenAI Chat Completions (native) | `https://api.upstage.ai/v1/solar` | Case 04, Case 05, Case 06, Case 07 |

**Auth:** `Authorization: Bearer <key>` (`ANTHROPIC_AUTH_TOKEN`) — **not**
`x-api-key`.

---

# Appendix

## Reproduce any case locally

```bash
# Clone the repo
git clone https://github.com/jyje/pilot-upstage-solar-open2
cd pilot-upstage-solar-open2

# Each case is self-contained:
cd 01-solar-open2-harness   # or 02-..., 03-..., etc.

# Read the case-specific REPRODUCE.md for step-by-step setup
cat REPRODUCE.md

# Run the verification script
UPSTAGE_API_KEY="your-key" ./scripts/verify.sh
```

---

# Appendix

## Glossary

| Term | Meaning |
|---|---|
| **Solar Open 2** | Upstage's 250B-A15B MoE open-weight model, 1M context |
| **`ANTHROPIC_AUTH_TOKEN`** | Bearer token for Upstage's Anthropic-compatible endpoint |
| **`OPENWIKI_DISABLE_STREAMING`** | Opt-in flag to disable streaming (workaround for tool-calling bug) |
| **`api_backend`** | Grok Build config key choosing wire protocol (`chat_completions`, `responses`, `messages`) |
| **`CLAUDE_CODE_SUBAGENT_MODEL`** | Env var ensuring subagent/Task-tool calls stay on Solar Open 2 |
