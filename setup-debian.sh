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

sudo apt -y install wget curl git fonts-powerline tree htop ripgrep ncdu build-essential strace ibus-unikey xclip

echo "================================= Terminal ================================="
echo "Select Terminal:"
printf "\t1. WezTerm\n"
printf "\t2. Ghostty\n"
printf "\t3. Skip\n"

printf "Enter your choice: "
read -r terminal

while [ "$terminal" != "1" ] && [ "$terminal" != "2" ] && [ "$terminal" != "3" ]; do
    echo "Invalid choice!"
    printf "Enter your choice again: "
    read -r terminal
done

if [ "$terminal" = "1" ]; then
    echo "Install WezTerm"
    terminal="WezTerm"
elif [ "$terminal" = "2" ]; then
    echo "Install Ghostty"
    terminal="Ghostty"
fi

if [ "$terminal" != "3" ]; then
    terminal_lower=$(echo "$terminal" | tr '[:upper:]' '[:lower:]')

    echo "Backup $terminal config"
    backup_path "$HOME/.config/$terminal_lower" "$backup_folder"

    echo "Copy $terminal config from $SCRIPT_DIR/dotfiles/.config/$terminal_lower to $HOME/.config/$terminal_lower"
    ln -s "$SCRIPT_DIR/dotfiles/.config/$terminal_lower" "$HOME/.config/$terminal_lower"
else
    echo "Skip install terminal"
fi

setup_shell
setup_rust
setup_tmux
setup_editor

echo "============================= OTHER TOOLs =============================="

# # Install Network tools
# sudo apt install -y iputils-ping net-tools traceroute telnet
#
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
