#!/bin/bash

# Common functions and setup shared across all OS setup scripts.
# This file should be sourced, not executed directly.
# Each OS script must define install_package() and install_neovim() before calling shared functions.

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ---- Backup helper ----
backup_path() {
    src="$1"
    bak="$2"

    if [ -d "$src" ] || [ -f "$src" ]; then
        count=$(find "$bak" -maxdepth 1 -name "$(basename "$src")-*" | wc -l)
        dest="$bak/$(basename "$src")-$((count))"

        echo "$src exists! Backup to $dest"
        if [ -L "$src" ]; then
            echo "$src is a symlink"
            ln -s "$(readlink "$src")" "$dest"
            rm -rf "$src"
        else
            echo "$src is NOT a symlink"
            mv "$src" "$dest"
        fi
        echo "Backup completed!"
    else
        echo "$src does not exist!"
    fi
}

# ---- Init backup & config folders ----
backup_folder=$HOME/dotfiles-bak

if [ ! -d "$backup_folder" ]; then
    echo "$backup_folder does not exist! Create it!"
    mkdir -p "$backup_folder"
fi

backup_folder=$(realpath "$backup_folder")
echo "Backup folder: $backup_folder"

if [ ! -d "$HOME/.config" ]; then
    echo "$HOME/.config does not exist! Create it!"
    mkdir -p "$HOME/.config"
fi

# ---- Rust ----
setup_rust() {
    echo "================================ RUST ================================="
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    export PATH=$PATH:$HOME/.cargo/bin
    cargo install eza fd-find
    cargo install --locked bat navi
}

# ---- Shell ----
setup_shell() {
    echo "================================ SHELL ================================="

    backup_path "$HOME/.config/my-alias.sh" "$backup_folder"
    ln -s "$SCRIPT_DIR/dotfiles/.config/my-alias.sh" "$HOME/.config/my-alias.sh"

    echo "Select Shell:"
    printf "\t1. Zsh\n"
    printf "\t2. Bash\n"
    printf "\t3. Fish\n"

    printf "Enter your choice: "
    read -r shell

    while [ "$shell" != "1" ] && [ "$shell" != "2" ] && [ "$shell" != "3" ]; do
        echo "Invalid choice!"
        printf "Enter your choice again: "
        read -r shell
    done

    if [ "$shell" = "1" ]; then
        echo "Install ZSH"
        install_package zsh
        zsh --version

        echo "Backup ZSH config"
        backup_path "$HOME/.zshrc" "$backup_folder"

        # Install Oh My Zsh

        echo "source $HOME/.config/my-alias.sh" >> "$HOME/.zshrc"

    elif [ "$shell" = "2" ]; then
        echo "Install Bash"

        echo "Backup Bash config"
        backup_path "$HOME/.bashrc" "$backup_folder"

        # Install Oh My Bash
        bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"

        echo "source $HOME/.config/my-alias.sh" >> "$HOME/.bashrc"

    else
        echo "Install Fish shell"

        # Add alias
    fi
}

# ---- TMUX ----
setup_tmux() {
    echo "================================= TMUX ================================="

    install_package tmux

    echo "Backup TMUX config"
    backup_path "$HOME/.tmux" "$backup_folder"
    backup_path "$HOME/.tmux.conf" "$backup_folder"

    echo "Install TMUX Plugin Manager (TPM)"
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"

    echo "Copy TMUX config from $SCRIPT_DIR/dotfiles/.tmux.conf to $HOME"
    ln -s "$SCRIPT_DIR/dotfiles/.tmux.conf" "$HOME/.tmux.conf"

    echo "Install TMUX plugins"
    "$HOME/.tmux/plugins/tpm/bin/install_plugins"
}

# ---- Editor (Vim / Neovim) ----
setup_editor() {
    echo "================================= VIM =================================="
    echo "Select editor:"
    printf "\t1. Vim\n"
    printf "\t2. Neovim\n"

    printf "Enter your choice: "
    read -r editor

    while [ "$editor" != "1" ] && [ "$editor" != "2" ]; do
        echo "Invalid choice!"
        printf "Enter your choice again: "
        read -r editor
    done

    if [ "$editor" = "1" ]; then
        echo "Install Vim"
        install_package vim

        echo "Backup Vim config"
        backup_path "$HOME/.vim" "$backup_folder"
        backup_path "$HOME/.vimrc" "$backup_folder"

        echo "Install Vim-Plug"
        curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

        echo "Copy vim config to $HOME"
        ln -s "$SCRIPT_DIR/dotfiles/.vimrc" "$HOME/.vimrc"
        ln -s "$SCRIPT_DIR/dotfiles/.vim" "$HOME/.vim"
        vim +PlugInstall +qall

    else
        echo "Install Neovim"
        install_neovim

        echo "Backup NeoVim config"
        backup_path "$HOME/.config/nvim" "$backup_folder"

        echo "Copy nvim config from $SCRIPT_DIR/dotfiles/.config/nvim to $HOME/.config/nvim"
        ln -s "$SCRIPT_DIR/dotfiles/.config/nvim" "$HOME/.config/nvim"
    fi
}
