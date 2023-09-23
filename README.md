# 1. 개요
* istio 공부내용 정리

# 2. 환경구축
## 2.1 전제조건
* docker(또는 rancher desktop)가 설치되어 있어야 함 -> kind cluster 구축할 때 docker 사용

## 2.2 환경 생성
* makefile 스크립트를 이용해서 환경 생성 자동화
  * 스크립트 실행 내용: kind 명령어 설치 -> kind cluster 생성 -> istioctl
```bash
make install

# istioctl 명령어 경로를 환경변수로 설정
export PATH="$PATH:/root/git/istio_practice/istio-1.19.0/bin"

# istioctl 명령어 실행 확인
istioctl x precheck
```

![](./imgs/install_istio.png)

## 2.3 환경 삭제
* makefile 스크립트를 이용해서 환경 삭제
  * 스크립트 실행내용: kind cluster 삭제
```bash
make delete
```

# 3. istio 컴퍼넌트 설치
* istioctl로 컴퍼넌트 설치
```bash
istioctl install --set profile=demo -y
```

* default namespace에 istio inject 설정
```bash
kubectl label namespace default istio-injection=enabled
```

* istio-ingress gateway service port를 kind cluster환경에 맞게 변경
```bash
kubectl patch deployments.apps -n istio-system istio-ingressgateway -p '{"spec":{"template":{"spec":{"containers":[{"name":"istio-proxy","ports":[{"containerPort":8080,"hostPort":80},{"containerPort":8443,"hostPort":443}]}]}}}}'
```


# 참고자료
* kind cluster에서 istio 설치: https://medium.com/@s4l1h/how-to-install-kind-and-istio-ingress-controller-3b510834c762
