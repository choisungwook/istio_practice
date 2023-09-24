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
make uninstall
```

# 3. istio 컴퍼넌트 설치
* istioctl로 컴퍼넌트 설치
```bash
istioctl install --set profile=demo -f manifests/istio-config.yaml -y
kubectl -n istio-system get po,svc
```

* default namespace에 istio inject 설정
```bash
kubectl label namespace default istio-injection=enabled
```

# 4. istio 샘플 애플리케이션 배포
```bash
cd istio-x.x.x

# 애플리케이션 배포
kubectl apply -f samples/bookinfo/platform/kube/bookinfo.yaml

# gateway 설정 배포
kubectl apply -f samples/bookinfo/networking/bookinfo-gateway.yaml

# 접속
# reference: https://istio.io/latest/docs/tasks/traffic-management/ingress/ingress-control/#using-node-ports-of-the-ingress-gateway-service
export GATEWAY_URL="127.0.0.1:80"
curl -s "http://${GATEWAY_URL}/productpage" | grep -o "<title>.*</title>"
```

![](./imgs/istio_application_curl.png)

# 5. 모니터링
* istio addons를 설치하여 메트릭 등을 모니터링

```bash
cd istio-x.x.x
kubectl apply -f samples/addons/
```

# 참고자료
* kind cluster에서 istio 설치: https://medium.com/@s4l1h/how-to-install-kind-and-istio-ingress-controller-3b510834c762
* istio nodeport: https://github.com/kubernetes-sigs/kind/issues/2374
* istio nodeport: https://itnp.kr/post/install-istio
