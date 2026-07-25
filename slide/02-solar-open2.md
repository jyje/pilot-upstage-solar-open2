<!-- slidev:enable-auto-animate -->
# Solar Open 2

## Upstage's 250B MoE Model

<v-click>

### 모델 스펙

| 항목 | 내용 |
|------|------|
| **파라미터** | 250B total / 15B active (MoE) |
| **컨텍스트** | 1M tokens |
| **라이선스** | Upstage Solar License |

</v-click>

<v-click>

### 설계 목적

- **Long-horizon agentic tasks** — 툴 사용, 다단계 추론, 엔드투엔드 태스크 실행
- **Hybrid linear/softmax attention** — 1M 컨텍스트에서 효율적 처리
- **Korean-first** — 한국어 벤치마크 최상위 성능

</v-click>

<!--
Solar Open 2는 Upstage의 공개 가중치 250B-A15B Mixture-of-Experts 모델입니다.
총 2500억 파라미터 중 활성 파라미터는 150억개이며,
1M 토큰 컨텍스트에서 에이전트 작업을 위해 하이브리드 attention 스택으로 설계되었습니다.

특히 한국어 벤치마크에서 fast-tier 폐쇄형 API를 포함한 비교 대상 중
가장 높은 평균 점수를 기록하는 것이 특징입니다.
-->
