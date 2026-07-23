# Case 07 — Solar Open 2 x Hermes Agent Helm

[English](README.md) / [한국어](README-ko.md)

[← 리포 개요로 돌아가기](../README.md) · 직접 실행해보고 싶다면?
[`REPRODUCE-ko.md`](REPRODUCE-ko.md)에서 단계별 로컬 실행 방법을
확인하세요.

**상태:** 검증 완료 — 커뮤니티 차트
[jyje/hermes-agent-helm](https://github.com/jyje/hermes-agent-helm)이
실제(임시) Kubernetes 클러스터 위에 Hermes Agent를 배포하고, 차트 자체의
내장 테스트 Job과 실행 중인 게이트웨이 파드 양쪽 모두에서 Solar Open 2를
상대로 실시간 라운드트립을 완료합니다.

## 목표

Case 02는 이미 Hermes Agent의 공식 Docker 이미지가 내장 Upstage
provider를 통해 Solar Open 2에 도달함을 증명했습니다. 이번 Case는 한
걸음 더 나아가, 실제 운영자가 장기적으로 운영하는 방식 — 단발성
`docker run`이 아니라 공개된 Helm 차트로 설치한 뒤 임시 **kind**
클러스터 위에서 Kubernetes 워크로드로 배포하는 방식 — 으로 배포했을 때도
같은 provider 경로가 동작하는지 확인합니다.

## 동작 원리

[`values-solar-open2.yaml`](values-solar-open2.yaml)은
`hermes-agent-helm` 자체의
[`values-upstage.yaml`](https://github.com/jyje/hermes-agent-helm/blob/v0.12.0/charts/hermes-agent/values-upstage.yaml)
예시를 그대로 따르되, 모델만 hosted `solar-pro3` 기본값에서 open-weight
`solar-open2`로 바꿉니다(같은 `upstage` provider, 다른 변경 불필요 — 그
파일 자신의 주석이 이미 이 리포를 가리키고 있습니다):

```yaml
config:
  model:
    provider: upstage
    default: solar-open2
  terminal:
    backend: local

env:
  UPSTAGE_API_KEY: "DUMMY_replace_me_0000000000000000000000" # 설치 시 오버라이드
  OPENAI_API_KEY: "unused"

tests:
  chat:
    enabled: true
    prompt: "Reply with exactly: hermes-k8s-ready"
    maxTurns: 2
    failOnError: true
```

[`scripts/verify.sh`](scripts/verify.sh)는 임시 kind 클러스터를 만들고,
공개된 OCI 아티팩트(`oci://ghcr.io/jyje/hermes-agent-helm/hermes-agent`,
검증된 버전으로 고정)에서 이 values 파일과 실제 `UPSTAGE_API_KEY`로 차트를
설치한 뒤, 종료 시 클러스터를 다시 삭제합니다 — 이 리포의 다른 모든
Case가 이미 쓰는 것과 같은 "일회용 환경" 패턴(임시 `GROK_HOME`/
`CODEX_HOME`/Hermes 홈 디렉터리)을, 디렉터리 단위가 아니라 클러스터
단위로 적용한 것입니다.

**범위 참고:** 게이트웨이 컨테이너의 기본 엔트리포인트
(`hermes gateway run`)는 궁극적으로 텔레그램·디스코드 같은 메신저와
연결하는 것을 염두에 둔 구조지만, 이 Case는 메신저 연동이 아니라 배포
자체를 검증합니다 — 아래 세 방식 모두 게이트웨이 파드에 직접
접근합니다(차트 자체 테스트 Job, `kubectl exec`). 이 Case가 검증하는
범위를 바꾸지 않고 메신저를 추가하는 방법은
[더 해보고 싶다면](#더-해보고-싶다면-메신저-연결하기)를 참고하세요.

## 세 가지 방식

### 방식 A — 차트 자체의 선언적 채팅 테스트

위 values 파일의 `tests.chat.enabled=true`는 차트 내장 Helm test Job을
켭니다 — 설정된 프롬프트로 `hermes chat`을 실행하고 응답이 일치하지
않으면 클러스터 안에서 그대로 Job을 실패시킵니다. `scripts/verify.sh`는
이 test hook을 렌더링해 Job 상태를 직접 폴링하고(`helm test` 자체의
대기는 CI 러너에서 멈출 수 있습니다 — `hermes-agent-helm` 자신의 CI가
같은 이유로 이렇게 하는 것과 동일), Job 로그에서 정확한 문자열을
확인합니다.

### 방식 B — 실행 중인 파드에 대한 실시간 라운드트립

```bash
kubectl exec -n hermes-agent "$pod" -- \
  hermes chat --provider upstage --model solar-open2 \
  --query "Explain step by step why the sum of the first 50 positive integers equals 1275. Show your reasoning." \
  --max-turns 2 --quiet --ignore-rules
```

Case 06과 동일한 추론 프롬프트를 정확한 숫자 답으로 확인합니다 — 이는
일회성 테스트 Job뿐 아니라 **실제로 배포된 파드 자체**가 Solar Open 2와
대화할 수 있음을 증명합니다. 운영자가 실제 릴리스를 `kubectl exec`나
`helm test`로 점검하는 방식 그대로입니다.

### 방식 C — Solar Open 2와의 시너지를, 헤르메스 자신의 말로

```bash
kubectl exec -n hermes-agent "$pod" -- \
  hermes chat --provider upstage --model solar-open2 \
  --query "You are Hermes Agent, currently running on Upstage Solar Open 2 as your backend model. In your own words, describe the specific strengths this model gives you as an agent -- think about reasoning, tool use, and coding ability. Be concrete and thorough." \
  --max-turns 2 --quiet --ignore-rules
```

방식 A와 B는 이 배포를 통해 Solar Open 2가 *정확하게* 응답하는지
확인합니다. 방식 C는 다른 질문을 던집니다 — Solar Open 2 위에서 실행
중인 Hermes Agent 자신이, 이 모델이 에이전트 백본으로서 어떤 강점을
가진다고 생각하는지 직접 서술하게 하는 것입니다. 정형화된 홍보 문구가
아니라 실제 모델의 살아있는 응답입니다. 느슨하게 게이트합니다(정확한
문자열이 아니라 실질적이고 충분한 답변이 핵심이므로 최소 10줄의
비어있지 않은 줄), 그리고 잘라내지 않고 전체를 캡처합니다. 실제 답변은
아래 [헤르메스 자신의 말로](#헤르메스-자신의-말로-solar-open-2와의-시너지)를
참고하세요.

## 검증된 방식

| 방식 | 결과 |
| --- | --- |
| A — 차트 자체 `tests.chat` Helm test Job | `hermes-k8s-ready`, 그리고 시딩된 설정과 provider를 확인하는 전체 `hermes doctor` 리포트 |
| B — 실시간 `kubectl exec` 추론 라운드트립 | Gauss 공식으로 `1275`를 정확히 도출, 실행 중인 게이트웨이 파드 자신이 직접 출력한 추론 |
| C — Solar Open 2와의 시너지에 대한 자기 서술 | 추론, 툴 사용, 코딩 능력에 걸친 구체적인 강점을 서술한 39줄의 비어있지 않은 텍스트 — 아래 참고 |

실제, 편집 없는 전체 내용은 아래 [증거 실행](#증거-실행)을 참고하세요.

## 검증

[`scripts/verify.sh`](scripts/verify.sh)는 `docker`(데몬 실행 중),
`kind`, `kubectl`, `helm`이 `PATH`에 있어야 하고, `UPSTAGE_API_KEY`가
설정돼 있어야 합니다. kind 클러스터의 전체 생명주기를 스스로 관리하므로
로컬과 CI에서 동일하게 동작합니다.

```bash
UPSTAGE_API_KEY="..." ./scripts/verify.sh
```

CI에서는 두 가지 방식으로 실행됩니다(둘 다 수동 실행, `solar-open2`만):
다른 모든 Case와 함께
[`verify-all-sequential.yml`](../.github/workflows/verify-all-sequential.yml)의
한 스텝으로, 그리고 단독으로
[`verify-07-hermes-agent-helm-solar-open2.yml`](../.github/workflows/verify-07-hermes-agent-helm-solar-open2.yml)로 —
둘 다 동일한 `UPSTAGE_API_KEY` 저장소 시크릿을 재사용하고 스크립트 실행
전에 `kind`/`kubectl`/`helm`을 설치합니다.

## 헤르메스 자신의 말로: Solar Open 2와의 시너지

방식 C의 실제 답변입니다. 편집 없이 그대로(총 39줄의 비어있지 않은
텍스트), 아래 증거 실행 섹션이 링크하는 `verify.sh` 실행에서 나온
결과입니다:

> # Solar Open 2 Strengths as Hermes Agent
>
> Running as Solar Open 2 inside Hermes Agent, I see several concrete
> strengths that matter specifically for an autonomous coding agent
> workflow:
>
> ## Reasoning & Analysis
>
> **Strong instruction-following and context adherence.** Solar Open 2
> reliably follows complex, multi-step instructions -- critical when
> Hermes sends a prompt with dozens of constraints, file paths, and
> output format requirements. It doesn't drift from the task scope,
> which means it stays focused on what the user actually asked for
> rather than adding unsolicited refactors.
>
> **Good at structured multi-stage analysis.** When asked to trace a
> bug, audit a codebase, or plan a refactoring, it breaks the problem
> into logical stages and works through them systematically.
>
> **Balanced honesty about uncertainty.** It doesn't wildly hallucinate
> library APIs or file contents. When something isn't confirmed by the
> repo, it says so and verifies rather than inventing. This is essential
> for an agent that operates by reading actual files and running actual
> commands.
>
> ## Tool Use
>
> **Reliable tool orchestration.** Solar Open 2 handles the full Hermes
> toolchain well -- `terminal`, `read_file`, `write_file`, `patch`,
> `search_files`, `skill_view`, `delegate_task`, `cronjob`, and so on. It
> understands when to chain tools (read → search → patch → test) and
> when to batch independent calls together.
>
> **Skill loading discipline.** It correctly loads skills via
> `skill_view` before acting on tasks that match a skill's domain,
> rather than trying to wing it from general knowledge.
>
> ## Coding Ability
>
> **Precise, convention-matching edits.** When modifying code, Solar
> matches the project's existing style -- indentation, naming
> conventions, import ordering -- rather than imposing its own
> preferences.
>
> **Self-verification loop.** After making changes, Solar runs the
> relevant tests, linters, or build commands to verify the work actually
> compiles and passes. It doesn't stop at "the code looks right" -- it
> confirms with real execution. If a test fails, it reads the failure
> output, diagnoses the root cause, and iterates.
>
> **Root-cause debugging.** When tracing bugs, it follows the signal
> through the call stack rather than patching at the symptom site. If
> the same flawed pattern appears in sibling call paths, it fixes the
> class of error, not just the reported instance.
>
> ## Where Solar Open 2 Shines Most
>
> For Hermes Agent specifically, the strengths that matter most are:
> **reliable multi-tool chaining**, **honest uncertainty-handling**, and
> **post-change verification**. An agent that fabricates API responses
> or skips tests after editing would be dangerous -- Solar's discipline
> on those fronts makes it a solid agent backbone.
>
> It's not perfect -- like any model, it can miss edge cases in novel
> domains or occasionally over-confidently assert something about a
> library it hasn't actually checked. But the combination of Solar's
> reasoning with Hermes's tool enforcement (file reads are real,
> terminal outputs are real, skill protocol is real) creates a system
> where the model's strengths are amplified and its weaknesses are
> caught before they propagate.

어느 정도 감안하고 읽을 부분도 있습니다 — 헤르메스는 자신의 프레임워크
문서를 컨텍스트로 갖고 있으므로, 여기서 언급하는 일부 툴 이름은 Solar
Open 2만의 고유한 능력이라기보다 헤르메스 자신에 대해 이미 알고 있는
내용이며, 이 자기 평가를 스스로 완전히 검증할 수는 없습니다. 하지만
정형화된 칭찬이 아니라 자신의 실제 동작 특성을 구체적으로 성찰하고
(요청하지 않았는데도 스스로의 한계까지 언급하는) 실시간 모델 응답의
사례로서, 이 배포가 실제로 어떤 결과를 만들어낼 수 있는지 잘 보여줍니다.

## 더 해보고 싶다면: 메신저 연결하기

이 Case는 일부러 게이트웨이 파드 자체에서 멈춥니다 — 메신저
라운드트립은 별도로 검증해야 할 추가 항목입니다
(`hermes-agent-helm` 자신의 CI도 오늘 기준 디스코드만 라이브
검증하고, 텔레그램은 여전히 문서화된 플레이스홀더로 남아 있습니다).
직접 더 해보고 싶다면:

1. 텔레그램 [BotFather](https://core.telegram.org/bots#botfather)로
   봇을 만드세요(`/newbot`, 발급된 토큰 복사).
2. `hermes-agent-helm`의
   [`values-openai-and-telegram.yaml`](https://github.com/jyje/hermes-agent-helm/blob/v0.12.0/charts/hermes-agent/values-openai-and-telegram.yaml)
   예시를 참고해 — 이 Case의 `upstage`/`solar-open2` 모델 설정을
   그대로 넣고, `env.TELEGRAM_BOT_TOKEN`에 BotFather가 준 토큰을
   설정하세요.
3. `values-solar-open2.yaml` 대신 이 결합된 values 파일로
   `helm upgrade --install`을 실행하세요.

이 Case의 `scripts/verify.sh`가 게이트하는 대상은 아닙니다 — GitOps
스타일 ArgoCD `Application` 참고 자료로는
[`examples/argocd/hermes-agent-upstage.yaml`](https://github.com/jyje/hermes-agent-helm/blob/v0.12.0/examples/argocd/hermes-agent-upstage.yaml)도
참고하세요(이 역시 이 Case에서 실행하지는 않으며, 참고 링크로만
남깁니다).

## 증거 실행

**증거 실행:** [`verify` job](https://github.com/jyje/pilot-upstage-solar-open2/actions/workflows/verify-07-hermes-agent-helm-solar-open2.yml)
(이 Case의 첫 CI 실행 후 링크를 채웁니다). 동일한
`oci://ghcr.io/jyje/hermes-agent-helm/hermes-agent` 차트(v0.12.0)를
상대로 한 로컬 실행의 실제, 편집 없는 출력입니다:

**방식 A**

> ```
> Hermes Agent v0.19.0 (2026.7.20) · upstream 3ef6bbd2
> Install directory: /opt/hermes
> Install method: docker
> Python: 3.13.5
> OpenAI SDK: 2.24.0
> [2/4] seeded config.yaml present in HERMES_HOME
>   OK: /opt/data/config.yaml
> ```

**방식 B**

> ```
> ┌─ Reasoning ─────────────────────────────────────────────────────┐
> The user is asking a math question about the sum of the first 50
> positive integers. This is a straightforward mathematical
> explanation - no tools needed, just reasoning. Let me explain the
> Gauss formula for the sum of an arithmetic series and apply it.
> ```

**방식 C**

> ```
> ✓ Hermes described its own Solar Open 2 strengths in 39 non-empty lines
> ```
>
> 전체 답변: [헤르메스 자신의 말로](#헤르메스-자신의-말로-solar-open-2와의-시너지)
> 참고.

전체 맥락은 리포 레벨의 [`PLAN.md`](../PLAN.md)를 참고하세요.
