# CONSTANTS

# CONSTANTS END =================================================================================

export TERM=xterm-256color

alias ..='cd ..'
alias ...='cd ../..'

mkcd() { mkdir -p "$1" && cd "$1"; }


# MacOS specific settings =================================================================================
# # Brew mapping =================================================================================
export PATH=/opt/homebrew/bin:$PATH
export DYLD_LIBRARY_PATH="/opt/homebrew/lib:$DYLD_LIBRARY_PATH"

# # CMake mapping =================================================================================
export PATH=/Applications/CMake.app/Contents/bin:$PATH


# Tool mapping =================================================================================
# # UV =================================================================================
uv_env_path="$HOME/.uv-env"
if [ ! -d "$uv_env_path" ]; then
    echo "Creating virtual environment at $uv_env_path"
    mkdir "$uv_env_path"
fi
alias uv_env_list="ls -lah $uv_env_path"
uv_env_create() {
    current_dir=$(pwd)

    # Get all args except the first one
    uv_args=()
    for arg in "$@"; do
        uv_args+=("$arg")
    done
    uv init "${uv_args[@]:1}"

    cd "$current_dir" || return
}
uv_env_activate() {
    source $uv_env_path/$1/.venv/bin/activate
}

# # Vim =================================================================================
alias v="vim"
alias nv="nvim"
alias vim="nvim"

alias cat="bat"
alias ls="eza"

# # Git =================================================================================
alias githuan='GIT_SSH_COMMAND="ssh -o IdentitiesOnly=yes -o IdentityFile=~/.ssh/id_ed25519_huanhkv" git'
alias git-set-huanhkv='git config --local user.name "Winter HoKha" && git config --local user.email "huanhkv@gmail.com" && git config --local user.signingkey "/Users/huan.ho/.ssh/id_ed25519_huanhkv.pub"'
alias lzg=lazygit

# # Kubenetes =================================================================================
# # # Kubectl
k="kubectl"
c=" config"
d=" describe"
l=" logs"
g=" get"
p=" pod"
u=" use-context"
alias k=$k

alias kg=$k$g
alias kd=$k$d
alias kl=$k$l
alias kc=$k$c
alias ku=$k$c$u

alias kgp=$k$g$p
alias kdp=$k$d$p
alias kcgc=$k$c" get-contexts"

# # # Kubie (kubectl wrapper)
alias kb="kubie"
alias kbc="kubie ctx"
alias kbn="kubie ns"

# # # kbu: switch context and namespace
kbu() {
  if [ $# -eq 1 ]; then
    # Single argument - just switch context
    case $1 in
      dev) kubie ctx $dev ;;
      stg) kubie ctx $stg ;;
      prd) kubie ctx $prd ;;
      *) kubie ctx $1 ;;  # fallback to pass argument directly to kubie ctx
    esac
  elif [ $# -eq 2 ]; then
    # Two arguments - switch context and namespace
    case $1 in
      dev) kubie ctx $dev -n $2 ;;
      stg) kubie ctx $stg -n $2 ;;
      prd) kubie ctx $prd -n $2 ;;
      *) kubie ctx $1 -n $2 ;;  # fallback to pass arguments directly to kubie ctx
    esac
  else
    echo "Usage: ku <context> [namespace]"
    echo "Examples:"
    echo "  ku qa          # switch to qa context"
    echo "  ku qa dsai     # switch to qa context with dsai namespace"
  fi
}


# # Gcloud =================================================================================
alias gal="gcloud auth login"
alias gal-ad="gcloud auth application-default login"

# Other =================================================================================
# # SSH aliases
ubuntu_port="254"
k8s_master_1_port="110"
k8s_worker_1_port="111"
alias ust="ssh huanhkv@localhost -p "$ubuntu_port
alias km1="ssh huanhkv@localhost -p "$k8s_master_1_port
alias kw1="ssh huanhkv@localhost -p "$k8s_worker_1_port
