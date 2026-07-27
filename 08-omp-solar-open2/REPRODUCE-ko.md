# Case 08 — 유즈케이스 가이드

[English](REPRODUCE.md) / [한국어](REPRODUCE-ko.md)

[← 이 Case의 README로 돌아가기](README.md) · [← 전체 Case 유즈케이스 가이드](../docs/REPRODUCE-ko.md)

목표: omp(oh-my-pi)를 커스텀 OpenAI 호환 모델 provider로 Solar Open 2
상대로 실행합니다 — 브리지도 프록시도 없이 omp 자체의 `models.yml`
메커니즘만 사용하고, 실제로 앱을 만들어달라고 요청한 뒤 진짜 브라우저에서
기능적으로 검증합니다.

전체 서사, 발견 사항, 검증된 실행 결과: [`README.md`](README.md).

`UPSTAGE_API_KEY`를 아직 설정하지 않았거나 공유 Tier-0 레이트리밋을
읽지 않았다면, 먼저 [`docs/REPRODUCE-ko.md`](../docs/REPRODUCE-ko.md)를
확인하세요 — 이 페이지는 둘 다 이미 준비됐다고 가정합니다.

## 필요한 것

- omp: `curl -fsSL https://omp.sh/install | sh` (macOS/Linux — 또는
  `brew install can1357/tap/omp`, 또는
  `bun install -g @oh-my-pi/pi-coding-agent`)
- `PATH`에 Node 18+ — 방식 D의 기능 검증이 Playwright로 실제 헤드리스
  브라우저를 구동합니다

Docker, Python 모두 필요 없습니다.

## 실행하기

리포 루트에서 이 디렉터리로 `cd`한 뒤 스크립트를 실행하세요.

```bash
cd 08-omp-solar-open2
export UPSTAGE_API_KEY="up_..."
./scripts/verify.sh
```

스크립트는 실행 동안만 쓰는 임시 `models.yml`/`config.yml`을 생성하고
`$PI_CODING_AGENT_DIR`을 그쪽으로 돌립니다 — 실제 `~/.omp/agent`는
전혀 건드리지 않습니다. 첫 실행 시 자체 Playwright 의존성과 Chromium도
함께 설치합니다(`scripts/node_modules/`, gitignore 대상) — 처음 한 번은
시간이 좀 걸리고, 이후에는 빠르게 건너뜁니다.

방식 D(스도쿠 빌드)는 실제로 몇 분이 걸립니다 — 한 줄짜리 프롬프트에
답하는 게 아니라 omp가 자체 에이전틱 루프로 파일을 쓰고, 읽고, 스스로
점검하기 때문입니다. 멈춘 게 아니라 정상입니다.

## 성공하면 이렇게 보입니다

```
== Model under test: upstage/solar-open2 ==
...
omp-solar-ready
✓ omp completed a live solar-open2 round trip
...
1275
✓ solar-open2 reasoned through the sum correctly
...
def is_prime
✓ solar-open2 wrote the requested function
...
✓ omp wrote an index.html for the Sudoku app
✓ found all 36 cell inputs with the expected id contract
✓ 18 given cells form a legal partial grid (no conflicts)
✓ computed a valid full solution consistent with the given cells
✓ #status shows "Solved!" with the solved class after a correct completion
✓ negative test passed: breaking a correct cell clears the "Solved!" status
✓ "New Puzzle" generated a different set of given cells (not hardcoded)

All Method D checks passed.

✓ All checks passed.
```

## 문제가 생기면

- **`omp CLI not found`** — 위 설치 명령을 실행한 뒤, 새 셸에서
  `omp --version`이 동작하는지 확인하세요.
- **`400 Unrecognized request arguments supplied: store`** — 이
  스크립트의 `config/models.yml.template`는 이미
  `compat.supportsStore: false`를 설정해 이 문제를 막아둡니다
  ([`README.md`](README.md)의 첫 번째 발견 참고). 직접 실험하다가 이
  에러를 봤다면 이 줄이 빠진 것입니다.
- **방식 D가 omp 자체가 아니라 Playwright 검증 단계에서 실패** — omp는
  끝까지 실행되어 파일을 썼지만, 그 파일이 실제로는 스펙대로 동작하지
  않는다는 뜻입니다(잘못된 DOM 계약, 깨진 승리 판정 등). 실패 메시지에
  나오는 `scripts/verify.sh`의 임시 `work_dir` 경로를 브라우저로 직접
  열어서 실제로 뭐가 만들어졌는지 확인하세요.
- **`node: command not found`** — Node 18+를 먼저 설치하세요. 방식
  D의 기능 검증은 Node 없이는 돌아가지 않습니다.

## 손으로 직접 해보기

`omp`를 설치했다면, 아래는 스크립트가 만드는 것과 동일한 설정을 직접
실행해보는 방법입니다(`08-omp-solar-open2/` 안에서 실행하세요).

```bash
agent_dir="$(mktemp -d)"
sed "s/OMP_MODEL_PLACEHOLDER/solar-open2/g" \
  config/models.yml.template > "$agent_dir/models.yml"
sed "s/OMP_MODEL_PLACEHOLDER/solar-open2/g" \
  config/config.yml.template > "$agent_dir/config.yml"

PI_CODING_AGENT_DIR="$agent_dir" omp --print --auto-approve \
  --model "upstage/solar-open2" "Reply with exactly: omp-solar-ready"

rm -rf "$agent_dir"
```
