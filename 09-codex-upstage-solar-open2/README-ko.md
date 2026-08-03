# Case 09 — Solar Open 2 x Codex (LiteLLM 브릿지)

[English](README.md) / [한국어](README-ko.md)

[← 리포 개요로 돌아가기](../README.md)

**상태:** 검증 완료 — 2026-08-03에 번호 없는 draft에서 정식 승격했습니다.
LiteLLM Responses API 브릿지를 통해 **solar-open2**와 **solar-pro4** 둘
다 로컬에서 재검증: raw `/v1/responses` 요청과 전체 `codex exec` 왕복이
두 모델 모두 통과했습니다(`../logs/local-verification/2026-08-03/case-09-codex-*.log`
참고). Codex는 여전히 커스텀 OpenAI 호환 엔드포인트를 직접 가리키는 공식
지원 방법이 없어서, 이 Case는 브릿지 자체를 검증하는 용도입니다. 재검증
중 발견한 한 가지: 파일 읽기 도구를 유발하는 프롬프트는 Codex CLI
`0.146.0`의 자체 도구 라우터 버그(`error=unsupported call: read_file`,
이 Case가 처음 검증했던 `0.144.5`에서는 없던 문제)에 걸립니다 — Solar
Open 2/Pro4나 프록시와는 무관합니다. 도구 호출이 없는 프롬프트는 두
모델 모두에서 전체 에이전틱 루프를 깨끗하게 완료합니다.

## 목표

OpenAI Codex CLI가 Upstage의 **Solar Open 2** 모델로 에이전트 코딩 작업을
수행할 수 있는지 확인하고, 프로토콜 브리지의 동작이 종단 간 검증된 경우에만
작고 재현 가능한 설정을 공개합니다.

## 공식 호환성 조사 결과

**직접 설정: 불가.** 현재 필요한 프로토콜이 일치하지 않습니다.

| 제품 | 이 Case와 관련된 공식 인터페이스 |
| --- | --- |
| Upstage | API 키 콘솔의 예제는 `base_url="https://api.upstage.ai/v1"` 및 `client.chat.completions.create(...)`를 사용합니다. |
| Codex | custom model provider 레퍼런스는 `wire_api = "responses"`만 지원하며 이것이 기본값이라고 명시합니다. |

따라서 아래처럼 보이는 설정은 지원되는 직접 연결 방법이 아닙니다.

```toml
# 의도적으로 동작하지 않는 직접 설정 예시입니다.
[model_providers.upstage]
base_url = "https://api.upstage.ai/v1"
env_key = "UPSTAGE_API_KEY"
```

Codex는 Responses API 요청을 보냅니다. 반면 Upstage가 공개한 Solar API
사용법은 Chat Completions를 사용합니다. Base URL만 바꾼다고 두 wire
protocol이 변환되지는 않으며, Upstage 문서는 이 간극을 메우는 직접 Codex
또는 Responses API 설정을 제공하지 않습니다.

근거: [Upstage API 키 콘솔 — Chat 예제](https://console.upstage.ai/api-keys?api=chat),
[Codex custom-provider 설정](https://developers.openai.com/codex/config-advanced),
[Codex 설정 레퍼런스](https://developers.openai.com/codex/config-reference).

현재 Upstage 콘솔 예제의 모델명은 `solar-pro3`이고, 이 리포의 기존
Case들은 `solar-open2`를 사용합니다. 이 실험의 실제 검증에서는 계정에
활성화된 모델 ID를 확인해 기록해야 하며, 프로토콜 브리지가 된다는 이유만으로
과거 모델 ID가 계속 제공된다고 가정하면 안 됩니다.

## 계획된 브리지

검증할 수 있는 경로는 다음과 같습니다.

```text
Codex (Responses API) → 프로토콜 변환 프록시 → Upstage (Chat Completions API) → Solar Open 2
```

LiteLLM이 이 브리지를 제공합니다. 이 Case가 사용하는
`openai/chat_completions/<model>` 모델 prefix(또는 같은 기능의
`use_chat_completions_api`)는 custom OpenAI-compatible upstream에 대해
`/responses → /chat/completions` 변환을 강제합니다.

다만 Upstage를 향한 전체 tool·streaming 경로는 실제 실행으로 검증해야
합니다.

브리지가 준비되면 Codex는 `openai` 예약 provider를 덮어쓰는 대신, 아래
예제의 `solar_proxy`처럼 *직접 이름을 정한 별도의 custom provider*
항목을 새로 추가해야 합니다.

```toml
model = "solar-open2"
model_provider = "solar_proxy"

[model_providers.solar_proxy]
name = "LiteLLM을 통한 Solar Open 2"
base_url = "http://127.0.0.1:PORT/v1"
env_key = "LITELLM_MASTER_KEY"
wire_api = "responses"
```

`PORT`는 Upstage endpoint가 아니라 로컬 프록시가 수신하는 포트의 자리표시자입니다.
Codex는 LiteLLM 인증용 `LITELLM_MASTER_KEY`만 사용하고,
`UPSTAGE_API_KEY`는 LiteLLM만 받습니다. 두 키 모두 환경 변수 또는 secret store에만
두고 `config.toml`에는 절대 기록하지 않습니다.

실행 가능한 템플릿은 [`config/litellm-config.yaml`](config/litellm-config.yaml)과
[`config/codex.config.toml.template`](config/codex.config.toml.template)입니다. Upstage API base URL
`https://api.upstage.ai/v1/solar` 및 LiteLLM 모델 prefix
`openai/chat_completions/solar-open2`를 사용합니다.

## Docker 프록시 실행

선택한 배포 방식은 Docker입니다. 한 터미널에서 로컬 전용 프록시를 실행합니다.

```bash
export UPSTAGE_API_KEY="..."
./scripts/run-proxy-docker.sh
```

공식 LiteLLM 이미지를 쓰며 `127.0.0.1:4000`에만 바인딩하고, 중지하면
컨테이너도 제거됩니다. 다른 터미널에서 `config/codex.config.toml.template`을
`$CODEX_HOME/config.toml`로 복사하고, 기본값을 바꿨다면 같은
`LITELLM_MASTER_KEY`를 설정한 뒤 `codex`를 실행합니다.

## 검증 기준

이 Case는 다음을 입증한 뒤 검증 완료로 승격했습니다.

1. ✅ `model = "solar-open2"`(2026-08-03부터는 `solar-pro4`도)를 사용하는 비대화형 `codex exec` 응답.
2. ⚠️ 알려진 로컬 파일을 읽어 그 내용을 보고하는 filesystem tool turn — 2026-08-03 기준 Codex CLI `0.146.0`의 자체 도구 라우터 버그(`error=unsupported call: read_file`)로 막혔습니다. Solar Open 2/Pro4나 브릿지 문제가 아닙니다. 이후 Codex 릴리스에서 재시도할 가치가 있습니다.
3. ✅ 스트리밍 출력 및 적어도 한 번의 tool-call/tool-result cycle을 프록시가 정확히 처리함(raw 브릿지 체크의 무해한 `noop` function call).
4. ✅ 리포의 `UPSTAGE_API_KEY` secret을 재사용하는 `scripts/verify.sh`와 GitHub Actions workflow.

`UPSTAGE_API_KEY`를 설정한 뒤 실제 게이트를 실행합니다.

```bash
./scripts/verify.sh
```

LiteLLM을 기동하고 raw `/v1/responses` 브리지 요청을 먼저 확인한 뒤, 격리된
`CODEX_HOME`에서 `codex exec`를 실행합니다. 대응하는 GitHub Actions workflow는
리포의 `UPSTAGE_API_KEY` secret을 재사용합니다.

## 검증 결과

2026-07-20에 Codex CLI `0.144.5`, 공식 LiteLLM Docker 이미지 및
`solar-open2`로 이 구성을 처음 검증했습니다. bridged Responses 요청은
`bridge-ready`를, 비어 있는 read-only 임시 디렉터리의 Codex는
`codex-ready`를 반환했습니다.

LiteLLM 브리지의 한 가지 제약도 확인했습니다. tool이 없는 Responses 요청을
변환할 때 `tools: []`를 붙이고, Upstage는 이를 빈 배열로 거부합니다. 따라서
검증 probe에는 무해한 `noop` function definition을 포함합니다.

**2026-08-03에 Codex CLI `0.146.0`으로, `solar-open2`와 `solar-pro4`
둘 다 로컬에서 재검증**했습니다 — 이 리포 `docker/` litellm-proxy
이미지를 재사용해 4001 포트에 두 번째 인스턴스를 띄우고
`openai/chat_completions/<model>` prefix로 두 모델 다 설정했습니다(전체
로그: `../logs/local-verification/2026-08-03/case-09-codex-solar-open2.log`,
`case-09-codex-solar-pro4.log`):

| 체크 | solar-open2 | solar-pro4 |
| --- | --- | --- |
| raw `/v1/responses` 브릿지 요청 → `bridge-ready` | ✅ | ✅ |
| `codex exec` 전체 왕복(도구 없는 프롬프트) → `codex-ready` | ✅ | ✅ |
| 파일 읽기 tool call을 동반한 `codex exec` | ❌ (Codex 0.146.0 도구 라우터 버그, 위 상태 참고) | 동일 바이너리라 재시도 안 함 |

특히 solar-pro4는 Upstage 자체 Anthropic 호환 엔드포인트에 모델 매핑이
없어서(Case 01/03의 발견 참고), 이 Responses API 브릿지는 Codex에게
[`docker/`](../docker/)의 Anthropic Messages 브릿지가 Claude Code에게
해주는 것과 같은 역할을 합니다.

전체 실험 계획은 리포 레벨의 [`PLAN.md`](../PLAN.md)를 참고하세요.
