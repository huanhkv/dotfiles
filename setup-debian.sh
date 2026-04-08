#!/bin/bash

source "$(cd "$(dirname "$0")" && pwd)/setup-common.sh"

# ---- OS-specific implementations ----
install_package() {
    sudo apt install -y "$@"
}

install_neovim() {
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
    sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
    rm -f nvim-linux-x86_64.tar.gz
    echo "alias nvim='/opt/nvim-linux-x86_64/bin/nvim'" >> "$SCRIPT_DIR/dotfiles/.config/my-alias.sh"
}

# ---- Debian-specific setup ----
echo "============================== BASE TOOLS =============================="

sudo apt -y install wget curl git fonts-powerline tree htop tldr ripgrep ncdu build-essential strace ibus-unikey xclip

setup_rust
setup_shell
setup_tmux
setup_editor

echo "============================= OTHER TOOLs =============================="

# Install Network tools
# sudo apt install -y iputils-ping net-tools traceroute telnet

# # Install lazygit: https://github.com/jesseduffield/lazygit
# LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
# curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
# tar xf lazygit.tar.gz lazygit
# rm lazygit.tar.gz
# sudo install lazygit /usr/local/bin

# # Docker
# sudo apt install -y docker.io
# sudo systemctl enable docker --now
# sudo groupadd docker
# sudo usermod -aG docker $USER
# newgrp docker
# docker ps

echo "==================================== DONE ====================================="
