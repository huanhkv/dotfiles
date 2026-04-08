#!/bin/bash

source "$(cd "$(dirname "$0")" && pwd)/setup-common.sh"

# ---- OS-specific implementations ----
install_package() {
    sudo dnf install -y "$@"
}

install_neovim() {
    sudo dnf install -y neovim
}

# ---- Fedora-specific setup ----
echo "============================== BASE TOOLS =============================="

sudo dnf -y install wget curl git powerline-fonts tree htop tldr ripgrep ncdu gcc gcc-c++ make strace ibus-unikey xclip

setup_rust
setup_shell
setup_tmux
setup_editor

echo "============================= OTHER TOOLs =============================="

# Install Network tools
# sudo dnf install -y iputils net-tools traceroute telnet

# # Install lazygit: https://github.com/jesseduffield/lazygit
# sudo dnf copr enable atim/lazygit -y
# sudo dnf install -y lazygit

# # Docker
# sudo dnf install -y dnf-plugins-core
# sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
# sudo dnf install -y docker-ce docker-ce-cli containerd.io
# sudo systemctl enable docker --now
# sudo groupadd docker
# sudo usermod -aG docker $USER
# newgrp docker
# docker ps

echo "==================================== DONE ====================================="
