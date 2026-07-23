# Case 06 — 유즈케이스 가이드

[English](REPRODUCE.md) / [한국어](REPRODUCE-ko.md)

[← 이 Case의 README로 돌아가기](README.md) · [← 전체 Case 유즈케이스 가이드](../docs/REPRODUCE-ko.md)

목표: xAI의 Grok Build CLI를 커스텀 모델 provider로 Solar Open 2 상대로
실행합니다 — 브리지도 프록시도 없이, Grok Build 자체의 "임의의 커스텀
모델" 설정 메커니즘만 사용합니다.

전체 서사, 발견 사항, 검증된 실행 결과: [`README.md`](README.md).

`UPSTAGE_API_KEY`를 아직 설정하지 않았거나 공유 Tier-0 레이트리밋을
읽지 않았다면, 먼저 [`docs/REPRODUCE-ko.md`](../docs/REPRODUCE-ko.md)를
확인하세요 — 이 페이지는 둘 다 이미 준비됐다고 가정합니다.

## 필요한 것

- Grok Build의 `grok` CLI: `curl -fsSL https://x.ai/cli/install.sh | bash`
  (macOS는 `brew install --cask grok-build`도 가능)

Docker, Node, Python 모두 필요 없습니다.

## 실행하기

리포 루트에서 이 디렉터리로 `cd`한 뒤 스크립트를 실행하세요.

```bash
cd 06-grok-build-solar-open2
export UPSTAGE_API_KEY="up_..."
./scripts/verify.sh
```

스크립트는 실행 동안만 쓰는 임시 `config.toml`을 생성하고
`$GROK_HOME`을 그쪽으로 돌립니다 — 실제 `~/.grok`은 전혀 건드리지
않습니다.

## 성공하면 이렇게 보입니다

```
== Model under test: solar-open2 ==
...
grok-solar-ready
✓ grok completed a live solar-open2 round trip
...
1275
✓ solar-open2 reasoned through the sum correctly
...
def is_prime
✓ solar-open2 wrote the requested function
...
(reproduced: Upstage dropped the tool_call function name, same as Case 05's Finding 2)
✓ All checks passed.
```

마지막 "reproduced" 줄은 예상된 것입니다 — 실패가 아니라 이미 문서화된
알려진 발견 사항입니다([`README.md`](README.md) 참고). 스크립트는
방식 A, B, C 자체가 통과하지 못할 때만 실패합니다.

## 문제가 생기면

- **`grok CLI not found`** — 위 설치 명령을 실행한 뒤, 새 셸에서
  `grok --version`이 동작하는지 확인하세요.
- **`unknown model id`** — 거의 항상 커스텀 모델을 프로젝트 로컬
  `.grok/config.toml`에 넣어서 생긴 문제입니다(user-level에 넣어야
  합니다). 이 스크립트는 `$GROK_HOME`으로 이 문제를 아예 피합니다.
  직접 실험해보고 싶다면 아래 [손으로 직접 해보기](#손으로-직접-해보기)를
  참고하세요.

## 손으로 직접 해보기

`grok`을 설치했다면, 아래는 스크립트가 만드는 것과 동일한 설정을 직접
실행해보는 방법입니다(`06-grok-build-solar-open2/` 안에서 실행하세요).

```bash
grok_home="$(mktemp -d)"
sed "s/SOLAR_MODEL_PLACEHOLDER/solar-open2/g" \
  config/config.toml.template > "$grok_home/config.toml"

GROK_HOME="$grok_home" grok -p "Reply with exactly: grok-solar-ready" -m solar-open2

rm -rf "$grok_home"
```
