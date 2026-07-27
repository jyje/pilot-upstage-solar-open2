# 갤러리

[English](README.md) / [한국어](README-ko.md)

[← 리포 개요로 돌아가기](../README.md)

이 리포의 에이전트 하네스 케이스들을 통해 Solar Open 2가 실제로 만든,
직접 플레이할 수 있는 앱들입니다 — 그 케이스 자체의 검증 과정에서
실제 브라우저로 기능 확인까지 마쳤고, 아래 각 항목에 명시한 한두 곳의
최소한의 버그 수정 외에는 사람이 직접 쓰거나 편집하지 않았습니다.

실제 배포: [jyje.github.io/pilot-upstage-solar-open2/gallery/](https://jyje.github.io/pilot-upstage-solar-open2/gallery/)

## 항목

### 6x6 미니 스도쿠 — [`case-08-omp-sudoku/`](case-08-omp-sudoku/)

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
