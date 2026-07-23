# Case 07 — 유즈케이스 가이드

[English](REPRODUCE.md) / [한국어](REPRODUCE-ko.md)

[← 이 Case의 README로 돌아가기](README.md) · [← 전체 Case 유즈케이스 가이드](../docs/REPRODUCE-ko.md)

목표: 커뮤니티 Helm 차트 `jyje/hermes-agent-helm`으로 임시 kind 클러스터
위에 Hermes Agent를 배포하고, 내장 Upstage provider를 통해 Solar Open 2에
도달하는지 검증합니다 — Case 02가 일반 Docker 이미지로 검증한 것과 같은
provider 경로를, 이번에는 Kubernetes 위에서 확인합니다.

전체 서사와 검증된 실행 결과: [`README.md`](README.md).

`UPSTAGE_API_KEY`를 아직 설정하지 않았거나 공유 Tier-0 레이트리밋을
읽지 않았다면, 먼저 [`docs/REPRODUCE-ko.md`](../docs/REPRODUCE-ko.md)를
확인하세요 — 이 페이지는 둘 다 이미 준비됐다고 가정합니다.

## 필요한 것

- [Docker](https://docs.docker.com/get-docker/)(데몬 실행 중이어야
  합니다 — kind는 클러스터 노드를 컨테이너로 실행합니다)
- [`kind`](https://kind.sigs.k8s.io/docs/user/quick-start/#installation)
- [`kubectl`](https://kubernetes.io/docs/tasks/tools/#kubectl)
- [`helm`](https://helm.sh/docs/intro/install/) 3+

Node, Python 모두 필요 없고, `hermes-agent-helm`을 `git clone`할 필요도
없습니다 — 차트는 공개된 OCI 아티팩트에서 바로 설치됩니다.

## 실행하기

리포 루트에서 이 디렉터리로 `cd`한 뒤 스크립트를 실행하세요.

```bash
cd 07-hermes-agent-helm-solar-open2
export UPSTAGE_API_KEY="up_..."
./scripts/verify.sh
```

스크립트는 일회용 kind 클러스터(`pilot-solar-open2-<pid>`라는 이름)를
만들고, 성공하든 실패하든 스크립트가 종료될 때 다시 삭제합니다 — 기존에
갖고 있던 다른 kind 클러스터나 `~/.kube/config`의 다른 컨텍스트는 전혀
건드리지 않고, 자신이 추가한 것만 나중에 제거합니다.

## 성공하면 이렇게 보입니다

```
== Model under test: solar-open2 (hermes-agent chart v0.12.0) ==

== Creating ephemeral kind cluster: pilot-solar-open2-19728 ==
...
✓ kind cluster is ready

== Installing hermes-agent-helm from the published OCI chart ==
...
✓ chart installed and the gateway pod is ready

== Method A: the chart's own tests.chat Helm-test Job ==
...
✓ the chart's own Helm test Job completed a live solar-open2 round trip

== Method B: live chat round trip against the running gateway pod =="
...
✓ the running gateway pod reasoned through the sum correctly via solar-open2

== Method C: Hermes, in its own words, on the Solar Open 2 synergy ==
...
✓ Hermes described its own Solar Open 2 strengths in N non-empty lines

✓ All checks passed.
```

(방식 C의 줄 수는 실행마다 다릅니다 — 스크립트는 최소 10줄만 요구하며,
실제 실행에서는 보통 수십 줄이 나옵니다.)

전체 실행은 몇 분 정도 걸립니다 — 대부분 kind 클러스터가 뜨고 차트
이미지를 받는 시간이며, 모델 호출 자체는 그중 일부일 뿐입니다.

## 문제가 생기면

- **`Docker daemon is not available`** — Docker Desktop(또는 사용 중인
  Docker 엔진)을 실행한 뒤 다시 시도하세요.
- **`kind create cluster`가 멈추거나 실패함** — 이전에 중단된 실행이
  남긴 클러스터인 경우가 많습니다. `kind get clusters`로 확인 후
  `pilot-solar-open2-*` 항목을 `kind delete cluster --name <name>`으로
  지우고 재시도하세요.
- **Helm install이 파드를 기다리다 타임아웃됨** —
  `kubectl --context kind-pilot-solar-open2-<pid> get pods -n hermes-agent`와
  `kubectl ... describe pod ...`로 확인하세요. 보통 새 클러스터에서
  이미지 pull이 살짝 지연되는 것뿐이라 재실행하면 됩니다.
- **방식 A 또는 B가 레이트리밋처럼 보이는 이유로 실패함** — 이 리포의
  모든 Case가 하나의 Upstage 계정을 공유합니다. 스크립트는 이미 다른
  모든 Case와 동일하게 30초 백오프로 5번 재시도합니다.

## 손으로 직접 해보기

위 사전 준비물을 설치했다면, 아래는 스크립트가 하는 것과 동일한 설치를
직접 실행해보는 방법입니다(`07-hermes-agent-helm-solar-open2/` 안에서
실행하세요).

```bash
kind create cluster --name my-solar-open2-test --wait 90s

helm upgrade --install hermes-agent \
  oci://ghcr.io/jyje/hermes-agent-helm/hermes-agent --version 0.12.0 \
  --kube-context kind-my-solar-open2-test \
  --namespace hermes-agent --create-namespace \
  -f values-solar-open2.yaml \
  --set-string env.UPSTAGE_API_KEY='up_...' \
  --wait

helm test hermes-agent -n hermes-agent \
  --kube-context kind-my-solar-open2-test
kubectl --context kind-my-solar-open2-test \
  logs -n hermes-agent -l app.kubernetes.io/component=test --tail=-1

kind delete cluster --name my-solar-open2-test
```
