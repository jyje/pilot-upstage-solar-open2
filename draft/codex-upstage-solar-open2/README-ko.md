# Case 05 — Upstage Solar Open2를 통한 Codex

[English](README.md) / [한국어](README-ko.md)

[← 리포 개요로 돌아가기](../README.md)

**상태:** 기본 경로 검증 완료 — Docker LiteLLM이 Codex 응답을 Solar Open2로
성공적으로 라우팅했습니다. Codex → Upstage 직접 Base URL 변경은 여전히 지원되는
방식이 아니며, 이 Case는 그 대신 브리지를 검증합니다. workspace-file 및 tool-result
cycle은 아직 확인 대상입니다.

## 목표

OpenAI Codex CLI가 Upstage의 **Solar Open2** 모델로 에이전트 코딩 작업을
수행할 수 있는지 확인하고, 프로토콜 브리지가 end-to-end로 검증된 경우에만
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

Codex는 Responses API 요청을 보내지만, Upstage가 공개한 Solar API 사용법은
Chat Completions를 사용합니다. Base URL만 바꾼다고 두 wire protocol이
변환되지는 않으며, Upstage 문서는 이 간극을 메우는 직접 Codex 또는 Responses
API 설정을 제공하지 않습니다.

근거: [Upstage API 키 콘솔 — Chat 예제](https://console.upstage.ai/api-keys?api=chat),
[Codex custom-provider 설정](https://developers.openai.com/codex/config-advanced),
[Codex 설정 레퍼런스](https://developers.openai.com/codex/config-reference).

현재 Upstage 콘솔 예제의 모델명은 `solar-pro3`이고, 이 포트폴리오의 기존
Case들은 `solar-open2`를 사용합니다. Case 05의 실제 검증에서는 계정에
활성화된 모델 ID를 확인해 기록해야 하며, 프로토콜 브리지가 된다는 이유만으로
과거 모델 ID가 계속 제공된다고 가정하면 안 됩니다.

## 계획된 브리지

검증할 수 있는 경로는 다음과 같습니다.

```text
Codex (Responses API) → 프로토콜 변환 프록시 → Upstage (Chat Completions API) → Solar Open2
```

LiteLLM이 이 브리지를 제공합니다. 이 Case가 사용하는
`openai/chat_completions/<model>` 모델 prefix(또는 같은 기능의
`use_chat_completions_api`)는 custom OpenAI-compatible upstream에 대해
`/responses → /chat/completions` 변환을 강제합니다. 다만 Upstage를 향한 전체
tool·streaming 경로는 실제 실행으로 검증해야 합니다.

브리지가 준비되면 Codex는 `openai` 예약 provider를 덮어쓰는 대신 *이름 있는
custom provider*를 사용해야 합니다.

```toml
model = "solar-open2"
model_provider = "solar_proxy"

[model_providers.solar_proxy]
name = "LiteLLM을 통한 Solar Open2"
base_url = "http://127.0.0.1:PORT/v1"
env_key = "LITELLM_MASTER_KEY"
wire_api = "responses"
```

`PORT`는 Upstage endpoint가 아니라 로컬 프록시가 수신하는 포트의 자리표시자입니다.
Codex는 LiteLLM 인증용 `LITELLM_MASTER_KEY`만 사용하고,
`UPSTAGE_API_KEY`는 LiteLLM만 받습니다. 두 키 모두 환경 변수 또는 secret store에만
두고 `config.toml`에는 절대 기록하지 않습니다.

실행 가능한 템플릿은 [`config/litellm-config.yaml`](config/litellm-config.yaml)과
[`config/codex.config.toml`](config/codex.config.toml)입니다. Upstage API base URL
`https://api.upstage.ai/v1/solar` 및 LiteLLM 모델 prefix
`openai/chat_completions/solar-open2`를 사용합니다.

## Docker 프록시 실행

선택한 배포 방식은 Docker입니다. 한 터미널에서 로컬 전용 프록시를 실행합니다.

```bash
export UPSTAGE_API_KEY="..."
./scripts/run-proxy-docker.sh
```

공식 LiteLLM 이미지를 쓰며 `127.0.0.1:4000`에만 바인딩하고, 중지하면
컨테이너도 제거됩니다. 다른 터미널에서 `config/codex.config.toml`을
`$CODEX_HOME/config.toml`로 복사하고, 기본값을 바꿨다면 같은
`LITELLM_MASTER_KEY`를 설정한 뒤 `codex`를 실행합니다.

## 검증 기준

이 Case가 검증 완료로 바뀌려면 다음을 입증해야 합니다.

1. `model = "solar-open2"`를 사용하는 비대화형 `codex exec` 응답.
2. 알려진 로컬 파일을 읽어 그 내용을 보고하는 filesystem tool turn.
3. 스트리밍 출력 및 적어도 한 번의 tool-call/tool-result cycle을 프록시가 정확히 처리함.
4. 리포의 `UPSTAGE_API_KEY` secret을 재사용하는 `scripts/verify.sh`와 GitHub Actions workflow.

`UPSTAGE_API_KEY`를 설정한 뒤 실제 게이트를 실행합니다.

```bash
./scripts/verify.sh
```

LiteLLM을 기동하고 raw `/v1/responses` 브리지 요청을 먼저 확인한 뒤, 격리된
`CODEX_HOME`에서 `codex exec`를 실행합니다. 대응하는 GitHub Actions workflow는
리포의 `UPSTAGE_API_KEY` secret을 재사용합니다.

## 검증 결과

2026-07-20에 Codex CLI `0.144.5`, 공식 LiteLLM Docker 이미지 및
`solar-open2`로 이 구성을 검증했습니다. bridged Responses 요청은
`bridge-ready`를, 비어 있는 read-only 임시 디렉터리의 Codex는
`codex-ready`를 반환했습니다.

LiteLLM 브리지의 한 가지 제약도 확인했습니다. tool이 없는 Responses 요청을
변환할 때 `tools: []`를 붙이고, Upstage는 이를 빈 배열로 거부합니다. 따라서
검증 probe에는 무해한 `noop` function definition을 포함합니다. 이는 전체 tool
cycle 호환성을 뜻하지 않으므로, Case를 검증 완료로 바꾸기 전에 별도로 확인해야
합니다.

전체 실험 계획은 리포 레벨의 [`PLAN.md`](../PLAN.md)를 참고하세요.
