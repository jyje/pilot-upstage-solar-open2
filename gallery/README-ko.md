# 갤러리

[English](README.md) / [한국어](README-ko.md)

[← 리포 개요로 돌아가기](../README.md)

이 리포의 에이전트 하네스 케이스들을 통해 Upstage의 Solar 모델들이
실제로 만든, 직접 플레이할 수 있는 앱들입니다 — 그 케이스 자체의 검증
과정에서 실제 브라우저로 기능 확인까지 마쳤고, 아래 각 항목에 명시한
한두 곳의 최소한의 버그 수정 외에는 사람이 직접 쓰거나 편집하지
않았습니다.

실제 배포: [jyje.github.io/pilot-upstage-solar-open2/gallery/](https://jyje.github.io/pilot-upstage-solar-open2/gallery/)

## 항목

각 항목의 경로에 그것을 만든 모델명이 들어가 있고, 페이지 자체에도
표시됩니다 — 같은 명세를 서로 다른 Solar 모델에 주면 같은 결과가 나오지
않기 때문입니다.

### 6x6 미니 스도쿠 (solar-open2) — [`case-08-omp-sudoku-solar-open2/`](case-08-omp-sudoku-solar-open2/)

[Case 08](../08-omp-solar-open2/)의 `omp`(oh-my-pi) 하네스를 통해
Solar Open 2가 문서화된 요구사항 명세로부터 직접 만들었습니다 — 이
빌드는
[`08-omp-solar-open2/scripts/sudoku-prompt.txt`](../08-omp-solar-open2/scripts/sudoku-prompt.txt)의
기본 스펙에 시각 디자인·구조 계약 세부사항을 더 추가한 버전을
사용했습니다. 단일 자족형 `index.html` 하나로 퍼즐 생성, 실시간 충돌
표시, 실제 규칙 기반 승리 판정, 동작하는 "New Puzzle" 버튼까지
구현되어 있습니다.

**솔직한 버그 수정 기록:** 원본 결과물에는 실제 버그가 있었습니다 —
승리 판정 상태가 매 입력마다 재평가되지 않았고(엉뚱한 함수를
호출함), 그걸 고친 뒤에도 보드를 다시 틀리게 만들었을 때 "Solved!"
상태가 사라지지 않는 문제가 있었습니다. 이 두 가지는 사람이 직접
코드를 써넣은 게 아니라, 정확히 어떤 버그인지 설명하며 `omp` 자신에게
목표를 좁힌 수정을 요청하는 방식으로 고쳤습니다 — 이 리포의 다른
케이스들이 이미 쓰는 것과 동일한 "요청 → 검증 → 수정" 루프입니다.

세 번째 버그는 그 이후에, 자동 검증이 아니라 눈으로 직접 보다가
발견했습니다: `generatePuzzle()`이 `shuffle(positions)`를 호출하고도
반환값을 다시 대입하지 않아서, 매번 생성되는 숫자 값은 달라져도
"주어진 칸"의 위치는 항상 똑같이 맨 위 세 행으로 고정돼 있었습니다 —
겉으로는 매번 새로 생성된 것처럼 보였지만 실제 모양은 한 번도 바뀐
적이 없었던 셈입니다. 기존 Playwright 검증은 두 번 생성한 결과물의
주어진 칸 "값"만 비교했지 "위치"는 비교하지 않아서, 이 버그가 있어도
6/6 전부 통과했습니다. 이번 것은 원인이 한 줄로 명확하고 애매함이
없어서 `omp`를 다시 거치지 않고 직접 고쳤습니다
(`const shuffledPositions = shuffle(positions)`).
[Case 08의 README](../08-omp-solar-open2/README-ko.md)에서 이 케이스
자체의 게이트 검증(원본 그대로, 편집 없이 실행)에서 나온 같은 종류의
발견 사항들을 확인할 수 있습니다.

### 6x6 미니 스도쿠 (solar-pro4) — [`case-08-omp-sudoku-solar-pro4/`](case-08-omp-sudoku-solar-pro4/)

같은 명세, 같은 하네스, 같은 8분 제한을 `solar-pro4`에 준 결과입니다.
위 항목과의 헤드투헤드 비교로 2026-08-04에 만들었고, 전체 기록은
[`logs/local-verification/2026-08-03/case-08-method-d-sudoku-head-to-head.log`](../logs/local-verification/2026-08-03/case-08-method-d-sudoku-head-to-head.log)에
있습니다.

**솔직한 버그 수정 기록:** 단발 출력에 결함이 하나 있었습니다.
`var positions = shuffle positions = shufflePositions();`라는 잘못된
줄이 자바스크립트 문법 오류를 일으켜 스크립트 전체가 죽었고, 보드가
아예 렌더링되지 않았습니다. 그 줄을 그대로 `omp`에 되돌려주자 한 번에
고쳤고(위와 동일한 ask-verify-fix 루프, 사람이 쓴 코드로 대체하지
않음), 이후 6개 브라우저 검사를 모두 통과했습니다.

대조적으로, 같은 헤드투헤드에서 `solar-open2`의 새 단발 빌드는 통과
상태에 도달하지 못했습니다. 두 개의 논리 결함이 겹쳐 있었고(주어진
칸/빈 칸 집합이 뒤바뀐 것, 그리고 `generateFullGrid()`가 서로 독립적이라
잘못 가정한 박스 3개를 미리 채우는 것 — 6x6에서 2x3 박스인 그 셋은
0-2열을 공유합니다), 8분 에이전틱 예산을 두 번 모두 소진하면서 수정
자체를 내놓지 못했습니다. 위에 게시된 open2 항목은 그 실행의 결과물이
아니라 이전에 이미 검증된 빌드입니다. 각 1회 실행은 벤치마크가 아니지만,
차이는 실재했고 덮지 않고 기록해 둡니다.
