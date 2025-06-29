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
echo "================================= Terminal ================================="
echo "Sellect Terminal:"
printf "\t1. WezTerm\n"
printf "\t2. Ghostty\n"

printf "Enter your choice: "
read -r terminal

while [ ! "$terminal" -eq 1 ] && [ ! "$terminal" -eq 2 ]; do
    echo "Invalid choice!"
    printf "Enter your choice again: "
    read -r terminal
done

# Install
if [ "$terminal" -eq 1 ]; then
    echo "Install WezTerm"
    terminal="WezTerm"
elif [ "$terminal" -eq 2 ]; then
    echo "Install Ghostty"
    terminal="Ghostty"
fi
terminal_lower=$(echo "$terminal" | tr '[:upper:]' '[:lower:]')

# Backup Terminal config
echo "Backup $terminal config"
backup_path "$HOME/.config/$terminal_lower" "$backup_folder"

# Add Terminal config
echo "Copy $terminal config from $(realpath "dotfiles/.config/$terminal_lower") to $HOME/.config/$terminal_lower"
ln -s "$(realpath "dotfiles/.config/$terminal_lower")" "$HOME/.config/$terminal_lower"

echo "================================= Shell ================================="

# Get Alias
backup_path "$HOME/.config/my-alias.sh" "$backup_folder"
ln -s "$(realpath dotfiles/.config/my-alias.sh)" "$HOME/.config/my-alias.sh"

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
    # brew install zsh

    # Backup ZSH config
    echo "Backup ZSH config"
    backup_path "$HOME/.zshrc" "$backup_folder"

    # Install Oh My Zsh
    
    # Add alias
    echo "source $HOME/.config/my-alias.sh" >> "$HOME/.zshrc"

elif [ "$shell" -eq 2 ]; then
    echo "Install Bash"

    # Backup Bash config
    echo "Backup Bash config"
    backup_path "$HOME/.bashrc" "$backup_folder"

    # Add plugins

    # Add alias
    echo "source $HOME/.config/my-alias.sh" >> "$HOME/.bashrc"

else
    echo "Install Fish shell"

    # Add alias
fi

# alias


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
echo "Copy TMUX config from $(realpath dotfiles/.tmux.conf) to $HOME"
ln -s "$(realpath dotfiles/.tmux.conf)" "$HOME/.tmux.conf"

# Install TMUX plugins
echo "Install TMUX plugins"
"$HOME/.tmux/plugins/tpm/bin/install_plugins"

echo "================================= VIM =================================="
echo "Sellect editor:"
printf "\t1. Vim\n"
printf "\t2. Neovim"

printf "Enter your choice: "
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
    echo "Copy vim config from $(realpath dotfiles/.config/nvim) to $HOME"
    ln -s "$(realpath dotfiles/.config/nvim)" "$HOME/.config/nvim"

fi

echo "============================= OTHER TOOLs =============================="

echo "Install Window manager tools"
# Install
brew install --cask nikitabobko/tap/aerospace
brew tap FelixKratz/formulae
brew install sketchybar
brew install borders

# Backup
backup_path "$HOME/.aerospace.toml" "$backup_folder"

# Add config
ln -s "$(realpath dotfiles/.aerospace.toml)" "$HOME"


# # Docker
# sudo apt install -y docker.io
# sudo systemctl enable docker --now
# sudo groupadd docker
# sudo usermod -aG docker $USER
# newgrp docker
# docker ps

echo "==================================== DONE ====================================="
