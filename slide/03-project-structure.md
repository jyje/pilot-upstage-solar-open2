<!-- slidev:enable-auto-animate -->
# 프로젝트 구조

## 7개 독립 케이스, 1개 리포

<v-click>

### 리뷰 케이스 (Review)

- **Case 01** — Claude Code harness를 Solar Open 2로 라우팅
- **Case 02** — Hermes Agent 공식 제공자로 실행

</v-click>

<v-click>

### 익스텐드 케이스 (Extend)

- **Case 03** — Claude Agent SDK로 Claude Code 제어
- **Case 04** — LangChain Deepagents + langchain-upstage
- **Case 05** — OpenWiki로 리포 자기 문서화
- **Case 06** — Grok Build CLI를 커스텀 모델로 연결
- **Case 07** — Hermes Agent Helm 차트, kind 클러스터 배포

</v-click>

<!--
Review 케이스는 기존 공식 하네스 경로에서 Solar Open 2가 올바르게 동작하는지 검증합니다.
Extend 케이스는 더 넓은 생태계(LangChain, 커스텀 에이전트 코드)에 Solar Open 2를 연결합니다.

각 케이스는 독립적으로 읽고, 실행하고, 발표할 수 있으며
프로젝트 루트의 README, AGENTS.md, PLAN.md, CONTRIBUTING.md가 구조를 설명합니다.
-->
