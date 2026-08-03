# Case 09 — 유즈케이스 가이드

[English](REPRODUCE.md) / [한국어](REPRODUCE-ko.md)

[← 이 케이스의 README로 돌아가기](README-ko.md) · [← 전체 케이스 유즈케이스 가이드](../docs/REPRODUCE-ko.md)

목표: OpenAI Codex CLI를 로컬 LiteLLM 프록시로 Solar Open 2(그리고
Solar Pro4)에 연결합니다 — 프록시가 Codex의 Responses API를 Upstage의
Chat Completions 엔드포인트로 브릿지합니다.

전체 이야기, 발견 사항, 검증 로그: [`README-ko.md`](README-ko.md).

`UPSTAGE_API_KEY` 설정이나 공유 Tier-0 레이트리밋 설명을 아직 안 봤다면
[`docs/REPRODUCE-ko.md`](../docs/REPRODUCE-ko.md)를 먼저 읽어보세요 — 이
문서는 둘 다 이미 준비됐다고 가정합니다.

## 필요한 것

- Codex CLI: `npm install -g @openai/codex`
- LiteLLM 프록시 CLI: `pip install 'litellm[proxy]'`

## 실행

리포 루트에서 먼저 이 디렉토리로 이동한 뒤, 스크립트를 실행하세요:

```bash
cd 09-codex-upstage-solar-open2
export UPSTAGE_API_KEY="up_..."
./scripts/verify.sh
```

`SOLAR_MODEL`로 모델을 고를 수 있습니다(기본값 `solar-open2`;
`solar-pro4`도 시도해보세요 — Upstage 자체 Anthropic 호환 엔드포인트에는
매핑이 없지만 이 브릿지로는 정상 동작합니다):

```bash
SOLAR_MODEL=solar-pro4 UPSTAGE_API_KEY="up_..." ./scripts/verify.sh
```

스크립트는 순정 `litellm` 프록시를 `127.0.0.1:4000`에 띄우고, 격리된
`$CODEX_HOME`이 그걸 바라보게 한 뒤(실제 Codex 설정은 건드리지 않음)
종료 시 둘 다 정리합니다.

## 성공했을 때 화면

```
== Model under test: solar-open2 ==
✓ LiteLLM proxy is ready
✓ LiteLLM translated a Responses request for solar-open2
✓ Codex completed a full round trip through LiteLLM and solar-open2
```

## 문제가 생겼다면

- **파일을 읽는 프롬프트가 `unsupported call: read_file`로 실패** —
  Codex CLI `0.146.0`의 알려진 도구 라우터 회귀 버그이며, Solar Open
  2/Pro4나 브릿지 문제가 아닙니다(`README-ko.md`의 상태/검증 결과
  참고). `scripts/verify.sh`는 도구 호출 없는 프롬프트로 이를 우회합니다.
- **`litellm: command not found`** — `pip install litellm`가 아니라
  `pip install 'litellm[proxy]'`로 설치하세요.
