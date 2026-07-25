<div align="center">

# Solar Open 2 Agent Harnesses — Slides

7개 Solar Open 2 에이전트 하니스 실험을 소개하는 Slidev 발표 자료입니다.

[English](./README.md) / [한국어](./README-ko.md)

</div>

## 개요

이 디렉터리에는
[`jyje/pilot-upstage-solar-open2`](https://github.com/jyje/pilot-upstage-solar-open2)의
기술 발표 자료가 있습니다. Solar Open 2를 소개하고, 독립적으로 검증한 7개
에이전트 하니스 사례, 공통 발견 사항, CI 증거, 다음 단계를 다룹니다.

엔트리 파일은 [`slides.md`](./slides.md)입니다. 번호가 붙은 Markdown 파일은
섹션별 편집·검토를 위한 소스 사본입니다. `<Localized>` 컴포넌트가 URL 경로에
따라 영어 또는 한국어 문구를 선택하므로 두 언어 빌드의 내용을 함께 관리합니다.

## 디자인 시스템

발표 자료는 [Upstage 웹사이트](https://www.upstage.ai/)의 시각 언어를
적용합니다. 매우 어두운 네이비 캔버스, 선명한 바이올렛 강조색, 라임 신호색,
시안 보조색, 큰 편집형 제목, 넓은 여백이 핵심입니다.

재사용 가능한 토큰과 컴포넌트 스타일은
[`styles/upstage.css`](./styles/upstage.css)에 있습니다.

| 토큰 | 값 | 역할 |
| --- | --- | --- |
| Ink | `#11111f` | 기본 캔버스 |
| Violet | `#4c2fff` | 주 강조색 |
| Lime | `#c6ff72` | 신호·라벨·섹션 구분선 |
| Cyan | `#8fe7d1` | 보조 제목·링크 |
| Paper | `#f7f7f2` | 밝은 표면용 예비색 |

## 언어와 URL

GitHub Pages 빌드는 두 정적 덱과 언어 선택 화면을 생성합니다.

| 언어 | 경로 | 1번 슬라이드 URL |
| --- | --- | --- |
| English | `/en/` | `/en/#1` |
| 한국어 | `/ko/` | `/ko/#1` |

GitHub Pages는 정적 호스팅이므로 `/en/1` 같은 history 경로를 Slidev 엔트리로
되돌리는 rewrite를 할 수 없습니다. 그래서 hash 라우팅을 의도적으로 사용합니다.

## 요구 사항

- Node.js 22 이상
- npm 10 이상

## 로컬 실행

```bash
cd slide
npm install
npm run dev
```

특정 언어 경로를 확인하려면 다음 명령을 사용합니다.

```bash
npm run dev:en  # http://localhost:3030/en/#1
npm run dev:ko  # http://localhost:3031/ko/#1
```

프레젠테이션 컨트롤 또는 화살표 키로 이동하고, 각 `v-click` 블록을 눌러
순차 콘텐츠를 표시합니다.

## 빌드와 GitHub Pages

```bash
cd slide
npm run build:pages
```

이 명령은 `dist/index.html`, `dist/en/`, `dist/ko/`를 생성합니다.
[`deploy-slides-pages.yml`](../.github/workflows/deploy-slides-pages.yml)
워크플로는 `main`의 `slide/` 변경을 GitHub Pages에 배포하며, CI에서는 GitHub
프로젝트 Pages URL에 필요한 저장소 이름 base 경로를 자동으로 추가합니다.

두 언어 경로를 하나의 포트로 로컬에서 확인하려면 다음을 실행합니다.

```bash
npm run preview:pages
```

그런 다음 `http://localhost:3030/en/#1` 또는
`http://localhost:3030/ko/#1`을 엽니다.

## 스크립트

| 명령 | 용도 |
| --- | --- |
| `npm run dev` | Slidev 개발 모드 실행 |
| `npm run dev:en` | 포트 3030에서 영어 경로 실행 |
| `npm run dev:ko` | 포트 3031에서 한국어 경로 실행 |
| `npm run build` | `dist/`에 정적 Slidev 빌드 생성 |
| `npm run build:pages` | 언어 선택 화면과 `/en/`, `/ko/` Pages 산출물 생성 |
| `npm run preview:pages` | 포트 3030에서 두 언어 Pages 빌드 제공 |
| `npm run preview` | 빌드 후 정적 산출물 제공 |
| `npm run test:e2e` | 향후 브라우저 수준 슬라이드 테스트용 예약 명령 |

`test:e2e`는 아직 구현되어 있지 않습니다. `test-slidev.mjs`가 추가되기 전에는
통과한 품질 게이트로 간주하면 안 됩니다.
