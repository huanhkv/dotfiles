#!/bin/sh

# Set the -e option
set -e

# Function definition
backup_path() {

    # Get parameters
    src="$1"
    backup_folder="$2"

    if [ -d "$src" ] || [ -f "$src" ]; then

        count=$(find "$backup_folder" -maxdepth 1 -name "$(basename "$src")-*" | wc -l)
        dest="$backup_folder/$(basename "$src")-$((count))"

        echo "$src exists! Backup to $dest"
        if [ -L "$src" ]; then
            echo "$src is a symlink"
            sudo ln -s "$(readlink "$src")" "$dest"
            sudo rm -rf "$src"
        else
            echo "$src is NOT a symlink"
            sudo mv "$src" "$dest"
        fi
        echo "Backup completed!"
    else
        echo "$src does not exist!"
    fi
}

# Backup folder
backup_folder=$HOME/dotfiles-bak

if [ ! -d "$backup_folder" ]; then
    echo "$backup_folder does not exist! Create it!"
    mkdir -p "$backup_folder"
fi

backup_folder=$(realpath "$backup_folder")
echo "Backup folder: $backup_folder"

# Config folder
if [ ! -d "$HOME/.config" ]; then
    echo "$HOME/.config does not exist! Create it!"
    mkdir -p "$HOME/.config"
fi

echo "============================== BASE TOOLS =============================="

sudo apt -y install wget curl git fonts-powerline tree htop tldr ripgrep ncdu build-essential strace ibus-unikey xclip

# curl https://sh.rustup.rs -sSf | sh
export PATH=$PATH:$HOME/.cargo/bin
cargo install eza fd-find
cargo install --locked bat navi

echo "================================ SHELL ================================="

# Get Alias
backup_path "$HOME/.config/my-alias.sh" "$backup_folder"

# Select shell
echo "Sellect Shell:"
printf "\t1. Zsh\n"
printf "\t2. Bash\n"
printf "\t3. Fish\n"

printf "Enter your choice: "
read -r shell

while [ ! "$shell" -eq 1 ] && [ ! "$shell" -eq 2 ] && [ ! "$shell" -eq 3 ]; do
    echo "Invalid choice!"
    printf "Enter your choice again: "
    read -r shell
done

# Install shell
if [ "$shell" -eq 1 ]; then
    echo "Install ZSH"
    # sudo apt -y install zsh
    # echo $(zsh --version)


    # Backup ZSH config
    echo "Backup ZSH config"
    backup_path "$HOME/.zshrc" "$backup_folder"

    # Install Oh My Zsh

    # Add alias
    echo "source $(realpath dotfiles/.config/my-alias.sh)" >> "$HOME/.zshrc"

elif [ "$shell" -eq 2 ]; then
    echo "Install Bash"

    # Backup Bash config
    echo "Backup Bash config"
    backup_path "$HOME/.bashrc" "$backup_folder"

    # Install Oh My Bash
        bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"

    # Add alias
    echo "source $(realpath dotfiles/.config/my-alias.sh)" >> "$HOME/.bashrc"

else
    echo "Install Fish shell"

    # Add alias
fi

echo "================================= TMUX ================================="
# Install TMUX
sudo apt install -y tmux

# Backup TMUX config
echo "Backup TMUX config"
backup_path "$HOME/.tmux" "$backup_folder"
backup_path "$HOME/.tmux.conf" "$backup_folder"

# Install TMUX Pluggin Manager
echo "Install TMUX Pluggin Manager (TPM)"
git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"

# Add plugins
echo "Copy TMUX config from $(realpath dotfiles/.tmux.conf) to $HOME"
ln -s "$(realpath dotfiles/.tmux.conf)" "$HOME/.tmux.conf"

# Install TMUX plugins
echo "Install TMUX plugins"
"$HOME/.tmux/plugins/tpm/bin/install_plugins"

echo "================================= VIM =================================="
# Install Vim
echo "Sellect editor:"
printf "\t1. Vim\n"
printf "\t2. Neovim\n"

printf "Enter your choice: "
read -r editor

while [ ! "$editor" -eq 1 ] && [ ! "$editor" -eq 2 ]; do
    echo "Invalid choice!"
    printf "Enter your choice again: "
    read -r editor
done

if [ "$editor" -eq 1 ]; then

    echo "Install Vim"
    sudo apt install -y vim

    # Backup Vim config
    echo "Backup Vim config"
    backup_path "$HOME/.vim" "$backup_folder"
    backup_path "$HOME/.vimrc" "$backup_folder"

    # Install Vim-Plug
    echo "Install Vim-Plug"
    sh -c 'curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

    # Add plugins
    echo "Copy vim config to $HOME"
    ln -s "dotfiles/.vimrc" "$HOME"
    ln -s "dotfiles/.vim" "$HOME/.vim"
    vim +PlugInstall +qall

else

    echo "Install Neovim"
    cd ..
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
    sudo tar -xzf nvim-linux-x86_64.tar.gz
    echo "alias nvim='$(realpath nvim-linux-x86_64)/bin/nvim'" >> dotfiles/dotfiles/.config/my-alias.sh
    cd dotfiles

    # Backup NeoVim config
    echo "Backup NeoVim config"
    backup_path "$HOME/.config/nvim" "$backup_folder"

    # Add plugins
    echo "Copy vim config from $(realpath dotfiles/.config/nvim) to $HOME"
    ln -s "$(realpath dotfiles/.config/nvim)" "$HOME/.config/nvim"
fi

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
