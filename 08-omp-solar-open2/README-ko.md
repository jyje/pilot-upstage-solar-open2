# Case 08 — Solar Open 2 x omp

[English](README.md) / [한국어](README-ko.md)

[← 리포 개요로 돌아가기](../README.md) · 직접 실행해보고 싶다면?
[`REPRODUCE-ko.md`](REPRODUCE-ko.md)에서 단계별 로컬 실행 방법을
확인하세요.

**상태:** 검증 완료 — [omp(oh-my-pi)](https://github.com/can1357/oh-my-pi)가
커스텀 모델 provider로 Solar Open 2를 상대로 실제 응답을 생성하고,
실제로 요청하면 스펙대로 동작하는 앱까지 만들어냅니다. 방식 A~C는
CI를 통과하고, 방식 D(스도쿠 앱 만들기)는 여러 분 걸리는 에이전틱
빌드라 CI마다 다시 돌리는 대신 로컬에서 검증한 뒤
[`../gallery/`](../gallery/)에 실제 플레이 가능한 앱으로 게시해뒀습니다.
필수로 확인된 설정 하나: provider 항목에
`compat.supportsStore: false`가 없으면 모든 요청이 400으로 거부됩니다.

## 목표

[omp](https://omp.sh) — ["Pi"](https://github.com/badlogic/pi-mono)의
포크이자 GitHub 스타 약 2만 개의 터미널 코딩 에이전트로, 스스로를
"IDE가 내장된 에이전트"라고 소개함 — 가 **Solar Open 2**를 커스텀 모델
provider로 실행할 수 있는지, 그리고 그 "IDE 내장" 주장이 한 줄짜리
응답이 아니라 실제로 어느 정도 복잡도가 있는 개발 과제 앞에서도
성립하는지 확인합니다.

## 동작 원리

omp는 커스텀 provider/모델 정의를 `$PI_CODING_AGENT_DIR/models.yml`
(기본값 `~/.omp/agent/models.yml`)에서, 기본 모델 역할은
`$PI_CODING_AGENT_DIR/config.yml`에서 읽습니다.

```yaml
# models.yml
providers:
  upstage:
    baseUrl: https://api.upstage.ai/v1/solar
    api: openai-completions
    apiKey: UPSTAGE_API_KEY
    compat:
      supportsStore: false
    models:
      - id: solar-open2
        name: Solar Open 2 (Upstage)
        contextWindow: 1000000
        maxTokens: 8192
```

```yaml
# config.yml
modelRoles:
  default: upstage/solar-open2
```

`apiKey: UPSTAGE_API_KEY`는 `$UPSTAGE_API_KEY` 보간이 아니라 환경변수
**이름** 그 자체의 리터럴 문자열입니다 — omp는 커스텀 provider의
`apiKey` 값을 "그 이름의 환경변수가 있으면 그 값을, 없으면 문자열
자체를 키로" 해석하므로, 실제 비밀값을 파일에 직접 써 넣을 필요가
없습니다.

[`scripts/verify.sh`](scripts/verify.sh)는 실행 동안만
`$PI_CODING_AGENT_DIR`를 임시 디렉터리로 돌려서 생성된 두 파일을
가리키게 합니다 — 실제 `~/.omp/agent`는 건드리지 않습니다. Case 02가
Hermes Agent의 홈 디렉터리를 격리하는 방식, Case 06이 `$GROK_HOME`을
쓰는 방식과 동일한 패턴입니다.

## 발견: `compat.supportsStore: false`가 없으면 모든 요청이 400으로 거부됨

방식 A를 처음 시도했을 때 매번 이렇게 실패했습니다.

```text
400 Unrecognized request arguments supplied: store
```

omp의 `openai-completions` 클라이언트는 "표준처럼 보이는" 엔드포인트에
기본적으로 `store: false` 파라미터를 얹어서 보냅니다 — OpenAI의 최신
Chat Completions API가 지원하는, 서버 쪽 대화 저장용 파라미터입니다.
Upstage의 엔드포인트는 이 필드를 모르는 파라미터로 취급해 요청 전체를
거부합니다. omp 공식 문서
([`docs/models.md`](https://github.com/can1357/oh-my-pi/blob/main/docs/models.md))가
`compat.supportsStore`를 정확히 이 토글로 문서화하고 있어서, provider
항목에 `false`로 명시하면 즉시 해결됩니다. 이 한 줄이 없으면 Case
08은 아예 동작하지 않습니다.

## 발견: 모호했던 승리 조건 스펙이 첫 시도를 취약하게 만듦

방식 D의 프롬프트는 원래 "칸이 다 차고 충돌이 없으면 Solved!를
보여줘라"라고만 썼습니다. 이 문구만으로는, Solar Open 2가 만든 앱이
채워진 보드가 규칙을 만족하는지가 아니라 **퍼즐 생성 시점에 기억해둔
특정 정답 하나와 일치하는지**로 판정했습니다. 절반 가까이 칸을 지운
6x6 퍼즐은 정답이 여러 개일 수 있어서, (이 케이스의 Playwright 검증이
실제로 하는 것처럼) 앱이 기억한 답이 아니라 독립적으로 계산한 다른
정답을 채워 넣으면, 실제로는 완전히 풀린 보드인데도 앱은 계속
"미해결"로 남았습니다.

요구사항 문구를 "저장된 정답 배열과 비교하지 말고, 매번 행/열/박스
규칙을 동적으로 검사하라"고 명시적으로 다시 쓰자 바로 다음 시도에서
해결됐습니다 — 다시 만들어진 앱은 실제 행/열/박스 규칙 검사를
구현했고, 아래 음성 테스트를 포함한 모든 방식을 통과합니다. 이걸
남겨두는 이유는 단순한 프롬프트 작성 팁이 아니라, Solar Open 2가
코딩 과제에서 스펙의 정밀도에 실제로 어떻게 반응하는지 보여주는
실측 사례이기 때문입니다.

## 네 가지 방식

### 방식 A — 결정론적 단일 턴 응답

```bash
omp --print --auto-approve --model "upstage/solar-open2" "Reply with exactly: omp-solar-ready"
```

omp의 headless 모드(`--print`)를 통한 순수 비-tool 왕복이며, 정확한
문자열로 확인합니다.

### 방식 B — 추론이 필요한 프롬프트

```bash
omp --print --auto-approve --model "upstage/solar-open2" "Explain step by step why the sum of the first 50 positive integers equals 1275. Show your reasoning."
```

Solar Open 2 자체의 추론만 확인하며, 정확한 숫자 답으로 검증합니다.

### 방식 C — 간단한 코딩 작업

```bash
omp --print --auto-approve --model "upstage/solar-open2" "Write a Python function named is_prime(n) that returns True if n is a prime number and False otherwise. Include a brief docstring. Output only the code in a single fenced code block."
```

응답에 `def is_prime`가 있는지로 확인합니다.

### 방식 D — 실제 개발 과제: 동작하는 6x6 미니 스도쿠 앱

```bash
omp --print --auto-approve --max-time 8m --model "upstage/solar-open2" "$(cat scripts/sudoku-prompt.txt)"
```

앞의 세 방식은 텍스트 응답에 특정 문자열이 있는지만 봅니다. 방식
D는 omp에게 — 이 리포가 파일을 직접 쓰는 게 아니라 omp 자신의
`write`/`edit`/`bash` 내장 툴을 통해 — 6x6 스도쿠(숫자 1-6, 2x3
박스)를 실제로 플레이할 수 있는 단일 `index.html`을 만들라고
요청합니다: 퍼즐 생성, 실시간 충돌 표시, 승리 판정, "New Puzzle"
버튼까지. 결과물을 사람이 눈으로 보지 않고도 결정적으로 채점할 수
있도록 DOM 계약(`#cell-R-C` 입력, `#status`, `#new-puzzle`)을 명시해
두었습니다. 모델에 그대로 전달되는 전체 요구사항 원문은
[`scripts/sudoku-prompt.txt`](scripts/sudoku-prompt.txt)를 참고하세요.

[`scripts/verify-sudoku.mjs`](scripts/verify-sudoku.mjs)는 실제 산출물
파일을 헤드리스 Chromium(Playwright)으로 열어 직접 플레이합니다: 36개
셀을 전부 읽고, 생성된 given 셀들이 이미 규칙을 위반하지 않는지
확인하고, 작은 백트래킹 솔버로 독립적으로 정답을 계산하고, 실제 UI를
통해(앱 자신의 리스너가 발동하도록) 모든 편집 가능한 셀을 채운 뒤,
`#status`가 `solved` 클래스와 함께 `Solved!`를 보여주는지 확인하고,
마지막으로 셀 하나를 일부러 틀리게 바꿔 상태 표시가 다시 사라지는지
확인합니다 — 승리 판정이 항상 "성공"만 반환하는 눈속임이 아님을
증명합니다.

## 검증된 방식

| 방식 | 결과 |
| --- | --- |
| A — 단일 턴 응답 | `omp-solar-ready` |
| B — 추론 프롬프트 | Gauss 공식으로 `1275`를 정확히 도출함(CI 출력 자체에 전체 내용 포함) |
| C — 코딩 작업 | 정확하고 동작하는 `is_prime(n)` 구현 + docstring(전체 코드는 CI 출력에 포함) |
| D — 동작하는 스도쿠 앱 만들기 | 실제 `index.html`을 헤드리스 Chromium으로 열어 확인: 올바른 퍼즐 생성, 실시간 충돌 표시, 실제로 동작하는 승리 판정, 실제로 동작하는 "New Puzzle" — 모두 소스 코드를 훑는 게 아니라 기능적으로 검증함 |

실제, 편집 없는 전체 내용은 아래 [증거 실행](#증거-실행)을 참고하세요.

이 케이스에서 *관찰되지 않은* 것도 하나 적어둡니다: Case 05/06과
달리, 이 케이스가 실제로 수행한 omp의 tool 호출(방식 D가 자체 내장
툴로 파일을 쓰고, 읽고, 셸에서 문법을 점검하는 과정 전체)에서는
[Case 05의 Finding 2](../05-langchain-openwiki-solar-open2/README-ko.md#발견-2-스트리밍-시-solar-open-2가-tool_call의-function-name을-누락함)에
문서화된 Upstage 스트리밍 tool_call 함수명 누락 버그가 한 번도
재현되지 않았습니다. 버그가 없다고 확정하는 것은 아니고, 이 케이스의
테스트 범위에서는 나타나지 않았다는 뜻입니다.

## 검증

[`scripts/verify.sh`](scripts/verify.sh)가 `omp`를 Solar Open 2 상대로
headless로 실행합니다(기본값은 방식 A~D 전부 게이트). 방식 A의 응답에
`omp-solar-ready`가 없거나, 방식 B의 답변에 `1275`가 없거나, 방식
C의 코드에 `def is_prime`가 없거나, 방식 D의 결과물이 위 Playwright
검증 중 하나라도 실패하면 0이 아닌 코드로 종료합니다. 방식 A~C는
이 리포가 공유하는 Tier-0 레이트리밋 때문에 생길 수 있는 일시적
실패에 대비해 30초 간격으로 최대 5회 재시도합니다. 방식 D는 omp
프로세스 자체가 실패(인증·레이트리밋 성격)했을 때만 최대 3회
재시도합니다 — omp가 일단 성공적으로 끝났는데 Playwright 검증이
실패한 경우는 재시도 없이 그대로 실제 결과로 기록합니다.

`SKIP_METHOD_D`를 비어있지 않은 값으로 설정하면 방식 D를 통째로
건너뛰고 A~C만으로 게이트합니다. **CI는 항상 이 값을 설정합니다** —
방식 D는 헤드리스 브라우저까지 필요한 여러 분짜리 에이전틱 빌드라,
다른 7개 Case와 함께 매번 도는 스텝에는 맞지 않습니다. 검증 자체는
빠지지 않고 로컬에서 이루어지며, 그 결과는 매번 다시 돌리는 대신
[`../gallery/`](../gallery/)에 실제 플레이 가능한 앱으로 게시해
둡니다. 그 로컬 실행 결과는 아래 [증거 실행](#증거-실행)에서 확인할
수 있습니다.

### 방식 D 헤드투헤드: solar-open2 vs solar-pro4

이전 로컬 검증 회차에서 방식 D가 두 모델 모두 건너뛰어졌다는 점이 감사
과정에서 드러나, 2026-08-04에 같은 프롬프트·같은 하네스·같은 8분
제한으로 두 모델 각각 새로 실행했습니다. 전체 기록:
[`case-08-method-d-sudoku-head-to-head.log`](../logs/local-verification/2026-08-03/case-08-method-d-sudoku-head-to-head.log).

| | solar-open2 | solar-pro4 |
| --- | --- | --- |
| 첫 시도에 `index.html` 생성 | 예 | 예 |
| **무수정 상태로** 게이트 통과 | 아니오 | 아니오 |
| 결함 유형 | 주어진 칸/빈 칸 집합이 뒤바뀜, **그리고** `generateFullGrid()`가 서로 독립적이라 잘못 가정한 박스 3개를 미리 채움(6x6의 2x3 박스인 그 셋은 0–2열을 공유) | 잘못된 줄 하나 — `var positions = shuffle positions = shufflePositions();` — 문법 오류로 스크립트 전체가 죽음 |
| 통과까지 걸린 수정 라운드 | 도달 못 함 (3회 시도, 그중 2회는 8분 예산을 소진하며 수정 자체를 내놓지 못함) | 1회 |
| 최종 게이트 | ✗ | ✓ 6/6 |

두 모델 모두 단발로는 이 과제를 통과하지 못했습니다. 차이는 "무엇이
망가졌고 얼마나 복구 가능했는가"입니다. `solar-pro4`의 결함은 기계적인
것 하나였고 한 번에 고쳤지만, `solar-open2`는 논리 결함이 두 겹으로
쌓여 있었고 수정 도중 에이전틱 예산을 두 번이나 소진했습니다. 각 1회
실행은 벤치마크가 아니지만, 실제 과제에서 나온 실제 결과이므로 덮지
않고 기록합니다. 갤러리에 게시된 open2 항목은 이번 실행 결과물이 아니라
이전에 이미 검증된 빌드입니다.

`UPSTAGE_API_KEY`를 설정하고 `omp`를 설치한 뒤
(`curl -fsSL https://omp.sh/install | sh`), `PATH`에 Node 18+가 있는
상태로 로컬에서 실행하세요.

```bash
UPSTAGE_API_KEY="..." ./scripts/verify.sh                  # 방식 A-D
UPSTAGE_API_KEY="..." SKIP_METHOD_D=1 ./scripts/verify.sh   # 방식 A-C만, CI와 동일
```

스크립트는 `SKIP_METHOD_D`가 없을 때 첫 실행 시 자체적으로 Playwright
의존성과 Chromium 브라우저를 설치합니다
([`scripts/package.json`](scripts/package.json) 참고).

CI에서는 두 가지 방식으로 실행됩니다(둘 다 수동 실행, `solar-open2`만,
방식 A~C만): 다른 모든 Case와 함께
[`verify-all-sequential.yml`](../.github/workflows/verify-all-sequential.yml)의
한 스텝으로, 그리고 단독으로
[`verify-08-omp-solar-open2.yml`](../.github/workflows/verify-08-omp-solar-open2.yml)로 —
둘 다 동일한 `UPSTAGE_API_KEY` 저장소 시크릿을 재사용하고 `omp`를
공식 설치 스크립트로 설치합니다.

## 증거 실행

**증거 실행:** [`verify` job, 2026-07-27](https://github.com/jyje/pilot-upstage-solar-open2/actions/runs/30267245461)
(이 CI 실행은 방식 A~C만 다루며, 방식 D가 왜 거기 없는지는 위
[검증](#검증) 절 참고). 실제 Upstage API를 상대로 로컬에서 실행한, 네 방식 전부의 편집 없는
결과입니다:

**방식 A**

> omp-solar-ready

**방식 B**

> # Sum of the First 50 Positive Integers
>
> The sum $1 + 2 + 3 + \cdots + 50 = 1275$. Here's why, step by step.
>
> ## Method 1: The Formula
>
> The sum of the first $n$ positive integers is given by:
>
> $$S_n = \frac{n(n+1)}{2}$$
>
> For $n = 50$:
>
> $$S_{50} = \frac{50 \times (50 + 1)}{2}$$
>
> $$S_{50} = \frac{50 \times 51}{2}$$
>
> ## Step 3: Calculate
>
> $$50 \times 51 = 2550$$
>
> $$\frac{2550}{2} = 1275$$
>
> ...(truncated)

**방식 C**

> ```python
> def is_prime(n: int) -> bool:
>     """Return True if n is a prime number, False otherwise.
>
>     A prime number is a natural number greater than 1 that has no
>     positive divisors other than 1 and itself.
>     """
>     if n < 2:
>         return False
>     if n < 4:
>         return True
>     if n % 2 == 0 or n % 3 == 0:
>         return False
>     i = 5
>     while i * i <= n:
>         if n % i == 0 or n % (i + 2) == 0:
>             return False
>         i += 6
>     return True
> ```

**방식 D**

```
✓ omp wrote an index.html for the Sudoku app
✓ found all 36 cell inputs with the expected id contract
✓ 18 given cells form a legal partial grid (no conflicts)
✓ computed a valid full solution consistent with the given cells
✓ #status shows "Solved!" with the solved class after a correct completion
✓ negative test passed: breaking a correct cell clears the "Solved!" status
✓ "New Puzzle" generated a different set of given cells (not hardcoded)

All Method D checks passed.
```

## Solar Pro4

브릿지가 필요 없습니다: omp는 Solar Open 2를 커스텀
`openai-completions` provider로 등록하며, 동일한 등록이 Upstage의 Chat
Completions 엔드포인트에서 `solar-pro4`에도 직접 도달합니다.

2026-08-03에 로컬로 검증했습니다(전체 로그:
[`logs/local-verification/2026-08-03/case-08-solar-pro4.log`](../logs/local-verification/2026-08-03/case-08-solar-pro4.log)):
방식 A(결정론적 응답), B(추론 프롬프트), C(코딩 과제) 모두 `solar-pro4`로
통과했습니다(방식 D는 `solar-open2` CI 실행과 마찬가지로 로컬에서도
건너뛰었습니다 — 게시된 방식 D 결과는
`gallery/case-08-omp-sudoku-solar-open2/` 참고).

전체 맥락은 리포 레벨의 [`PLAN.md`](../PLAN.md)를 참고하세요.
