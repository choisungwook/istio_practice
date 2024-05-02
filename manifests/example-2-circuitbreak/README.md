# 개요
* 애플리케이션 네트워크 지연으로 발생하는 istio circuit break 실습

# 배경
* [파이썬 웹 애플리케이션](./pytnon_app/main.py)이 알수 없는 이유로 네트워크 지연이 발생하는 상황을 재현 -> sleep함수로 재현

# 테스트 방법
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
