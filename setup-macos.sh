#!/bin/sh

# Set the -e option
set -e

# Function definition
backup_path() {

    if [ -d $1 ] || [ -f $1 ]; then
        local src=$1
        local count=$(ls -a $backup_folder | grep -v / | grep "$(basename $src)-*" | wc -l)
        local dest="$backup_folder/$(basename $src)-$((count))"

        echo "$src exists! Backup to $dest"
        sudo mv $src $dest
        echo "Backup completed!"
    else
        echo "$1 does not exist!"
    fi
}

# Backup folder
backup_folder=~/dotfiles-bak

if [ ! -d $backup_folder ]; then
    echo "$backup_folder does not exist! Create it!"
    mkdir -p $backup_folder
fi

backup_folder=$(realpath $backup_folder)
echo "Backup folder: $backup_folder"


echo "================================= Brew ================================="

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
export PATH=/opt/homebrew/bin:$PATH

echo "================================= Base Tools ================================="

brew install git curl tree htop

echo "================================= TMUX ================================="
# Install TMUX
brew install tmux

# Backup TMUX config
echo "Backup TMUX config"
backup_path ~/.tmux
backup_path ~/.tmux.conf

# Install TMUX Pluggin Manager
echo "Install TMUX Pluggin Manager (TPM)"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Add plugins
echo "Copy TMUX config to $HOME"
cp -r dotfiles/.tmux.conf $HOME

# Install TMUX plugins
echo "Install TMUX plugins"
~/.tmux/plugins/tpm/bin/install_plugins

echo "================================= VIM =================================="
echo "Sellect editor:"
echo "\t1. Vim"
echo "\t2. Neovim"

printf "Enter your choice: "
read editor

while [ ! $editor -eq 1 ] && [ ! $editor -eq 2 ]; do
    echo "Invalid choice!"
    printf "Enter your choice again: "
    read editor
done

if [ $editor -eq 1 ]; then

    echo "Install Vim"
    brew install vim

    # Backup Vim config
    echo "Backup Vim config"
    backup_path ~/.vim
    backup_path ~/.vimrc
    
    # Install Vim-Plug
    echo "Install Vim-Plug"
    sh -c 'curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    
    # Add plugins
    echo "Copy vim config to $HOME"
    cp -r dotfiles/.vimrc $HOME
    cp -r dotfiles/.vim $HOME/.vim
    vim +PlugInstall +qall

else

    echo "Install Neovim"
    brew install neovim

    # Backup NeoVim config
    echo "Backup NeoVim config"
    backup_path ~/.config/nvim
    
    # Add plugins
    echo "Copy vim config to $HOME"
    cp -r dotfiles/.config/nvim $HOME/.config/nvim

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
