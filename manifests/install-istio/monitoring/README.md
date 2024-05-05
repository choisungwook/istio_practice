# 개요
* istio 디버깅을 위한 모니터링 도구 설치

# 사전전비
* [istio 설치](../README.md)

# metrics server 설치

```sh
helm repo add metrics-server https://kubernetes-sigs.github.io/metrics-server/
helm repo update
helm upgrade --install -n kube-system -f metrics-server-values.yaml metrics-server metrics-server/metrics-server
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

* 프로메테우스 접속 방법

```sh
kubectl port-forward service/prometheus -n istio-system 9090:9090
```

# kiali

* istio에서 제공하는 sample kiali 설치

```sh
ISTIO_VERSION=1.19
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-$ISTIO_VERSION/samples/addons/kiali.yaml
```

* 설치 확인

```sh
$ kubectl get pods -n istio-system
NAME                             READY   STATUS    RESTARTS   AGE
kiali-58d8c9c978-rlqvh           0/1     Running   0          24s
```

* kiali 접속 방법

```sh
kubectl port-forward service/kiali -n istio-system 20001:20001
```

# jager 설치

* istio에서 제공하는 sample jager 설치

```sh
ISTIO_VERSION=1.19
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-$ISTIO_VERSION/samples/addons/jaeger.yaml
```

* 설치 확인

```sh
$ kubectl -n istio-system get pod
NAME                             READY   STATUS              RESTARTS   AGE
jaeger-7d7d59b9d-7d7kk           0/1     ContainerCreating   0          7s
```


# 참고자료
* https://istio.io/latest/docs/ops/integrations/prometheus/
