install: install-kind-command create-kind-cluster install-istioctl
delete:
	@cd kind_cluster && kind delete cluster --name istio-practice

install-kind-command:
ifeq (,$(shell which kind))
ifeq ($(shell uname -s),Darwin)
	$(call install_kind_macos)
else
	$(call install_kind_linux)
endif
endif

create-kind-cluster:
	@echo "[*] kind cluster를 생성 중입니다..."
	@cd kind_cluster; kind create cluster --config config.yaml
	@echo "[*] kind cluster 설치가 완료되었습니다."

install-istioctl:
	@curl -sL https://istio.io/downloadIstio | sh -

define install_kind_linux
	@echo "[*] kind 명령어를 설치 중입니다..."
	@curl -Lo ./kind -sLo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-linux-amd64
	@chmod +x ./kind
	@sudo mv ./kind /usr/local/bin/
	@echo "[*] kind 명령어 설치가 완료되었습니다."
endef

define install_kind_macos
	@echo "[*] kind 명령어를 설치 중입니다..."
	@brew install kind
	@echo "[*] kind 명렁어 설치가 완료되었습니다."
endef
