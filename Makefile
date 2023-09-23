up:
	cd kind_cluster; kind create cluster --config config.yaml
down:
	cd kind_cluster; kind delete cluster --name istio-practice
