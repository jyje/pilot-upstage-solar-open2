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

<div class="upstage-brand">
  <div class="upstage-brand-jyje">
    <img class="upstage-brand-jyje-logo" src="https://jyje.online/assets/icons/icon-128x128.png" alt="" />
    <span class="upstage-brand-jyje-text">jyje</span>
  </div>
  <span class="upstage-brand-x">×</span>
  <div class="upstage-brand-upstage">
    <img class="upstage-brand-logo" src="https://raw.githubusercontent.com/lobehub/lobe-icons/f07e9be35aef452ce735f95ea8204a14ecc513f7/packages/static-svg/icons/upstage-color.svg" alt="" />
    <img class="upstage-brand-text" src="https://raw.githubusercontent.com/lobehub/lobe-icons/f07e9be35aef452ce735f95ea8204a14ecc513f7/packages/static-svg/icons/upstage-text.svg" alt="Upstage" />
  </div>
</div>

# jyje/pilot-upstage-solar-open2

<div class="cover-readme-hero">
  <img class="cover-readme-image" src="/images/agent-ecosystem.png" alt="Solar Open 2 agent ecosystem" />
  <p class="cover-readme-tagline"><Localized en="✨ Testing multiple agent harnesses powered by the Upstage Solar Open 2 model: Claude Code, Hermes Agent (also verified on Kubernetes), Claude Agent SDK, LangChain Deepagents, OpenWiki, and Grok Build" ko="✨ Upstage Solar Open 2 기반의 다양한 에이전트 하네스를 검증합니다: Claude Code, Hermes Agent(쿠버네티스 배포도 검증), Claude Agent SDK, LangChain Deepagents, OpenWiki, Grok Build" /></p>
  <div class="cover-badges" aria-label="Project status badges">
    <a href="https://github.com/jyje/pilot-upstage-solar-open2/actions/workflows/verify-all-sequential.yml" target="_blank" rel="noreferrer"><img src="https://github.com/jyje/pilot-upstage-solar-open2/actions/workflows/verify-all-sequential.yml/badge.svg" alt="verify all sequential status" /></a>
    <a href="https://docs.python.org/3.13/" target="_blank" rel="noreferrer"><img src="https://img.shields.io/badge/python-3.13-3776AB?logo=python&amp;logoColor=white" alt="Python 3.13" /></a>
  </div>
  <p class="cover-external-links-label"><Localized en="External links:" ko="외부 링크:" /></p>
  <div class="cover-badges" aria-label="External links">
    <a href="https://huggingface.co/upstage/Solar-Open2-250B" target="_blank" rel="noreferrer"><img src="https://img.shields.io/badge/%F0%9F%A4%97_Hugging_Face-upstage/solar--open2--250b-yellow" alt="Model on Hugging Face" /></a>
    <a href="https://huggingface.co/upstage/Solar-Open2-250B/blob/main/Solar_Open_2_Tech_Report.pdf" target="_blank" rel="noreferrer"><img src="https://img.shields.io/badge/%F0%9F%93%84_Technical_Report-PDF-blue" alt="Technical Report" /></a>
    <a href="https://www.youtube.com/live/6XX-yR3qomM" target="_blank" rel="noreferrer"><img src="https://img.shields.io/badge/%F0%9F%93%BA_Launch_Event-YouTube-red" alt="Launch Event" /></a>
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

<div class="case-pill">CASE 01</div>

# Claude Code

## <Localized en="Route Anthropic's own CLI through Solar Open 2 — three ways, zero forks" ko="Claude 공식 CLI를 Solar Open 2로 라우팅 — 3가지 방법, 포크 없이" />

<div class="case-card">
  <p class="case-card-desc"><Localized en="Plain env vars redirect the official claude binary to Upstage. No fork, no patch, no proxy." ko="환경변수만으로 공식 claude 바이너리를 Upstage로 리다이렉트합니다. 포크도, 패치도, 프록시도 필요 없습니다." /></p>
  <div class="case-card-highlights">
    <div class="case-chip"><span class="case-chip-icon">🔓</span><span><Localized en="Vendor lock-in is thinner than assumed — an open model runs inside Anthropic's own harness untouched" ko="벤더 종속은 생각보다 얕습니다 — 오픈 모델이 Anthropic 하네스 안에서 그대로 동작" /></span></div>
    <div class="case-chip"><span class="case-chip-icon">🎯</span><span><Localized en="Solar Open 2 honors a skill's contract precisely once named — capability is there, discovery needs a nudge" ko="스킬을 지목하면 규약을 정확히 지킵니다 — 능력은 충분하고, 발동만 유도하면 됨" /></span></div>
  </div>
  <div class="case-evidence">
    <div class="case-evidence-label"><Localized en="Verified in CI" ko="CI 검증 결과" /></div>
    <div class="case-evidence-row"><span class="case-evidence-method">A</span><span class="case-evidence-result"><Localized en="Identifies itself as Solar Open2 by Upstage through the official CLI" ko="공식 CLI로 Upstage의 Solar Open2임을 스스로 식별" /></span></div>
    <div class="case-evidence-row"><span class="case-evidence-method">B</span><span class="case-evidence-result"><Localized en="Reads this repo's real AGENTS.md — full harness with tool access, not a canned reply" ko="이 리포의 실제 AGENTS.md를 읽음 — 정해진 응답이 아닌 툴 접근 포함 완전한 하네스" /></span></div>
    <div class="case-evidence-row"><span class="case-evidence-method">C</span><span class="case-evidence-result"><Localized en="Subagent listed real directory files under CLAUDE_CODE_SUBAGENT_MODEL" ko="CLAUDE_CODE_SUBAGENT_MODEL로 서브에이전트가 실제 디렉터리 파일을 나열" /></span></div>
  </div>
</div>

---

<div class="case-pill">CASE 02</div>

# Hermes Agent

## <Localized en="Official Docker image, built-in Upstage provider" ko="공식 Docker 이미지, 내장 Upstage 프로바이더" />

<div class="case-card">
  <p class="case-card-desc"><Localized en="Hermes Agent v0.18.2 ships an upstage provider out of the box — no local plugin, no LiteLLM proxy." ko="Hermes Agent v0.18.2는 upstage 프로바이더를 기본 내장합니다 — 로컬 플러그인도, LiteLLM 프록시도 필요 없습니다." /></p>
  <div class="case-card-highlights">
    <div class="case-chip"><span class="case-chip-icon">🏅</span><span><Localized en="Solar Open 2 is a first-class citizen upstream — Hermes ships the provider, no community patch needed" ko="업스트림이 Solar Open 2를 1급 시민으로 대우 — 커뮤니티 패치 없이 제공자 기본 탑재" /></span></div>
    <div class="case-chip"><span class="case-chip-icon">🧾</span><span><Localized en="The untruncated reasoning trace shows the model deliberating, not just emitting — real agentic behavior" ko="잘리지 않은 추론 트레이스가 숙고 과정을 보여줍니다 — 출력이 아닌 진짜 에이전트 행동" /></span></div>
  </div>
  <div class="case-evidence">
    <div class="case-evidence-label"><Localized en="Verified in CI" ko="CI 검증 결과" /></div>
    <div class="case-evidence-row"><span class="case-evidence-method">A</span><span class="case-evidence-result"><Localized en="Image reports Hermes Agent v0.18.2, pinned by digest" ko="이미지가 Hermes Agent v0.18.2 보고, 다이제스트로 고정" /></span></div>
    <div class="case-evidence-row"><span class="case-evidence-method">B</span><span class="case-evidence-result"><Localized en="hermes doctor reports Upstage Solar connectivity healthy" ko="hermes doctor가 Upstage Solar 연결 정상 보고" /></span></div>
    <div class="case-evidence-row"><span class="case-evidence-method">C</span><span class="case-evidence-result"><Localized en="Round trip returns hermes-ready after a visible reasoning pass" ko="추론 과정이 보인 뒤 hermes-ready 응답 반환" /></span></div>
  </div>
</div>

---

<div class="case-pill">CASE 03</div>

# Claude Agent SDK

## <Localized en="Drive Claude Code programmatically from Python" ko="Python에서 Claude Code를 프로그래밍 방식으로 제어" />

<div class="case-card">
  <p class="case-card-desc"><Localized en="Same env var recipe as Case 01, passed through ClaudeAgentOptions — proves the SDK, not just the CLI." ko="Case 01과 동일한 환경변수 레시피를 ClaudeAgentOptions로 전달 — CLI뿐 아니라 SDK까지 증명." /></p>
  <div class="case-card-highlights">
    <div class="case-chip"><span class="case-chip-icon">🏗️</span><span><Localized en="Solar Open 2 can sit under application code, not just a terminal — the SDK path opens real product surfaces" ko="터미널을 넘어 애플리케이션 코드 아래에 놓입니다 — SDK 경로가 실제 제품 표면을 엽니다" /></span></div>
    <div class="case-chip"><span class="case-chip-icon">🔍</span><span><Localized en="Tool use is observable as structured messages — you can build guardrails on it, not guess from stdout" ko="툴 사용이 구조화된 메시지로 관측됩니다 — stdout 추측이 아닌 가드레일 구축이 가능" /></span></div>
  </div>
  <div class="case-evidence">
    <div class="case-evidence-label"><Localized en="Verified in CI" ko="CI 검증 결과" /></div>
    <div class="case-evidence-row"><span class="case-evidence-method">A</span><span class="case-evidence-result"><Localized en="Structured types returned: AssistantMessage, ResultMessage, SystemMessage" ko="구조화된 타입 반환: AssistantMessage, ResultMessage, SystemMessage" /></span></div>
    <div class="case-evidence-row"><span class="case-evidence-method">B</span><span class="case-evidence-result"><Localized en="Session memory — turn 2 recalled 42 from turn 1" ko="세션 메모리 — 2번째 턴이 1번째 턴의 42를 회상" /></span></div>
    <div class="case-evidence-row"><span class="case-evidence-method">C</span><span class="case-evidence-result"><Localized en="saw_tool_use=True — a real ToolUseBlock in the message stream" ko="saw_tool_use=True — 메시지 스트림에 실제 ToolUseBlock" /></span></div>
  </div>
</div>

---

<div class="case-pill">CASE 04</div>

# LangChain DeepAgents

## <Localized en="Pure code-level agent, no Claude CLI involved" ko="Claude CLI 없이 순수 코드 레벨 에이전트로 동작" />

<div class="case-card">
  <p class="case-card-desc"><Localized en="ChatUpstage talks to Upstage's OpenAI-compatible endpoint directly — no ANTHROPIC_BASE_URL dance." ko="ChatUpstage가 Upstage의 OpenAI 호환 엔드포인트와 직접 통신 — ANTHROPIC_BASE_URL 설정이 필요 없습니다." /></p>
  <div class="case-card-highlights">
    <div class="case-chip"><span class="case-chip-icon">🌉</span><span><Localized en="No Claude runtime anywhere — the OpenAI-compatible endpoint makes Solar Open 2 a drop-in for the LangChain ecosystem" ko="Claude 런타임이 전혀 없습니다 — OpenAI 호환 엔드포인트가 LangChain 생태계의 드롭인 대체재로 만듭니다" /></span></div>
    <div class="case-chip"><span class="case-chip-icon">🐍</span><span><Localized en="The only blocker was the Python ecosystem, not the model — a missing wheel, resolved by pinning 3.13" ko="유일한 블로커는 모델이 아니라 Python 생태계였습니다 — 휠 부재, 3.13 고정으로 해결" /></span></div>
  </div>
  <div class="case-evidence">
    <div class="case-evidence-label"><Localized en="Verified in CI" ko="CI 검증 결과" /></div>
    <div class="case-evidence-row"><span class="case-evidence-method">A</span><span class="case-evidence-result"><Localized en="Custom tool called correctly — It's sunny in Seoul!" ko="커스텀 툴 정상 호출 — It's sunny in Seoul!" /></span></div>
    <div class="case-evidence-row"><span class="case-evidence-method">B</span><span class="case-evidence-result"><Localized en="Wrote HELLO-DEEPAGENTS into the mock filesystem at /note.txt" ko="가상 파일시스템 /note.txt에 HELLO-DEEPAGENTS 기록" /></span></div>
    <div class="case-evidence-row"><span class="case-evidence-method">C</span><span class="case-evidence-result"><Localized en="Delegated to math-agent, which returned 17 + 25 = 42" ko="math-agent에 위임해 17 + 25 = 42 반환" /></span></div>
  </div>
</div>

---

<div class="case-pill">CASE 05</div>

# LangChain OpenWiki

## <Localized en="Self-documenting this very repository" ko="이 리포 자체를 스스로 문서화" />

<div class="case-card">
  <p class="case-card-desc"><Localized en="openwiki builds an agent-readable wiki for the codebase and answers real questions about it." ko="openwiki가 코드베이스를 위한 에이전트 친화적 위키를 만들고, 그에 대한 실제 질문에 답합니다." /></p>
  <div class="case-card-highlights">
    <div class="case-chip"><span class="case-chip-icon">📖</span><span><Localized en="The model reads an unfamiliar codebase and answers accurately about its latest commit — comprehension at repo scale" ko="처음 보는 코드베이스를 읽고 최신 커밋까지 정확히 답합니다 — 리포 단위의 이해력" /></span></div>
    <div class="case-chip"><span class="case-chip-icon">🐛</span><span><Localized en="Found a real upstream bug: streaming drops tool call names — open models let you trace and fix, not just file a ticket" ko="실제 업스트림 버그 발견: 스트리밍이 툴콜 이름을 누락 — 오픈 모델은 티켓 제출이 아니라 추적과 수정을 허용합니다" /></span></div>
  </div>
  <div class="case-evidence">
    <div class="case-evidence-label"><Localized en="Verified in CI — 3 live Q&amp;A rounds" ko="CI 검증 결과 — 실제 Q&amp;A 3라운드" /></div>
    <div class="case-evidence-row"><span class="case-evidence-method">Q1</span><span class="case-evidence-result"><Localized en="Explored the repo and summarized every case in a structured table" ko="리포를 탐색해 모든 케이스를 표로 정리해 요약" /></span></div>
    <div class="case-evidence-row"><span class="case-evidence-method">Q2</span><span class="case-evidence-result"><Localized en="Named the most recent commit — hash, message, intent, co-authors" ko="최신 커밋 특정 — 해시, 메시지, 의도, 공동 작성자" /></span></div>
    <div class="case-evidence-row"><span class="case-evidence-method">Q3</span><span class="case-evidence-result"><Localized en="Counted the cases and explained what each one demonstrates" ko="케이스 개수를 세고 각각이 무엇을 증명하는지 설명" /></span></div>
  </div>
</div>

---

<div class="case-pill">CASE 06</div>

# Grok Build

## <Localized en="xAI's terminal coding agent as a custom model" ko="xAI의 터미널 코딩 에이전트를 커스텀 모델로 연결" />

<div class="case-card">
  <p class="case-card-desc"><Localized en="A user-level config.toml entry lets Grok Build pick chat_completions as its wire protocol." ko="사용자 레벨 config.toml 설정만으로 Grok Build가 chat_completions 프로토콜을 선택하도록 만듭니다." /></p>
  <div class="case-card-highlights">
    <div class="case-chip"><span class="case-chip-icon">🔌</span><span><Localized en="A rival's own coding agent accepts Solar Open 2 as a custom model — the ecosystem is more open than the branding suggests" ko="경쟁사 코딩 에이전트가 Solar Open 2를 커스텀 모델로 수용 — 브랜딩보다 생태계가 훨씬 개방적입니다" /></span></div>
    <div class="case-chip"><span class="case-chip-icon">🚧</span><span><Localized en="Where the harness is closed, one upstream bug ends the story — a case for open weights and open clients" ko="하네스가 닫혀 있으면 업스트림 버그 하나로 끝납니다 — 오픈 웨이트와 오픈 클라이언트가 필요한 이유" /></span></div>
  </div>
  <div class="case-evidence">
    <div class="case-evidence-label"><Localized en="Verified in CI" ko="CI 검증 결과" /></div>
    <div class="case-evidence-row"><span class="case-evidence-method">A</span><span class="case-evidence-result"><Localized en="Exact-string round trip returned grok-solar-ready" ko="정확한 문자열 라운드트립이 grok-solar-ready 반환" /></span></div>
    <div class="case-evidence-row"><span class="case-evidence-method">B</span><span class="case-evidence-result"><Localized en="Derived 1275 via both the Gauss formula and the pairing method" ko="가우스 공식과 짝짓기 방법 양쪽으로 1275 도출" /></span></div>
    <div class="case-evidence-row"><span class="case-evidence-method">C</span><span class="case-evidence-result"><Localized en="Wrote a correct, working is_prime(n) with a docstring" ko="독스트링 포함 정상 동작하는 is_prime(n) 작성" /></span></div>
  </div>
</div>

---

<div class="case-pill">CASE 07</div>

# Hermes Agent Helm

## <Localized en="Kubernetes deployment on an ephemeral kind cluster" ko="일회성 kind 클러스터 위 쿠버네티스 배포" />

<div class="case-card">
  <p class="case-card-desc"><Localized en="Case 02 proved the Docker image. This proves the same provider path survives a real Helm/Kubernetes deployment." ko="Case 02가 Docker 이미지를 증명했다면, 이 케이스는 동일한 프로바이더 경로가 실제 Helm/쿠버네티스 배포에서도 살아남음을 증명합니다." /></p>
  <div class="case-card-highlights">
    <div class="case-chip"><span class="case-chip-icon">☸️</span><span><Localized en="It survives the way operators actually ship — a published Helm chart on a real cluster, not a laptop demo" ko="운영자가 실제로 배포하는 방식에서 살아남습니다 — 노트북 데모가 아닌 공개 Helm 차트와 실제 클러스터" /></span></div>
    <div class="case-chip"><span class="case-chip-icon">🔬</span><span><Localized en="The chart's own test Job gates the model — verification becomes declarative infrastructure, not a manual step" ko="차트 자체 테스트 Job이 모델을 게이트합니다 — 검증이 수동 절차가 아닌 선언적 인프라가 됩니다" /></span></div>
  </div>
  <div class="case-evidence">
    <div class="case-evidence-label"><Localized en="Verified in CI" ko="CI 검증 결과" /></div>
    <div class="case-evidence-row"><span class="case-evidence-method">A</span><span class="case-evidence-result"><Localized en="Helm-test Job returned hermes-k8s-ready with a full doctor report" ko="Helm 테스트 Job이 doctor 리포트와 함께 hermes-k8s-ready 반환" /></span></div>
    <div class="case-evidence-row"><span class="case-evidence-method">B</span><span class="case-evidence-result"><Localized en="Live kubectl exec — the running pod derived 1275 via Gauss" ko="실시간 kubectl exec — 구동 중인 파드가 가우스 공식으로 1275 도출" /></span></div>
    <div class="case-evidence-row"><span class="case-evidence-method">C</span><span class="case-evidence-result"><Localized en="76 lines on its own strengths in reasoning, tool use, and coding" ko="추론·툴 사용·코딩 강점에 대해 76줄 자체 서술" /></span></div>
  </div>
</div>

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
