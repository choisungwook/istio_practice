# 개요
* istio 실습 예제

# 실습 준비

* default namespace에 istio inject 설정
```bash
kubectl label namespace default istio-injection=enabled
```

# istio 공식샘플 배포

* 샘플 애플리케이션 배포
```bash
# istioctl github repo로 이동
# istioctl 설치과정에서 istio github을 자동으로 다운로드 함
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
