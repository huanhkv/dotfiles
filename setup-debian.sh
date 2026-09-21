#!/bin/bash

source "$(cd "$(dirname "$0")" && pwd)/setup-common.sh"

# ---- OS-specific implementations ----
install_package() {
    sudo apt install "$@"
}

install_neovim() {
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
    sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
    rm -f nvim-linux-x86_64.tar.gz
    echo "alias nvim='/opt/nvim-linux-x86_64/bin/nvim'" >> "$SCRIPT_DIR/dotfiles/.config/my-alias.sh"
}

ensure_file() {
    file="$1"
    if [ ! -f "$file" ]; then
        echo "Creating $file"
        touch "$file"
    fi
}

append_once() {
    line="$1"
    file="$2"
    grep -qxF "$line" "$file" || echo "$line" >> "$file"
}

echo "============================== BASE TOOLS =============================="

sudo apt update

# ---------- Common: CLI utilities ----------
sudo apt install wget curl git tree htop ripgrep build-essential strace ncdu smartmontools xclip

# ---------- Common: Audio (PipeWire handles Bluetooth audio too) ----------
sudo apt install pipewire pipewire-pulse libspa-0.2-bluetooth wireplumber
sudo apt install pulseaudio-utils pavucontrol brightnessctl mpv
# sudo apt install -y pulseaudio-module-bluetooth

# ---------- Common: Bluetooth daemon, networking, misc ----------
sudo apt install bluez network-manager  # networkd-dispatcher
sudo apt install fonts-powerline ibus-unikey ntfs-3g snapd

echo "================================= DESKTOP ================================="
echo "Select Desktop GUI:"
printf "\t1. i3\n"
printf "\t2. GNOME\n"
printf "\t3. Skip\n"

printf "Enter your choice: "
read -r DESKTOP

while [ "$DESKTOP" != "1" ] && [ "$DESKTOP" != "2" ] && [ "$DESKTOP" != "3" ]; do
    echo "Invalid choice!"
    printf "Enter your choice again: "
    read -r DESKTOP
done

case "$DESKTOP" in
  1)
    sudo apt install xserver-xorg-input-libinput xkb-data
    sudo apt install xinit  # xterm
    sudo apt install i3 i3blocks maim
    # sudo apt install i3status i3lock i3-wn dmenu nitrogen suckless-tools volumeicon blueman
    ;;
  2)
    sudo apt install task-gnome-desktop gnome-control-center network-manager-gnome gdm3
    # sudo apt install gnome-shell gnome-bluetooth ubuntu-desktop
    ;;
  3)
    echo "Skipping desktop GUI installation."
    ;;
esac

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

# Install Network tools
sudo apt install iputils-ping net-tools traceroute telnet

# # Install lazygit: https://github.com/jesseduffield/lazygit
# LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
# curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
# tar xf lazygit.tar.gz lazygit
# rm lazygit.tar.gz
# sudo install lazygit /usr/local/bin

# # Docker
# sudo apt install docker.io
# sudo systemctl enable docker --now
# sudo groupadd docker
# sudo usermod -aG docker $USER
# newgrp docker
# docker ps

echo "==================================== DONE ====================================="
