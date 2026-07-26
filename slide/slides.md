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
