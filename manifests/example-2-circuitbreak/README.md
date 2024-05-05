# 개요
* 애플리케이션 네트워크 지연으로 발생하는 istio circuit break 실습

# 배경
* [파이썬 웹 애플리케이션](./pytnon_app/main.py)이 알수 없는 이유로 네트워크 지연이 발생하는 상황을 재현 -> sleep함수로 재현

# 외부에서 부하를 줘서 테스트 하는 방법
1. 파이썬 웹 애플리케이션 pod 배포

```sh
kubectl apply -f ./target.yaml
```

2. istio gateway, virtualservice 배포

```sh
kubectl apply -f ./istio_config.yaml
```

3. locust로 부하테스트 진행

```sh
cd python_locust
locust -f main.py
```

4. istio circuit break 설정

```sh
kubectl apply -f ./circuitbreak_rule
```

# pod에서 Pod호출하는 방법으로 테스트 방법

* fortio 부하 테스트 pod 생성

```sh
kubectl apply -f samples/httpbin/sample-client/fortio-deploy.yaml
```

* 부하 테스트 방법

```sh
FORTIO_POD=$(kubectl get pods -l app=fortio -o 'jsonpath={.items[0].metadata.name}')
# connections (-c) and send requests (-n):
kubectl exec "$FORTIO_POD" -c fortio -- /usr/bin/fortio load -c 200 -qps 0 -n 200 http://circuit-break-example:80/sleep
```
