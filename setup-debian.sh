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


echo "============================== BASE TOOLS =============================="

sudo apt -y install curl git fonts-powerline tree htop
sudo apt install -y ibus-unikey

# echo "================================ SHELL ================================="
# sudo apt -y install zsh
# echo $(zsh --version)
# 
# # Check default shell
# if [ ! "$SHELL" = *"zsh"* ];
# then
#     echo "$SHELL is default shell. Set zsh is default shell..."
#     chsh -s $(which zsh)
#     echo "Now $SHELL is default shell."
# else
#     echo "Zsh is default shell"
# fi
# 
# # Oh my ZSH
# OH_MY_ZSH_DIR="$HOME/.oh-my-zsh"
# if [ -d "$OH_MY_ZSH_DIR" ]; 
# then
#     echo "$OH_MY_ZSH_DIR is existed. You'll need to remove it if you want to reinstall oh-my-zsh."
# else
#     sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# fi

echo "================================= TMUX ================================="
# Install TMUX
sudo apt install -y tmux

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
# Install Vim
sudo apt install -y xclip

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
    sudo apt install -y vim

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
    cp -r dotfiles/.vimrc ~/
    cp -r dotfiles/.vim ~/.vim
    vim +PlugInstall +qall

else

    echo "Install Neovim"
    # sudo apt install -y neovim

    # Backup NeoVim config
    echo "Backup NeoVim config"
    backup_path ~/.config/nvim

    # Add plugins
    echo "Copy vim config to $HOME"
    cp -r dotfiles/.config/nvim ~/.config/nvim
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
