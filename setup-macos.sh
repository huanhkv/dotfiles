#!/bin/bash

source "$(cd "$(dirname "$0")" && pwd)/setup-common.sh"

# ---- OS-specific implementations ----
install_package() {
    brew install "$@"
}

install_neovim() {
    brew install neovim
}

# ---- macOS-specific setup ----
echo "================================= Brew ================================="

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
export PATH=/opt/homebrew/bin:$PATH

echo "============================== BASE TOOLS =============================="

brew install git curl tree htop

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

setup_rust
setup_shell
setup_tmux
setup_editor

echo "============================= OTHER TOOLs =============================="

echo "Install Window manager tools"
brew install --cask nikitabobko/tap/aerospace
curl -L https://raw.githubusercontent.com/FelixKratz/dotfiles/master/install_sketchybar.sh | sh
brew install borders

backup_path "$HOME/.aerospace.toml" "$backup_folder"
backup_path "$HOME/.config/borders" "$backup_folder"
backup_path "$HOME/.config/sketchybar" "$backup_folder"

ln -s "$SCRIPT_DIR/dotfiles/.aerospace.toml" "$HOME/.aerospace.toml"
ln -s "$SCRIPT_DIR/dotfiles/.config/sketchybar" "$HOME/.config/sketchybar"
ln -s "$SCRIPT_DIR/dotfiles/.config/borders" "$HOME/.config/borders"

# # Docker
# sudo apt install -y docker.io
# sudo systemctl enable docker --now
# sudo groupadd docker
# sudo usermod -aG docker $USER
# newgrp docker
# docker ps

echo "==================================== DONE ====================================="
