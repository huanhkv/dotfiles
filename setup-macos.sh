#!/bin/sh

# Set the -e option
set -e

echo "================================= Brew ================================="

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
export PATH=/opt/homebrew/bin:$PATH

echo "================================= TMUX ================================="
# Install TMUX
brew install tmux git

# Install TMUX Pluggin Manager
if [ -d ~/.tmux/plugins/tpm ];
then
       if [ -d ~/.tmux/plugins/tpm-bak ];
       then
               rm -rf ~/.tmux/plugins/tpm-bak
       fi
       mv ~/.tmux/plugins/tpm ~/.tmux/plugins/tpm-bak
fi

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Add plugins
echo "Copy TMUX config to $HOME"
cp -r dotfiles/.tmux.conf $HOME

echo "================================= VIM =================================="
# Install Vim
brew install vim

# Install Vim-Plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Add plugins
echo "Copy vim config to $HOME/.config/vim"
cp -r dotfiles/.vimrc $HOME
cp -r dotfiles/.vim $HOME/.vim

echo "============================= OTHER TOOLs =============================="

# # Docker
# sudo apt install -y docker.io
# sudo systemctl enable docker --now
# sudo groupadd docker
# sudo usermod -aG docker $USER
# newgrp docker
# docker ps

echo "==================================== LAST NOTE ====================================="
echo "|| Enviroment setup is Done.                                                      ||"
echo "||                                                                                ||"
echo "|| You need to run below command to update all plugins installed before use TMUX  ||"
echo "||                                                                                ||"
echo "||        Open TMUX -> prefix + I                                                 ||"
echo "||                                                                                ||"
echo "|| You need to run below command to update all plugins installed before use Vim   ||"
echo "||                                                                                ||"
echo "||        Open Vim -> :PlugInstall                                                ||"
echo "==================================== LAST NOTE ====================================="
