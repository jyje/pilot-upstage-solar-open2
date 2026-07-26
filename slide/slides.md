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

# jyje/pilot-upstage-solar-open2

<div class="cover-readme-hero">
  <img class="cover-readme-image" src="/images/agent-ecosystem.png" alt="Solar Open 2 agent ecosystem" />
  <p class="cover-readme-tagline"><Localized en="✨ Testing multiple agent harnesses powered by the Upstage Solar Open 2 model: Claude Code, Hermes Agent (also verified on Kubernetes), Claude Agent SDK, LangChain Deepagents, OpenWiki, and Grok Build" ko="✨ Upstage Solar Open 2 기반의 다양한 에이전트 하네스를 검증합니다: Claude Code, Hermes Agent(쿠버네티스 배포도 검증), Claude Agent SDK, LangChain Deepagents, OpenWiki, Grok Build" /></p>
  <div class="cover-badges" aria-label="Project status badges">
    <a href="https://github.com/jyje/pilot-upstage-solar-open2/actions/workflows/verify-all-sequential.yml" target="_blank" rel="noreferrer"><img src="https://github.com/jyje/pilot-upstage-solar-open2/actions/workflows/verify-all-sequential.yml/badge.svg" alt="verify all sequential status" /></a>
    <a href="https://docs.python.org/3.13/" target="_blank" rel="noreferrer"><img src="https://img.shields.io/badge/python-3.13-3776AB?logo=python&amp;logoColor=white" alt="Python 3.13" /></a>
  </div>
</div>

<hr class="model-section-divider" />

# <Localized en="Model Introduction" ko="모델 소개" />

<div class="model-intro-heading">
  <img src="https://raw.githubusercontent.com/lobehub/lobe-icons/f07e9be35aef452ce735f95ea8204a14ecc513f7/packages/static-svg/icons/upstage-color.svg" alt="" />
  <img src="https://raw.githubusercontent.com/lobehub/lobe-icons/f07e9be35aef452ce735f95ea8204a14ecc513f7/packages/static-svg/icons/upstage-text.svg" alt="Upstage" />
  <span>Solar Open 2</span>
</div>

<div class="model-links">
  <div class="cover-badges" aria-label="Model links">
    <a href="https://huggingface.co/upstage/Solar-Open2-250B" target="_blank" rel="noreferrer"><img src="https://img.shields.io/badge/%F0%9F%A4%97_Hugging_Face-upstage/solar--open2--250b-yellow" alt="Model on Hugging Face" /></a>
    <a href="https://huggingface.co/upstage/Solar-Open2-250B/blob/main/Solar_Open_2_Tech_Report.pdf" target="_blank" rel="noreferrer"><img src="https://img.shields.io/badge/%F0%9F%93%84_Technical_Report-PDF-blue" alt="Technical Report" /></a>
    <a href="https://www.youtube.com/live/6XX-yR3qomM" target="_blank" rel="noreferrer"><img src="https://img.shields.io/badge/%F0%9F%93%BA_Launch_Event-YouTube-red" alt="Launch Event" /></a>
  </div>
  <a class="model-links-url" href="https://huggingface.co/upstage/Solar-Open2-250B" target="_blank" rel="noreferrer">https://huggingface.co/upstage/Solar-Open2-250B</a>
  <a class="model-links-note" href="https://console.upstage.ai/api-keys" target="_blank" rel="noreferrer"><Localized en="Anyone can use it through the official Upstage API." ko="업스테이지 공식 API를 이용하면 누구나 사용할 수 있습니다." /><br/><Localized en="Currently free with no usage limit (subject to change)" ko="현재는 무제한 무료 사용 (추후 변경 가능)" /></a>
</div>

<v-click>

<div class="model-card-grid">
  <div class="model-card">
    <div class="model-card-icon">🧠</div>
    <div class="model-card-value">250B · 15B</div>
    <div class="model-card-label"><Localized en="Total / active params (MoE)" ko="전체 / 활성 파라미터 (MoE)" /></div>
  </div>
  <div class="model-card">
    <div class="model-card-icon">📚</div>
    <div class="model-card-value">1M tokens</div>
    <div class="model-card-label"><Localized en="Context window via hybrid attention" ko="하이브리드 어텐션 기반 컨텍스트" /></div>
  </div>
  <div class="model-card">
    <div class="model-card-icon">📅</div>
    <div class="model-card-value">Jul 22, 2026</div>
    <div class="model-card-label"><Localized en="Release date" ko="공개일" /></div>
  </div>
  <div class="model-card">
    <div class="model-card-icon">🔤</div>
    <div class="model-card-value"><Localized en="Text in / text out" ko="텍스트 입력 / 출력" /></div>
    <div class="model-card-label"><Localized en="Modality — no image or audio I/O" ko="모달리티 — 이미지·오디오 입출력 없음" /></div>
  </div>
  <div class="model-card">
    <div class="model-card-icon">🌐</div>
    <div class="model-card-value">EN · KO · JA</div>
    <div class="model-card-label"><Localized en="Officially supported languages" ko="공식 지원 언어" /></div>
  </div>
  <div class="model-card">
    <div class="model-card-icon">🖥️</div>
    <div class="model-card-value">2× H200</div>
    <div class="model-card-label"><Localized en="Runs quantized on two GPUs" ko="양자화 시 GPU 2대로 구동" /></div>
  </div>
  <div class="model-card">
    <div class="model-card-icon">🇰🇷</div>
    <div class="model-card-value">85.4 <Localized en="avg" ko="평균" /></div>
    <div class="model-card-label"><Localized en="Tops Korean benchmarks, beats DeepSeek-V4-Flash" ko="한국어 벤치마크 1위, DeepSeek-V4-Flash 상회" /></div>
  </div>
  <div class="model-card">
    <div class="model-card-icon">💻</div>
    <div class="model-card-value">92.4</div>
    <div class="model-card-label"><Localized en="LiveCodeBench — best in class among open models" ko="LiveCodeBench — 오픈 모델 중 최고" /></div>
  </div>
  <div class="model-card">
    <div class="model-card-icon">🤖</div>
    <div class="model-card-value">86.8</div>
    <div class="model-card-label"><Localized en="Ko-GDPval — near DeepSeek-V4-Pro at 1/3 the active params" ko="Ko-GDPval — 활성 파라미터 1/3로 DeepSeek-V4-Pro에 근접" /></div>
  </div>
</div>

</v-click>

---

# <Localized en="This Project's Structure" ko="이 프로젝트의 구조" />

<v-click>

### <Localized en="Review cases" ko="리뷰 케이스 (Review)" />

<p class="structure-category-desc"><Localized en="Re-verify use cases that Upstage itself has already published." ko="업스테이지에서 공개한 사용 사례를 다시 검증하는 케이스입니다." /></p>

<div class="structure-case">
  <span class="structure-case-num">Case 01</span><span class="structure-case-dash">—</span>
  <span class="structure-case-body"><Localized en="Use Solar Open 2 in the Claude Code environment" ko="Solar Open 2 모델을 클로드 코드 환경에서 사용하기" /><em class="structure-case-sub"><Localized en="Official Claude Code, Upstage-wrapped Claude Code, containerized Claude Code" ko="공식 클로드 코드, 업스테이지 래핑 클로드 코드, 컨테이너 환경의 클로드 코드" /></em></span>
</div>
<div class="structure-case">
  <span class="structure-case-num">Case 02</span><span class="structure-case-dash">—</span>
  <span class="structure-case-body"><Localized en="Use Solar Open 2 with Hermes Agent" ko="Solar Open 2 모델을 Hermes Agent에서 사용하기" /></span>
</div>

</v-click>

<v-click>

### <Localized en="Extended cases" ko="확장 케이스 (Extend)" />

<p class="structure-category-desc"><Localized en="Apply Upstage's own cases to new contexts, or explore other cases that can use the official API." ko="업스테이지 사례를 응용하거나, 공식 API를 활용할 수 있는 다른 사례를 조사하는 케이스입니다." /></p>

<div class="structure-case">
  <span class="structure-case-num">Case 03</span><span class="structure-case-dash">—</span>
  <span class="structure-case-body"><Localized en="Use Solar Open 2 with the Claude Agent SDK" ko="Solar Open 2 모델을 Claude Agent SDK로 사용하기" /><em class="structure-case-sub"><Localized en="Using the model in a code-level pipeline" ko="코드 레벨의 파이프라인으로 모델 사용하기" /></em></span>
</div>
<div class="structure-case">
  <span class="structure-case-num">Case 04</span><span class="structure-case-dash">—</span>
  <span class="structure-case-body"><Localized en="Use Solar Open 2 with LangChain Deepagents" ko="Solar Open 2 모델을 LangChain Deepagents에서 사용하기" /><em class="structure-case-sub"><Localized en="Controlling the harness at the code level" ko="코드 레벨에서 하네스 제어하기" /></em></span>
</div>
<div class="structure-case">
  <span class="structure-case-num">Case 05</span><span class="structure-case-dash">—</span>
  <span class="structure-case-body"><Localized en="Use Solar Open 2 with LangChain OpenWiki" ko="Solar Open 2 모델을 LangChain OpenWiki에서 사용하기" /><em class="structure-case-sub"><Localized en="Using a cutting-edge open source project that builds an LLM wiki" ko="LLM 위키를 구축하는 최신 오픈소스 활용" /></em></span>
</div>
<div class="structure-case">
  <span class="structure-case-num">Case 06</span><span class="structure-case-dash">—</span>
  <span class="structure-case-body"><Localized en="Use Solar Open 2 with Grok Build" ko="Solar Open 2 모델을 Grok Build에서 사용하기" /><em class="structure-case-sub"><Localized en="Using the Anthropic- and OpenAI-compatible providers" ko="Anthropic, OpenAI 호환 공급자 사용" /></em></span>
</div>
<div class="structure-case">
  <span class="structure-case-num">Case 07</span><span class="structure-case-dash">—</span>
  <span class="structure-case-body"><Localized en="Use Solar Open 2 with Hermes Agent on Kubernetes" ko="Solar Open 2 모델을 쿠버네티스의 Hermes Agent에서 사용하기" /><em class="structure-case-sub"><Localized en="Usable as an agent fleet in the cloud" ko="클라우드에서 에이전트 팀으로 사용 가능" /></em></span>
</div>

</v-click>

---

<div class="case-pill">CASE 01</div>

# Claude Code

## <Localized en="Use Solar Open 2 in the Claude Code environment" ko="Solar Open 2 모델을 클로드 코드 환경에서 사용하기" /><em class="case-h2-sub"><Localized en="Official Claude Code, Upstage-wrapped Claude Code, containerized Claude Code" ko="공식 클로드 코드, 업스테이지 래핑 클로드 코드, 컨테이너 환경의 클로드 코드" /></em>

<div class="case-card">
  <p class="case-card-desc"><Localized en="Claude Code runs on Solar Open 2 through three independent setups — the official CLI, Upstage's convenience wrapper, and a community Docker image. Custom skills and subagent calls were checked in the same environment." ko="클로드 코드는 공식 CLI, 업스테이지 커스텀 래퍼, 커뮤니티 Docker 이미지 — 세 가지 독립된 방식으로 Solar Open 2 위에서 동작합니다. 커스텀 스킬과 서브에이전트 호출도 같은 환경에서 확인했습니다." /></p>
  <div class="case-card-highlights">
    <div class="case-chip"><span class="case-chip-icon">🔓</span><span><Localized en="An open model runs inside Anthropic's own harness without modification" ko="오픈 모델이 Anthropic 하네스 안에서 수정 없이 그대로 동작합니다" /></span></div>
    <div class="case-chip"><span class="case-chip-icon">🎯</span><span><Localized en="A skill's contract is honored precisely once the skill is explicitly named" ko="스킬을 명시적으로 지목하면 규약을 정확히 따릅니다" /></span></div>
    <div class="case-chip"><span class="case-chip-icon">🧩</span><span><Localized en="A subagent call under the same model setting returns real files, not hallucinations" ko="동일한 모델 설정에서 서브에이전트 호출이 실제 파일을 반환합니다" /></span></div>
  </div>
  <div class="case-evidence">
    <div class="case-evidence-label"><Localized en="Verified in CI" ko="CI 검증 결과" /></div>
    <div class="case-evidence-row"><span class="case-evidence-method">A</span><span class="case-evidence-result"><Localized en="Identifies itself as Solar Open2 by Upstage through the official CLI" ko="공식 CLI로 Upstage의 Solar Open2임을 스스로 식별" /></span></div>
    <div class="case-evidence-row"><span class="case-evidence-method">B</span><span class="case-evidence-result"><Localized en="Reads this repo's real AGENTS.md — full harness with tool access" ko="이 리포의 실제 AGENTS.md를 읽음 — 툴 접근 포함 완전한 하네스" /></span></div>
    <div class="case-evidence-row"><span class="case-evidence-method">C</span><span class="case-evidence-result"><Localized en="Subagent listed real directory files, matching disk exactly" ko="서브에이전트가 실제 디렉터리 파일을 디스크와 정확히 일치하게 나열" /></span></div>
    <div class="case-qa">
      <div class="case-qa-line is-prompt"><span class="case-qa-tag">Ask</span><span class="case-qa-text"><Localized en="&quot;Use the git-commit-helper skill … output only the commit message.&quot;" ko="&quot;git-commit-helper 스킬을 사용해서 … 커밋 메시지만 출력해줘.&quot;" /></span></div>
      <div class="case-qa-line is-reply"><span class="case-qa-tag">Got</span><span class="case-qa-text">📄 docs(docs): add hello greeting</span></div>
    </div>
  </div>
  <div class="case-cta-row">
    <a href="https://github.com/jyje/pilot-upstage-solar-open2/actions/workflows/verify-01-solar-open2-harness.yml" target="_blank" rel="noreferrer"><img class="case-cta-badge" src="https://github.com/jyje/pilot-upstage-solar-open2/actions/workflows/verify-01-solar-open2-harness.yml/badge.svg" alt="verify-01 status" /></a>
    <a class="case-cta" href="https://github.com/jyje/pilot-upstage-solar-open2/blob/main/01-solar-open2-harness/README.md" target="_blank" rel="noreferrer"><Localized en="Read more" ko="자세히 보기" /></a>
  </div>
</div>

---

<div class="case-pill">CASE 02</div>

# Hermes Agent

## <Localized en="Use Solar Open 2 with Hermes Agent" ko="Solar Open 2 모델을 Hermes Agent에서 사용하기" />

<div class="case-card">
  <p class="case-card-desc"><Localized en="The official Hermes Agent Docker image ships a built-in Upstage provider. No protocol-conversion proxy was needed to connect it to Solar Open 2." ko="공식 Hermes Agent Docker 이미지에는 Upstage 프로바이더가 내장되어 있습니다. Solar Open 2와 연결하는 데 별도의 프로토콜 변환 프록시가 필요하지 않았습니다." /></p>
  <div class="case-card-highlights">
    <div class="case-chip"><span class="case-chip-icon">🏅</span><span><Localized en="Solar Open 2 support is bundled upstream, in the officially published image" ko="Solar Open 2 지원이 공식 배포 이미지에 기본 포함되어 있습니다" /></span></div>
    <div class="case-chip"><span class="case-chip-icon">🧾</span><span><Localized en="The full reasoning trace was captured before the model settled on its reply" ko="모델이 응답을 확정하기 전의 추론 과정 전체가 기록됩니다" /></span></div>
    <div class="case-chip"><span class="case-chip-icon">🔁</span><span><Localized en="The same round trip was confirmed both locally and in CI" ko="동일한 라운드트립을 로컬과 CI 양쪽에서 확인했습니다" /></span></div>
  </div>
  <div class="case-evidence">
    <div class="case-evidence-label"><Localized en="Verified in CI" ko="CI 검증 결과" /></div>
    <div class="case-evidence-row"><span class="case-evidence-method">A</span><span class="case-evidence-result"><Localized en="Image reports Hermes Agent v0.18.2, pinned by digest" ko="이미지가 Hermes Agent v0.18.2 보고, 다이제스트로 고정" /></span></div>
    <div class="case-evidence-row"><span class="case-evidence-method">B</span><span class="case-evidence-result"><Localized en="hermes doctor reports Upstage Solar connectivity healthy" ko="hermes doctor가 Upstage Solar 연결 정상 보고" /></span></div>
    <div class="case-evidence-row"><span class="case-evidence-method">C</span><span class="case-evidence-result"><Localized en="Round trip returns the exact string after a visible reasoning pass" ko="추론 과정이 보인 뒤 정확한 문자열 반환" /></span></div>
    <div class="case-qa">
      <div class="case-qa-line is-prompt"><span class="case-qa-tag">Ask</span><span class="case-qa-text">"Reply with exactly: hermes-ready"</span></div>
      <div class="case-qa-line is-reply"><span class="case-qa-tag">Got</span><span class="case-qa-text">hermes-ready</span></div>
    </div>
  </div>
  <div class="case-cta-row">
    <a href="https://github.com/jyje/pilot-upstage-solar-open2/actions/workflows/verify-02-hermes-agent-solar-open2.yml" target="_blank" rel="noreferrer"><img class="case-cta-badge" src="https://github.com/jyje/pilot-upstage-solar-open2/actions/workflows/verify-02-hermes-agent-solar-open2.yml/badge.svg" alt="verify-02 status" /></a>
    <a class="case-cta" href="https://github.com/jyje/pilot-upstage-solar-open2/blob/main/02-hermes-agent-solar-open2/README.md" target="_blank" rel="noreferrer"><Localized en="Read more" ko="자세히 보기" /></a>
  </div>
</div>

---

<div class="case-pill">CASE 03</div>

# Claude Agent SDK

## <Localized en="Use Solar Open 2 with the Claude Agent SDK" ko="Solar Open 2 모델을 Claude Agent SDK로 사용하기" /><em class="case-h2-sub"><Localized en="Using the model in a code-level pipeline" ko="코드 레벨의 파이프라인으로 모델 사용하기" /></em>

<div class="case-card">
  <p class="case-card-desc"><Localized en="The Python claude-agent-sdk runs a local Claude Code session entirely programmatically, on Solar Open 2. Instead of parsing stdout text, it receives typed message objects." ko="Python claude-agent-sdk는 로컬 Claude Code 세션을 Solar Open 2 위에서 완전히 프로그래밍 방식으로 실행합니다. stdout 텍스트를 파싱하는 대신 타입이 있는 메시지 객체를 받습니다." /></p>
  <div class="case-card-highlights">
    <div class="case-chip"><span class="case-chip-icon">🏗️</span><span><Localized en="Solar Open 2 sits under application code through the SDK, not just a terminal" ko="SDK를 통해 애플리케이션 코드 아래에 Solar Open 2가 놓입니다" /></span></div>
    <div class="case-chip"><span class="case-chip-icon">🔍</span><span><Localized en="Tool use is observable as a structured message, not inferred from stdout" ko="툴 사용이 stdout 추측이 아닌 구조화된 메시지로 관측됩니다" /></span></div>
    <div class="case-chip"><span class="case-chip-icon">🧠</span><span><Localized en="Session state was recalled correctly across two separate turns" ko="세션 상태가 두 개의 분리된 턴에 걸쳐 정확히 유지됩니다" /></span></div>
  </div>
  <div class="case-evidence">
    <div class="case-evidence-label"><Localized en="Verified in CI" ko="CI 검증 결과" /></div>
    <div class="case-evidence-row"><span class="case-evidence-method">A</span><span class="case-evidence-result"><Localized en="Structured types returned: AssistantMessage, ResultMessage, SystemMessage" ko="구조화된 타입 반환: AssistantMessage, ResultMessage, SystemMessage" /></span></div>
    <div class="case-evidence-row"><span class="case-evidence-method">B</span><span class="case-evidence-result"><Localized en="Session memory held across two separate turns" ko="두 개의 분리된 턴에 걸쳐 세션 메모리 유지" /></span></div>
    <div class="case-evidence-row"><span class="case-evidence-method">C</span><span class="case-evidence-result"><Localized en="saw_tool_use=True — a real ToolUseBlock in the message stream" ko="saw_tool_use=True — 메시지 스트림에 실제 ToolUseBlock" /></span></div>
    <div class="case-qa">
      <div class="case-qa-line is-prompt"><span class="case-qa-tag">Turn 1</span><span class="case-qa-text">"Remember the number 42. Reply with just OK."</span></div>
      <div class="case-qa-line is-prompt"><span class="case-qa-tag">Turn 2</span><span class="case-qa-text">"What number did I just ask you to remember?"</span></div>
      <div class="case-qa-line is-reply"><span class="case-qa-tag">Got</span><span class="case-qa-text">42</span></div>
    </div>
  </div>
  <div class="case-cta-row">
    <a href="https://github.com/jyje/pilot-upstage-solar-open2/actions/workflows/verify-03-claude-agent-sdk-local.yml" target="_blank" rel="noreferrer"><img class="case-cta-badge" src="https://github.com/jyje/pilot-upstage-solar-open2/actions/workflows/verify-03-claude-agent-sdk-local.yml/badge.svg" alt="verify-03 status" /></a>
    <a class="case-cta" href="https://github.com/jyje/pilot-upstage-solar-open2/blob/main/03-claude-agent-sdk-local/README.md" target="_blank" rel="noreferrer"><Localized en="Read more" ko="자세히 보기" /></a>
  </div>
</div>

---

<div class="case-pill">CASE 04</div>

# LangChain DeepAgents

## <Localized en="Use Solar Open 2 with LangChain Deepagents" ko="Solar Open 2 모델을 LangChain Deepagents에서 사용하기" /><em class="case-h2-sub"><Localized en="Controlling the harness at the code level" ko="코드 레벨에서 하네스 제어하기" /></em>

<div class="case-card">
  <p class="case-card-desc"><Localized en="deepagents is initialized at the code level with langchain-upstage supplying Solar Open 2 as the model. No Claude Code CLI is involved — LangChain talks to Upstage directly." ko="deepagents는 langchain-upstage가 Solar Open 2를 모델로 공급하는 코드 레벨에서 초기화됩니다. Claude Code CLI는 전혀 관여하지 않으며, LangChain이 Upstage와 직접 통신합니다." /></p>
  <div class="case-card-highlights">
    <div class="case-chip"><span class="case-chip-icon">🌉</span><span><Localized en="Solar Open 2 is reached through Upstage's OpenAI-compatible endpoint, with no Claude runtime involved" ko="Claude 런타임 없이 Upstage의 OpenAI 호환 엔드포인트로 Solar Open 2에 도달합니다" /></span></div>
    <div class="case-chip"><span class="case-chip-icon">🐍</span><span><Localized en="Python 3.13 was pinned because tokenizers has no cp314 wheel yet" ko="tokenizers의 cp314 휠이 아직 없어 Python 3.13으로 고정했습니다" /></span></div>
    <div class="case-chip"><span class="case-chip-icon">🤝</span><span><Localized en="A task was delegated to a named subagent and the result was reconciled correctly" ko="지정한 서브에이전트에 작업을 위임하고 결과를 정확히 종합했습니다" /></span></div>
  </div>
  <div class="case-evidence">
    <div class="case-evidence-label"><Localized en="Verified in CI" ko="CI 검증 결과" /></div>
    <div class="case-evidence-row"><span class="case-evidence-method">A</span><span class="case-evidence-result"><Localized en="Custom get_weather tool invoked correctly" ko="커스텀 get_weather 툴 정상 호출" /></span></div>
    <div class="case-evidence-row"><span class="case-evidence-method">B</span><span class="case-evidence-result"><Localized en="Wrote HELLO-DEEPAGENTS into the mock filesystem at /note.txt" ko="가상 파일시스템 /note.txt에 HELLO-DEEPAGENTS 기록" /></span></div>
    <div class="case-evidence-row"><span class="case-evidence-method">C</span><span class="case-evidence-result"><Localized en="Delegated arithmetic to a named math-agent subagent" ko="산술 연산을 math-agent 서브에이전트에 위임" /></span></div>
    <div class="case-qa">
      <div class="case-qa-line is-prompt"><span class="case-qa-tag">Ask</span><span class="case-qa-text">"What is the weather in Seoul?"</span></div>
      <div class="case-qa-line is-reply"><span class="case-qa-tag">Got</span><span class="case-qa-text">It's sunny in Seoul!</span></div>
    </div>
  </div>
  <div class="case-cta-row">
    <a href="https://github.com/jyje/pilot-upstage-solar-open2/actions/workflows/verify-04-langchain-upstage-deepagents.yml" target="_blank" rel="noreferrer"><img class="case-cta-badge" src="https://github.com/jyje/pilot-upstage-solar-open2/actions/workflows/verify-04-langchain-upstage-deepagents.yml/badge.svg" alt="verify-04 status" /></a>
    <a class="case-cta" href="https://github.com/jyje/pilot-upstage-solar-open2/blob/main/04-langchain-upstage-deepagents/README.md" target="_blank" rel="noreferrer"><Localized en="Read more" ko="자세히 보기" /></a>
  </div>
</div>

---

<div class="case-pill">CASE 05</div>

# LangChain OpenWiki

## <Localized en="Use Solar Open 2 with LangChain OpenWiki" ko="Solar Open 2 모델을 LangChain OpenWiki에서 사용하기" /><em class="case-h2-sub"><Localized en="Using a cutting-edge open source project that builds an LLM wiki" ko="LLM 위키를 구축하는 최신 오픈소스 활용" /></em>

<div class="case-card">
  <p class="case-card-desc"><Localized en="openwiki was run on Solar Open 2 instead of its usual Anthropic/OpenAI defaults, to document this repository's latest commit and answer questions about it." ko="openwiki를 평소의 Anthropic/OpenAI 기본값 대신 Solar Open 2로 실행해, 이 리포지토리의 최신 커밋을 문서화하고 그에 대한 질문에 답하도록 했습니다." /></p>
  <div class="case-card-highlights">
    <div class="case-chip"><span class="case-chip-icon">📖</span><span><Localized en="The model read this codebase and answered accurately about its latest commit" ko="모델이 이 코드베이스를 읽고 최신 커밋에 대해 정확히 답했습니다" /></span></div>
    <div class="case-chip"><span class="case-chip-icon">🐛</span><span><Localized en="A streaming issue that drops tool call names was found and traced during the run" ko="실행 도중 스트리밍 응답이 툴콜 이름을 누락하는 문제를 발견하고 원인을 추적했습니다" /></span></div>
    <div class="case-chip"><span class="case-chip-icon">📊</span><span><Localized en="A full documentation run can exceed the Tier-0 token-per-minute limit" ko="전체 문서화 실행은 Tier-0의 분당 토큰 한도를 초과할 수 있습니다" /></span></div>
  </div>
  <div class="case-evidence">
    <div class="case-evidence-label"><Localized en="Verified in CI — 3 live Q&amp;A rounds" ko="CI 검증 결과 — 실제 Q&amp;A 3라운드" /></div>
    <div class="case-evidence-row"><span class="case-evidence-method">Q1</span><span class="case-evidence-result"><Localized en="Explored the repo and summarized every case in a structured table" ko="리포를 탐색해 모든 케이스를 표로 정리해 요약" /></span></div>
    <div class="case-evidence-row"><span class="case-evidence-method">Q2</span><span class="case-evidence-result"><Localized en="Named the most recent commit — hash, message, intent, co-authors" ko="최신 커밋 특정 — 해시, 메시지, 의도, 공동 작성자" /></span></div>
    <div class="case-evidence-row"><span class="case-evidence-method">Q3</span><span class="case-evidence-result"><Localized en="Counted the cases and explained what each one demonstrates" ko="케이스 개수를 세고 각각이 무엇을 증명하는지 설명" /></span></div>
    <div class="case-qa">
      <div class="case-qa-line is-prompt"><span class="case-qa-tag">Ask</span><span class="case-qa-text"><Localized en="&quot;What is this repository about?&quot;" ko="&quot;이 리포지터리는 무엇에 관한 것인가?&quot;" /></span></div>
      <div class="case-qa-line is-reply"><span class="case-qa-tag">Got</span><span class="case-qa-text"><Localized en="&quot;…Upstage's Solar Open 2, a 250B-A15B MoE open-weight model with 1M-token context…&quot;" ko="&quot;…1M 토큰 컨텍스트를 가진 250B-A15B MoE 오픈 웨이트 모델 Solar Open 2…&quot;" /></span></div>
    </div>
  </div>
  <div class="case-cta-row">
    <a href="https://github.com/jyje/pilot-upstage-solar-open2/actions/workflows/verify-05-langchain-openwiki-solar-open2.yml" target="_blank" rel="noreferrer"><img class="case-cta-badge" src="https://github.com/jyje/pilot-upstage-solar-open2/actions/workflows/verify-05-langchain-openwiki-solar-open2.yml/badge.svg" alt="verify-05 status" /></a>
    <a class="case-cta" href="https://github.com/jyje/pilot-upstage-solar-open2/blob/main/05-langchain-openwiki-solar-open2/README.md" target="_blank" rel="noreferrer"><Localized en="Read more" ko="자세히 보기" /></a>
  </div>
</div>

---

<div class="case-pill">CASE 06</div>

# Grok Build

## <Localized en="Use Solar Open 2 with Grok Build" ko="Solar Open 2 모델을 Grok Build에서 사용하기" /><em class="case-h2-sub"><Localized en="Using the Anthropic- and OpenAI-compatible providers" ko="Anthropic, OpenAI 호환 공급자 사용" /></em>

<div class="case-card">
  <p class="case-card-desc"><Localized en="xAI's Grok Build reached Solar Open 2 through its own documented custom-model mechanism, with no protocol bridge in between." ko="xAI의 Grok Build는 자체 문서화된 커스텀 모델 메커니즘만으로, 별도의 프로토콜 브리지 없이 Solar Open 2에 도달했습니다." /></p>
  <div class="case-card-highlights">
    <div class="case-chip"><span class="case-chip-icon">🔌</span><span><Localized en="A separate vendor's coding agent accepted Solar Open 2 as a custom model" ko="다른 회사의 코딩 에이전트가 Solar Open 2를 커스텀 모델로 수용했습니다" /></span></div>
    <div class="case-chip"><span class="case-chip-icon">🚧</span><span><Localized en="Built-in tool calling hits the same streaming issue seen in Case 05, without a client-side fix available" ko="내장 툴 콜링에서 Case 05와 동일한 스트리밍 문제가 발생하며, 클라이언트 쪽 해결 방법은 없습니다" /></span></div>
    <div class="case-chip"><span class="case-chip-icon">🧮</span><span><Localized en="Reasoning and coding tasks completed correctly across all three checks" ko="추론과 코딩 과제 모두 세 가지 검증에서 정상적으로 완료됐습니다" /></span></div>
  </div>
  <div class="case-evidence">
    <div class="case-evidence-label"><Localized en="Verified in CI" ko="CI 검증 결과" /></div>
    <div class="case-evidence-row"><span class="case-evidence-method">A</span><span class="case-evidence-result"><Localized en="Exact-string round trip returned grok-solar-ready" ko="정확한 문자열 라운드트립이 grok-solar-ready 반환" /></span></div>
    <div class="case-evidence-row"><span class="case-evidence-method">B</span><span class="case-evidence-result"><Localized en="Derived 1275 via both the Gauss formula and the pairing method" ko="가우스 공식과 짝짓기 방법 양쪽으로 1275 도출" /></span></div>
    <div class="case-evidence-row"><span class="case-evidence-method">C</span><span class="case-evidence-result"><Localized en="Wrote a correct, working is_prime(n) with a docstring" ko="독스트링 포함 정상 동작하는 is_prime(n) 작성" /></span></div>
    <div class="case-qa">
      <div class="case-qa-line is-prompt"><span class="case-qa-tag">Ask</span><span class="case-qa-text"><Localized en="&quot;Explain step by step why the sum of the first 50 integers equals 1275.&quot;" ko="&quot;1부터 50까지의 합이 왜 1275인지 단계별로 설명해줘.&quot;" /></span></div>
      <div class="case-qa-line is-reply"><span class="case-qa-tag">Got</span><span class="case-qa-text"><Localized en="n(n+1)/2 = 50·51/2 = 1275, cross-checked by pairing" ko="n(n+1)/2 = 50·51/2 = 1275, 짝짓기로 교차 검증" /></span></div>
    </div>
  </div>
  <div class="case-cta-row">
    <a href="https://github.com/jyje/pilot-upstage-solar-open2/actions/workflows/verify-06-grok-build-solar-open2.yml" target="_blank" rel="noreferrer"><img class="case-cta-badge" src="https://github.com/jyje/pilot-upstage-solar-open2/actions/workflows/verify-06-grok-build-solar-open2.yml/badge.svg" alt="verify-06 status" /></a>
    <a class="case-cta" href="https://github.com/jyje/pilot-upstage-solar-open2/blob/main/06-grok-build-solar-open2/README.md" target="_blank" rel="noreferrer"><Localized en="Read more" ko="자세히 보기" /></a>
  </div>
</div>

---

<div class="case-pill">CASE 07</div>

# Hermes Agent Helm

## <Localized en="Use Solar Open 2 with Hermes Agent on Kubernetes" ko="Solar Open 2 모델을 쿠버네티스의 Hermes Agent에서 사용하기" /><em class="case-h2-sub"><Localized en="Usable as an agent fleet in the cloud" ko="클라우드에서 에이전트 팀으로 사용 가능" /></em>

<div class="case-card">
  <p class="case-card-desc"><Localized en="The community jyje/hermes-agent-helm chart deploys Hermes Agent onto a real, ephemeral Kubernetes cluster and completes a round trip to Solar Open 2 — both from the chart's own test Job and from the running gateway pod." ko="커뮤니티 차트 jyje/hermes-agent-helm이 실제 임시 쿠버네티스 클러스터에 Hermes Agent를 배포하고, 차트 자체의 테스트 Job과 실행 중인 게이트웨이 파드 양쪽에서 Solar Open 2와의 라운드트립을 완료합니다." /></p>
  <div class="case-card-highlights">
    <div class="case-chip"><span class="case-chip-icon">☸️</span><span><Localized en="The deployment used a published Helm chart on a real cluster, not a single docker run" ko="단발성 docker run이 아닌 공개된 Helm 차트로 실제 클러스터에 배포했습니다" /></span></div>
    <div class="case-chip"><span class="case-chip-icon">🔬</span><span><Localized en="The chart's own test Job checks the round trip as part of the deployment itself" ko="차트 자체의 테스트 Job이 배포 과정 안에서 라운드트립을 확인합니다" /></span></div>
    <div class="case-chip"><span class="case-chip-icon">💬</span><span><Localized en="Asked from inside the pod, the model described its own strengths for agentic work" ko="파드 내부에서 질문했을 때 모델이 에이전트 작업에서의 자기 강점을 설명했습니다" /></span></div>
  </div>
  <div class="case-evidence">
    <div class="case-evidence-label"><Localized en="Verified in CI" ko="CI 검증 결과" /></div>
    <div class="case-evidence-row"><span class="case-evidence-method">A</span><span class="case-evidence-result"><Localized en="Helm-test Job returned hermes-k8s-ready with a full doctor report" ko="Helm 테스트 Job이 doctor 리포트와 함께 hermes-k8s-ready 반환" /></span></div>
    <div class="case-evidence-row"><span class="case-evidence-method">B</span><span class="case-evidence-result"><Localized en="Live kubectl exec — the running pod derived 1275 via Gauss" ko="실시간 kubectl exec — 구동 중인 파드가 가우스 공식으로 1275 도출" /></span></div>
    <div class="case-evidence-row"><span class="case-evidence-method">C</span><span class="case-evidence-result"><Localized en="76 lines on its own strengths in reasoning, tool use, and coding" ko="추론·툴 사용·코딩 강점에 대해 76줄 자체 서술" /></span></div>
    <div class="case-qa">
      <div class="case-qa-line is-prompt"><span class="case-qa-tag">Ask</span><span class="case-qa-text">"Reply with exactly: hermes-k8s-ready"</span></div>
      <div class="case-qa-line is-reply"><span class="case-qa-tag">Got</span><span class="case-qa-text">hermes-k8s-ready</span></div>
    </div>
  </div>
  <div class="case-cta-row">
    <a href="https://github.com/jyje/pilot-upstage-solar-open2/actions/workflows/verify-07-hermes-agent-helm-solar-open2.yml" target="_blank" rel="noreferrer"><img class="case-cta-badge" src="https://github.com/jyje/pilot-upstage-solar-open2/actions/workflows/verify-07-hermes-agent-helm-solar-open2.yml/badge.svg" alt="verify-07 status" /></a>
    <a class="case-cta" href="https://github.com/jyje/pilot-upstage-solar-open2/blob/main/07-hermes-agent-helm-solar-open2/README.md" target="_blank" rel="noreferrer"><Localized en="Read more" ko="자세히 보기" /></a>
  </div>
</div>

---

# <Localized en="Verification & CI" ko="검증 & CI" />

## <Localized en="Every case, automatically verified on every relevant commit" ko="관련 커밋마다 모든 케이스를 자동으로 검증합니다" />

<v-click>

### <Localized en="Verification architecture" ko="검증 아키텍처" />

<span><Localized en="Each case is" ko="각 케이스는" /> **<Localized en="self-contained" ko="독립적으로 완결" />**<Localized en=":" ko="되어 있습니다:" /></span>

- <Localized en="Own" ko="자체" /> `scripts/verify.sh` — <Localized en="runs all checks for that case" ko="해당 케이스의 모든 검증을 실행" />
- <Localized en="Own" ko="자체" /> `README.md` / `README-ko.md` — <Localized en="documentation and evidence" ko="문서와 증거" />
- <Localized en="Own" ko="자체" /> `.github/workflows/verify-XX-*.yml` (<Localized en="where applicable" ko="해당하는 경우" />) — <Localized en="standalone CI" ko="독립 실행 CI" />

<span><Localized en="All cases also run together in:" ko="모든 케이스는 다음에서도 함께 실행됩니다:" /></span>

```yaml
# .github/workflows/verify-all-sequential.yml
jobs:
  c01: { steps: [./scripts/verify-case.sh 01-...] }
  c02: { steps: [./scripts/verify-case.sh 02-...] }
  # ... through c07
```

</v-click>

<v-click>

### <Localized en="Two execution modes" ko="두 가지 실행 모드" />

| <Localized en="Mode" ko="모드" /> | <Localized en="Trigger" ko="트리거" /> | <Localized en="Use case" ko="용도" /> |
|---|---|---|
| **<Localized en="Sequential (all cases)" ko="순차 실행 (전체 케이스)" />** | `main` <Localized en="push, PRs" ko="브랜치 푸시, PR" /> | <Localized en="Catch regressions across the full matrix" ko="전체 매트릭스의 회귀를 감지" /> |
| **<Localized en="Single-case manual dispatch" ko="단일 케이스 수동 실행" />** | GitHub Actions UI | <Localized en="Debug one case without waiting for the full run" ko="전체 실행을 기다리지 않고 케이스 하나만 디버깅" /> |

<span><Localized en="All workflows reuse the" ko="모든 워크플로우는" /> **<Localized en="same" ko="동일한" />** `UPSTAGE_API_KEY` <Localized en="repository secret — no per-case secrets, no per-case cost overhead." ko="저장소 시크릿을 재사용합니다 — 케이스별 시크릿도, 케이스별 비용 부담도 없습니다." /></span>

</v-click>

<v-click>

### <Localized en="Evidence: real, unedited CI transcripts" ko="증거: 가공하지 않은 실제 CI 로그" />

<span><Localized en="Every case's README links to the actual CI run — not a curated extract:" ko="모든 케이스의 README는 가공한 발췌가 아니라 실제 CI 실행 링크를 담고 있습니다:" /></span>

```
Evidence run: verify job, 2026-07-23
https://github.com/jyje/pilot-upstage-solar-open2/actions/runs/...
```

<span><Localized en="Output is shown" ko="출력은" /> **<Localized en="up to ~700 characters" ko="최대 약 700자" />** <Localized en="(10+ wrapped lines), specifically so you can judge how the model" ko="(10줄 이상)까지 보여줍니다. 응답했다는 사실만이 아니라 모델이 어떻게" /> *<Localized en="reasons" ko="추론하는지" />*<Localized en=", not just that it responded. Nothing is hand-picked or edited." ko="를 판단할 수 있게 하기 위해서입니다. 임의로 고르거나 편집한 부분은 없습니다." /></span>

</v-click>

---

# <Localized en="Verification & CI" ko="검증 & CI" />

## <Localized en="Status dashboard" ko="상태 대시보드" />

| <Localized en="Case" ko="케이스" /> | <Localized en="Status" ko="상태" /> | <Localized en="Category" ko="구분" /> | <Localized en="Workflow" ko="워크플로우" /> |
|---|---|---|---|
| 01 — Claude Code | ✅ <Localized en="Verified" ko="검증 완료" /> | Review | `verify-all-sequential` |
| 02 — Hermes Agent | ✅ <Localized en="Verified" ko="검증 완료" /> | Review | `verify-all-sequential` |
| 03 — Claude Agent SDK | ✅ <Localized en="Verified" ko="검증 완료" /> | Extend | `verify-all-sequential` |
| 04 — LangChain DeepAgents | ✅ <Localized en="Verified" ko="검증 완료" /> | Extend | `verify-all-sequential` |
| 05 — LangChain OpenWiki | ✅ <Localized en="Verified" ko="검증 완료" /> | Extend | `verify-all-sequential` |
| 06 — Grok Build | ✅ <Localized en="Verified" ko="검증 완료" /> | Extend | `verify-all-sequential` <Localized en="+ standalone" ko="+ 단독 실행" /> |
| 07 — Hermes Agent Helm | ✅ <Localized en="Verified" ko="검증 완료" /> | Extend | `verify-all-sequential` <Localized en="+ standalone" ko="+ 단독 실행" /> |

---

# <Localized en="Cross-Cutting Learnings" ko="공통 패턴" />

## <Localized en="Patterns that emerged across all 7 cases" ko="7개 케이스 전반에서 나타난 패턴" />

<v-click>

### <Localized en="🔑 Authentication: Bearer, not x-api-key" ko="🔑 인증: x-api-key가 아니라 Bearer" />

<span><Localized en="Upstage's Anthropic-compatible endpoint rejects" ko="Upstage의 Anthropic 호환 엔드포인트는" /> `x-api-key` <Localized en="with a" ko="를" /> **401**<Localized en="." ko="로 거부합니다." /></span>

<span><Localized en="Required:" ko="필요한 설정:" /> `Authorization: Bearer <key>` (<Localized en="via" ko="" />`ANTHROPIC_AUTH_TOKEN`)<Localized en="." ko="" /></span>

| <Localized en="Context" ko="맥락" /> | <Localized en="What to set" ko="설정할 값" /> |
|---|---|
| Claude Code CLI / SDK | `ANTHROPIC_AUTH_TOKEN` |
| LangChain `ChatAnthropic` | ❌ <Localized en="Don't use — it sends " ko="" />`x-api-key`<Localized en="" ko="를 전송하므로 사용 금지" /> |
| LangChain `ChatOpenAI` / `ChatUpstage` | ✅ `OPENAI_COMPATIBLE_API_KEY` (Bearer) |
| Grok Build / Hermes Agent | `UPSTAGE_API_KEY` → <Localized en="Bearer via provider" ko="공급자를 거쳐 Bearer로 변환" /> |

</v-click>

<v-click>

### <Localized en="🐛 Streaming bug: tool call function names dropped" ko="🐛 스트리밍 버그: 툴 콜 함수 이름 누락" />

<span><Localized en="Upstage's" ko="Upstage의" /> **<Localized en="streamed" ko="스트리밍" />** <Localized en="Chat Completions responses return" ko="Chat Completions 응답은 툴 콜에서" /> `function.name = ""` <Localized en="for tool calls. Non-streamed responses are correct." ko="을 반환합니다. 스트리밍을 쓰지 않으면 정상입니다." /></span>

<span><Localized en="Affected cases:" ko="영향받는 케이스:" /> **05** (openwiki — <Localized en="patched with " ko="" />`OPENWIKI_DISABLE_STREAMING`<Localized en="" ko="로 패치" />), **06** (Grok Build — <Localized en="no workaround, closed-source" ko="우회 불가, 클로즈드 소스" />).</span>

</v-click>

<v-click>

### <Localized en="🐍 Python 3.14 ecosystem gap" ko="🐍 Python 3.14 생태계 공백" />

`langchain-upstage`<Localized en=" pins " ko="는 " />`tokenizers`<Localized en=" to " ko="를 " />`^0.20.0`<Localized en=" — no release in that range ships a Python 3.14 wheel, and building from source fails with a real " ko="으로 고정하고 있습니다. 이 범위에는 Python 3.14용 wheel이 없고, 소스 빌드는 실제 " />`cargo`/PyO3<Localized en=" compile error." ko=" 컴파일 오류로 실패합니다." />

**<Localized en="All Python cases pin to 3.13" ko="모든 Python 케이스는 3.13에 고정되어 있습니다" />** <Localized en="until this lands upstream." ko="— 업스트림에서 해결될 때까지입니다." />

<span><Localized en="A fix is already open — submitted by jyje:" ko="해결 PR을 jyje가 이미 제출해 두었습니다:" /> [langchain-ai/langchain-upstage#99](https://github.com/langchain-ai/langchain-upstage/pull/99)</span>

</v-click>

---

# <Localized en="Cross-Cutting Learnings" ko="공통 패턴" />

## <Localized en="Tool invocation & API routing" ko="스킬·도구 호출과 API 경로" />

<v-click>

### <Localized en="🎯 Skill / tool invocation: explicit beats autonomous" ko="🎯 스킬·도구 호출: 자율 판단보다 명시적 지시" />

<span><Localized en="Solar Open 2 follows a skill's contract precisely" ko="Solar Open 2는 스킬을" /> **<Localized en="when explicitly told to load it" ko="명시적으로 지목했을 때" />**<Localized en=". But it doesn't reliably decide on its own that a skill applies from trigger phrases alone." ko=" 그 규약을 정확히 따릅니다. 하지만 트리거 문구만으로 스킬이 적용된다고 스스로 판단하는 것은 신뢰하기 어렵습니다." /></span>

**<Localized en="Takeaway:" ko="시사점:" />** <Localized en="name the skill explicitly in prompts." ko="프롬프트에서 스킬 이름을 직접 지목하세요." />

</v-click>

<v-click>

### <Localized en="🌐 Two wire paths to the same model" ko="🌐 같은 모델로 향하는 두 가지 경로" />

| <Localized en="Wire path" ko="경로" /> | <Localized en="Endpoint" ko="엔드포인트" /> | <Localized en="Used by" ko="사용 케이스" /> |
|---|---|---|
| **Anthropic Messages API** (<Localized en="compat layer" ko="호환 레이어" />) | `https://api.upstage.ai` | Case 01, Case 03 |
| **OpenAI Chat Completions** (<Localized en="native" ko="네이티브" />) | `https://api.upstage.ai/v1/solar` | Case 04, Case 05, Case 06, Case 07 |

<span><Localized en="Both reach Solar Open 2. The OpenAI path avoids the" ko="둘 다 Solar Open 2에 도달합니다. OpenAI 경로는" /> `ANTHROPIC_AUTH_TOKEN` <Localized en="dance." ko="설정을 거치지 않아도 됩니다." /></span>

</v-click>

---

# <Localized en="Future Directions" ko="향후 계획" />

## <Localized en="What's next for Solar Open 2 × agent harnesses" ko="Solar Open 2 × 에이전트 하네스, 다음 단계" />

<v-click>

### <Localized en="Immediate" ko="당장" />

- **<Localized en="Python 3.14 support" ko="Python 3.14 지원" />** — <Localized en="track " ko="" />`tokenizers` `cp314`<Localized en=" wheel availability; move Cases 03 and 04 back to 3.14 once it ships" ko=" wheel 제공 여부를 추적하고, 배포되면 Case 03·04를 다시 3.14로 옮깁니다" />
- **<Localized en="OpenWiki streaming fix upstream" ko="OpenWiki 스트리밍 수정 업스트림 반영" />** — `OPENWIKI_DISABLE_STREAMING`<Localized en=" is currently in a " ko="는 현재 " />`jyje/openwiki`<Localized en=" fork; getting it merged into " ko=" 포크에 있습니다. 이를 " />`langchain-ai/openwiki`<Localized en=" would unblock the public npm release" ko="에 병합해야 공식 npm 릴리스가 가능합니다" />
- **<Localized en="Upstage streaming bug resolution" ko="Upstage 스트리밍 버그 해결" />** — <Localized en="the " ko="" />`function.name = ""`<Localized en=" bug affects Cases 05 and 06; getting it fixed upstream unblocks tool-calling for the entire ecosystem" ko=" 버그는 Case 05·06에 영향을 줍니다. 업스트림에서 고쳐야 생태계 전체의 툴 콜링이 풀립니다" />

</v-click>

<v-click>

### <Localized en="Near-term" ko="단기" />

- **Case 08+** — <Localized en="new harness integrations (more Kubernetes operators, more LangChain ecosystem tools, more IDE integrations)" ko="새로운 하네스 통합 (쿠버네티스 오퍼레이터, LangChain 생태계 도구, IDE 통합 확대)" />
- **<Localized en="Telegram/Discord for Case 07" ko="Case 07의 텔레그램·디스코드 연동" />** — <Localized en="messenger integration on top of the verified Helm deployment (currently documented but not gated)" ko="검증된 Helm 배포 위에 메신저를 연동합니다 (현재는 문서화만 되어 있고 CI 게이트는 없음)" />
- **<Localized en="Rate-limit-aware verification" ko="레이트 리밋을 고려한 검증" />** — <Localized en="Case 05's Finding 3 (50K tokens/min ceiling) could be addressed with batched/parallel verification strategies" ko="Case 05의 Finding 3(분당 5만 토큰 한도)은 배치·병렬 검증 전략으로 완화할 수 있습니다" />

</v-click>

<v-click>

### <Localized en="Ecosystem growth" ko="생태계 확장" />

- **<Localized en="More agent frameworks" ko="더 많은 에이전트 프레임워크" />** — AutoGen, CrewAI, LlamaIndex, SWE-agent
- **<Localized en="More deployment targets" ko="더 많은 배포 대상" />** — EKS, GKE, <Localized en="cloud-managed Kubernetes" ko="클라우드 관리형 쿠버네티스" />
- **<Localized en="More model variants" ko="더 많은 모델 변형" />** — `solar-pro3`, <Localized en="future Solar Open releases" ko="향후 Solar Open 릴리스" />
- **<Localized en="Community contributions" ko="커뮤니티 기여" />** — <Localized en="every case is designed to be independently reproducible, extendable, and verifiable by anyone with an Upstage API key" ko="모든 케이스는 Upstage API 키만 있으면 누구나 독립적으로 재현·확장·검증할 수 있도록 설계되어 있습니다" />

</v-click>

<v-click>

### <Localized en="The bigger picture" ko="더 큰 그림" />

<span><Localized en="This pilot started with a single question:" ko="이 파일럿은 하나의 질문에서 시작했습니다:" /></span>

> *<Localized en="Can Upstage's Solar Open 2 model run through real, production-grade agent harnesses — not just a raw API call?" ko="Upstage의 Solar Open 2 모델이 API 호출 하나가 아니라, 실제 프로덕션급 에이전트 하네스를 통해서도 동작할 수 있을까?" />*

<span><Localized en="Seven cases later, the answer is" ko="일곱 개의 케이스를 거친 지금, 답은" /> **<Localized en="yes" ko="그렇다" />** — <Localized en="across Claude Code, Hermes Agent, Claude Agent SDK, LangChain, OpenWiki, Grok Build, and Kubernetes/Helm." ko="Claude Code, Hermes Agent, Claude Agent SDK, LangChain, OpenWiki, Grok Build, Kubernetes/Helm 전반에 걸쳐서입니다." /> <Localized en="The remaining work is scaling that answer to more harnesses, more models, and more operators." ko="남은 과제는 이 결과를 더 많은 하네스, 더 많은 모델, 더 많은 오퍼레이터로 확장하는 것입니다." /></span>

</v-click>

---

# <Localized en="Appendix" ko="부록" />

## <Localized en="Quick reference for running any case" ko="케이스 실행 빠른 참고" />

<v-click>

### <Localized en="Prerequisites (per case)" ko="사전 준비물 (케이스별)" />

| <Localized en="Tool" ko="도구" /> | <Localized en="Used by" ko="사용 케이스" /> |
|---|---|
| `Node.js 18+` | Case 01, Case 03 |
| `Docker` | Case 01C, Case 02 |
| `Python 3.13` + `uv` | Case 03, Case 04 |
| `kind` + `kubectl` + `helm` | Case 07 |
| `grok` CLI | Case 06 |

<span><Localized en="All cases require:" ko="모든 케이스에 공통으로 필요합니다:" /> **`UPSTAGE_API_KEY`** — <Localized en="get one at" ko="발급:" /> <https://console.upstage.ai/api-keys></span>

</v-click>

---

# <Localized en="Appendix" ko="부록" />

## <Localized en="Rate limits and API endpoints" ko="레이트 리밋과 API 엔드포인트" />

### <Localized en="Rate limits (Tier 0)" ko="레이트 리밋 (Tier 0)" />

| <Localized en="Limit" ko="한도" /> | <Localized en="Value" ko="값" /> |
|---|---|
| <Localized en="Requests/minute" ko="분당 요청 수" /> | 100 |
| <Localized en="Tokens/minute" ko="분당 토큰 수" /> | 50,000 |

<span><Localized en="Rolling window. Case 05's full doc generation can exceed the token limit in a single run — see Finding 3 in that case's README." ko="롤링 윈도우 기준입니다. Case 05의 전체 문서 생성은 한 번의 실행에서 이 토큰 한도를 초과할 수 있습니다 — 해당 케이스 README의 Finding 3를 참고하세요." /></span>

### <Localized en="API endpoints reference" ko="API 엔드포인트 참고" />

| <Localized en="Protocol" ko="프로토콜" /> | <Localized en="Endpoint" ko="엔드포인트" /> | <Localized en="Used by" ko="사용 케이스" /> |
|---|---|---|
| Anthropic Messages API (<Localized en="compat" ko="호환" />) | `https://api.upstage.ai` | Case 01, Case 03 |
| OpenAI Chat Completions (<Localized en="native" ko="네이티브" />) | `https://api.upstage.ai/v1/solar` | Case 04, Case 05, Case 06, Case 07 |

**<Localized en="Auth:" ko="인증:" />** `Authorization: Bearer <key>` (`ANTHROPIC_AUTH_TOKEN`) — **<Localized en="not" ko="아님" />** `x-api-key`.

---

# <Localized en="Appendix" ko="부록" />

## <Localized en="Reproduce any case locally" ko="로컬에서 케이스 재현하기" />

<v-click>

### <Localized en="Steps" ko="절차" />

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

</v-click>

<v-click>

### <Localized en="Glossary" ko="용어 정리" />

| <Localized en="Term" ko="용어" /> | <Localized en="Meaning" ko="의미" /> |
|---|---|
| **Solar Open 2** | Upstage<Localized en="'s 250B-A15B MoE open-weight model, 1M context" ko="의 250B-A15B MoE 오픈 웨이트 모델, 1M 컨텍스트" /> |
| **`ANTHROPIC_AUTH_TOKEN`** | <Localized en="Bearer token for Upstage's Anthropic-compatible endpoint" ko="Upstage의 Anthropic 호환 엔드포인트용 Bearer 토큰" /> |
| **`OPENWIKI_DISABLE_STREAMING`** | <Localized en="Opt-in flag to disable streaming (workaround for tool-calling bug)" ko="스트리밍을 비활성화하는 옵션 플래그 (툴 콜링 버그 우회용)" /> |
| **`api_backend`** | <Localized en="Grok Build config key choosing wire protocol" ko="와이어 프로토콜을 선택하는 Grok Build 설정 키" /> (`chat_completions`, `responses`, `messages`) |
| **`CLAUDE_CODE_SUBAGENT_MODEL`** | <Localized en="Env var ensuring subagent/Task-tool calls stay on Solar Open 2" ko="서브에이전트·Task 툴 호출이 Solar Open 2를 계속 쓰도록 보장하는 환경변수" /> |

</v-click>
