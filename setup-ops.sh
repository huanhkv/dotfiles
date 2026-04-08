#!/bin/bash

# Setup ops/infrastructure tools: Docker, Docker Compose, Minikube, kubectl, Helm, Kustomize, Kubie
# This script detects the OS and installs tools accordingly.

set -e

# ---- Detect OS ----
detect_os() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macos"
    elif [ -f /etc/fedora-release ]; then
        echo "fedora"
    elif [ -f /etc/debian_version ]; then
        echo "debian"
    else
        echo "unknown"
    fi
}

OS=$(detect_os)
ARCH=$(uname -m)

echo "Detected OS: $OS, Arch: $ARCH"

# ---- Docker ----
setup_docker() {
    echo "================================ DOCKER ================================="

    if command -v docker &>/dev/null; then
        echo "Docker already installed: $(docker --version)"
        return
    fi

    case "$OS" in
        macos)
            brew install --cask docker
            ;;
        debian)
            sudo apt-get update
            sudo apt-get install -y ca-certificates curl gnupg
            sudo install -m 0755 -d /etc/apt/keyrings
            curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
            sudo chmod a+r /etc/apt/keyrings/docker.gpg
            echo \
                "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
                $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
                sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
            sudo apt-get update
            sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
            sudo systemctl enable docker --now
            sudo groupadd docker || true
            sudo usermod -aG docker "$USER"
            ;;
        fedora)
            sudo dnf install -y dnf-plugins-core
            sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
            sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
            sudo systemctl enable docker --now
            sudo groupadd docker || true
            sudo usermod -aG docker "$USER"
            ;;
        *)
            echo "Unsupported OS for Docker installation"
            return 1
            ;;
    esac

    echo "Docker installed: $(docker --version)"
}

# ---- Docker Compose (standalone, for non-plugin usage) ----
setup_docker_compose() {
    echo "============================ DOCKER COMPOSE ============================="

    if command -v docker-compose &>/dev/null; then
        echo "Docker Compose already installed: $(docker-compose --version)"
        return
    fi

    case "$OS" in
        macos)
            # Docker Compose is included with Docker Desktop on macOS
            echo "Docker Compose is included with Docker Desktop"
            ;;
        debian|fedora)
            # docker-compose-plugin is installed with Docker above
            # Install standalone binary as well
            COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep -Po '"tag_name": "\K[^"]*')
            sudo curl -L "https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" \
                -o /usr/local/bin/docker-compose
            sudo chmod +x /usr/local/bin/docker-compose
            echo "Docker Compose installed: $(docker-compose --version)"
            ;;
        *)
            echo "Unsupported OS for Docker Compose installation"
            return 1
            ;;
    esac
}

# ---- Minikube ----
setup_minikube() {
    echo "=============================== MINIKUBE ================================"

    if command -v minikube &>/dev/null; then
        echo "Minikube already installed: $(minikube version --short)"
        return
    fi

    case "$OS" in
        macos)
            brew install minikube
            ;;
        debian|fedora)
            curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
            sudo install minikube-linux-amd64 /usr/local/bin/minikube
            rm -f minikube-linux-amd64
            ;;
        *)
            echo "Unsupported OS for Minikube installation"
            return 1
            ;;
    esac

    echo "Minikube installed: $(minikube version --short)"
}

# ---- kubectl ----
setup_kubectl() {
    echo "=============================== KUBECTL ================================="

    if command -v kubectl &>/dev/null; then
        echo "kubectl already installed: $(kubectl version --client --short 2>/dev/null || kubectl version --client)"
        return
    fi

    case "$OS" in
        macos)
            brew install kubectl
            ;;
        debian|fedora)
            KUBECTL_VERSION=$(curl -L -s https://dl.k8s.io/release/stable.txt)
            curl -LO "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl"
            sudo install kubectl /usr/local/bin/kubectl
            rm -f kubectl
            ;;
        *)
            echo "Unsupported OS for kubectl installation"
            return 1
            ;;
    esac

    echo "kubectl installed: $(kubectl version --client 2>/dev/null)"
}

# ---- Helm ----
setup_helm() {
    echo "================================= HELM =================================="

    if command -v helm &>/dev/null; then
        echo "Helm already installed: $(helm version --short)"
        return
    fi

    case "$OS" in
        macos)
            brew install helm
            ;;
        debian|fedora)
            curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
            ;;
        *)
            echo "Unsupported OS for Helm installation"
            return 1
            ;;
    esac

    echo "Helm installed: $(helm version --short)"
}

# ---- Kustomize ----
setup_kustomize() {
    echo "============================== KUSTOMIZE ================================"

    if command -v kustomize &>/dev/null; then
        echo "Kustomize already installed: $(kustomize version)"
        return
    fi

    case "$OS" in
        macos)
            brew install kustomize
            ;;
        debian|fedora)
            curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh" | bash
            sudo install kustomize /usr/local/bin/kustomize
            rm -f kustomize
            ;;
        *)
            echo "Unsupported OS for Kustomize installation"
            return 1
            ;;
    esac

    echo "Kustomize installed: $(kustomize version)"
}

# ---- Kubie ----
setup_kubie() {
    echo "================================ KUBIE ==================================="

    if command -v kubie &>/dev/null; then
        echo "Kubie already installed: $(kubie --version)"
        return
    fi

    case "$OS" in
        macos)
            brew install kubie
            ;;
        debian|fedora)
            KUBIE_VERSION=$(curl -s https://api.github.com/repos/sbstp/kubie/releases/latest | grep -Po '"tag_name": "v\K[^"]*')
            curl -LO "https://github.com/sbstp/kubie/releases/download/v${KUBIE_VERSION}/kubie-linux-amd64"
            sudo install kubie-linux-amd64 /usr/local/bin/kubie
            rm -f kubie-linux-amd64
            ;;
        *)
            echo "Unsupported OS for Kubie installation"
            return 1
            ;;
    esac

    echo "Kubie installed: $(kubie --version)"
}

# ---- Run all ----
setup_docker
setup_docker_compose
setup_minikube
setup_kubectl
setup_helm
setup_kustomize
setup_kubie

echo "==================================== DONE ====================================="
