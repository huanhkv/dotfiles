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


# echo "================================= Brew ================================="
# 
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# export PATH=/opt/homebrew/bin:$PATH
# 
# echo "================================= Base Tools ================================="
# 
# brew install git curl tree htop
# 
echo "================================= TMUX ================================="
# # Install TMUX
# brew install tmux

# Backup TMUX config
echo "Backup TMUX config"
backup_path "$HOME/.tmux" "$backup_folder"
backup_path "$HOME/.tmux.conf" "$backup_folder"

# Install TMUX Pluggin Manager
echo "Install TMUX Pluggin Manager (TPM)"
git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"

# Add plugins
echo "Copy TMUX config to $HOME"
ln -s "$(realpath dotfiles/.tmux.conf)" "$HOME"

# Install TMUX plugins
echo "Install TMUX plugins"
"$HOME/.tmux/plugins/tpm/bin/install_plugins"

echo "================================= VIM =================================="
echo "Sellect editor:"
printf "\t1. Vim\n"
printf "\t2. Neovim"

echo "Enter your choice: "
read -r editor

while [ ! "$editor" -eq 1 ] && [ ! "$editor" -eq 2 ]; do
    echo "Invalid choice!"
    printf "Enter your choice again: "
    read -r editor
done

if [ "$editor" -eq 1 ]; then

    echo "Install Vim"
    # brew install vim

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
    # brew install neovim

    # Backup NeoVim config
    echo "Backup NeoVim config"
    backup_path "$HOME/.config/nvim" "$backup_folder"
    
    # Add plugins
    echo "Copy vim config to $HOME"
    ln -s "$(realpath dotfiles/.config/nvim)" "$HOME/.config/nvim"

fi

echo "============================= OTHER TOOLs =============================="

# # Docker
# sudo apt install -y docker.io
# sudo systemctl enable docker --now
# sudo groupadd docker
# sudo usermod -aG docker $USER
# newgrp docker
# docker ps

echo "==================================== DONE ====================================="
