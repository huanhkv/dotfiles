#!/bin/sh

# Set the -e option
set -e

echo "============================== BASE TOOLS =============================="
sudo apt -y install curl git fonts-powerline

echo "================================ SHELL ================================="
sudo apt -y install zsh
echo $(zsh --version)

# Check default shell
if [ ! "$SHELL" = *"zsh"* ];
then
    echo "$SHELL is default shell. Set zsh is default shell..."
    chsh -s $(which zsh)
    echo "Now $SHELL is default shell."
else
    echo "Zsh is default shell"
fi

# Oh my ZSH
OH_MY_ZSH_DIR="$HOME/.oh-my-zsh"
if [ -d "$OH_MY_ZSH_DIR" ]; 
then
    echo "$OH_MY_ZSH_DIR is existed. You'll need to remove it if you want to reinstall oh-my-zsh."
else
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

echo "================================= TMUX ================================="
sudo apt install -y tmux

# Install Tmux Theme
TMUX_POWER_THEME="$HOME/.config/tmux/tmux-power"
if [ -d "$TMUX_POWER_THEME" ];
then
    echo "$TMUX_POWER_THEME is existed."
else
    git clone https://github.com/wfxr/tmux-power.git $TMUX_POWER_THEME
    echo 'run-shell "$HOME/.config/tmux/tmux-power/tmux-power.tmux"' >> $HOME/.tmux.conf
fi

echo "================================= VIM =================================="
# Install NeoVim
sudo apt install -y neovim xclip

# Install Vim-Plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Add plugins
echo "Copy Neovim config to $HOME/.config/nvim"
cp -r dotfiles/nvim $HOME/.config/nvim

echo "============================= OTHER TOOLs =============================="
 
sudo apt install -y ibus-unikey 

echo "Install Dev tools"
sudo apt install -y tree htop

# Install lazygit: https://github.com/jesseduffield/lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
rm lazygit.tar.gz
sudo install lazygit /usr/local/bin

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
echo "|| You need to run below command to update all plugins installed before use NeoVim||"
echo "||                                                                                ||"
echo "||        nvim +PlugInstall                                                       ||"
echo "||                                                                                ||"
echo "==================================== LAST NOTE ====================================="
