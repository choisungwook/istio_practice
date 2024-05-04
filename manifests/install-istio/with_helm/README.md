# 개요
* helm chart를 사용하여 istio 설치 방법 정리

# 1. helm chart 추가

```bash
helm repo add istio https://istio-release.storage.googleapis.com/charts
helm repo update
```

# 2. istio-system namespace 생성

```bash
kubectl create ns istio-system
```

# 3. helm chart 릴리즈
## 3.1 주의사항
* base -> istiod -> gateway 순서로 helm chart 릴리즈
* 각 chart 버전은 동일해야 함

## 3.2 base
```bash
CHART_VERSION="1.19.3"
helm upgrade --install istio-base istio/base \
  --version $CHART_VERSION \
  --namespace istio-system \
  --set defaultRevision=default \
  --wait
```

## 3.3 istiod chart 릴리즈
```bash
CHART_VERSION="1.19.3"
helm upgrade --install istiod istio/istiod \
  --version $CHART_VERSION \
  --namespace istio-system \
  -f istiod-values.yaml \
  --wait
```

## 3.4 gateway chart 릴리즈
```bash
CHART_VERSION="1.19.3"
helm upgrade --install istio-ingress istio/gateway \
  --version $CHART_VERSION \
  --namespace istio-system \
  -f istio-ingress-gateway.yaml \
  --wait
```

# 4. 삭제 방법
* gateway -> istiod -> base순서로 삭제

```bash
helm uninstall -n istio-system istio-ingress --wait
helm uninstall -n istio-system istiod --wait
helm uninstall -n istio-system istio-base --wait
```

# 5. 다음 단계

* [모니터링 도구 설치](../monitoring)

# 참고자료
* istio 공식문서: https://istio.io/latest/docs/setup/install/helm/
