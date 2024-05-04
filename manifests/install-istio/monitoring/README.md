# 개요
* istio 디버깅을 위한 모니터링 도구 설치

# 사전전비
* [istio 설치](../README.md)

# metrics server 설치

```sh
helm repo add metrics-server https://kubernetes-sigs.github.io/metrics-server/
helm repo update
helm upgrade --install -n default -f metrics-server-values.yaml metrics-server metrics-server/metrics-server
```

# prometheus 설치

* istio에서 제공하는 sample prometheus 설치

```sh
ISTIO_VERSION=1.19
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-$ISTIO_VERSION/samples/addons/prometheus.yaml
```

* 설치 확인

```sh
$ kubectl get pod -n istio-system
NAME                             READY   STATUS              RESTARTS   AGE
prometheus-db8b4588f-mtt6n       0/2     ContainerCreating   0          11s
```

# 참고자료
* https://istio.io/latest/docs/ops/integrations/prometheus/
