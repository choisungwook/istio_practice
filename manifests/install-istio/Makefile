CHART_VERSION = "1.19.3"

helm-install:
	@-kubectl create ns istio-system
	@helm repo add istio https://istio-release.storage.googleapis.com/charts
	@helm repo update
	@echo "[Info] helm install istio-base"
	@helm upgrade --install istio-base istio/base --namespace istio-system --version ${CHART_VERSION} --set defaultRevision=default --wait
	@echo "[Info] helm install istiod"
	@helm upgrade --install istiod istio/istiod --namespace istio-system --version ${CHART_VERSION} -f istiod-values.yaml --wait
	@echo "[Info] helm install istio-ingress"
	@helm upgrade --install istio-ingress istio/gateway --namespace istio-system --version ${CHART_VERSION} -f istio-ingress-gateway.yaml --wait

helm-uninstall:
	@helm uninstall -n istio-system istio-ingress --wait
	@helm uninstall -n istio-system istiod --wait
	@helm uninstall -n istio-system istio-base --wait
	@kubectl get crd -oname | grep --color=never 'istio.io' | xargs kubectl delete
