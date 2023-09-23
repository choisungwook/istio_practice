# 개요
* istio 공부

# 환경구축
* 쿠버네티스는 kind cluster 사용
* kind cluster 생성 방법
```bash
make up
```

* kind cluster 삭제 방법
```bash
make down
```

# istioctl 설치
* istioctl 설치
```bash
# 다운로드
curl -L https://istio.io/downloadIstio | sh -

# istioctl 바이너리를 path경로로 복사
udo cp ./istio-1.19.0/bin/istioctl /usr/local/bin

# 설치 확인
istioctl x precheck
```

# istio 컴퍼넌트 설치
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
