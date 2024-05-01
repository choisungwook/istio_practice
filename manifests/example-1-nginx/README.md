# 개요
* nginx pod와 istio 설정

# 준비

* /etc/hosts파일에서 nginx pod를 호출할 도메인을 설정

```sh
127.0.0.1    example1.com
```

# 실행방법

* manifest 배포

```sh
kubectl apply -f ./
```

* gateway, virtualservice 확인

```sh
kubectl get gw,vw
```

* nginx pod호출

```sh
curl example1.com
```
