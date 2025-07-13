alias ..='cd ..'
alias ...='cd ../..'

mkcd() { mkdir -p "$1" && cd "$1"; }

k8s_master_1_port="110"
k8s_worker_1_port="111"
alias km1="ssh huanhkv@localhost -p "$k8s_master_1_port
alias kw1="ssh huanhkv@localhost -p "$k8s_worker_1_port


export PATH=/opt/homebrew/bin:$PATH

# MacOS specific settings =================================================================================
# # Brew mapping =================================================================================
export PATH=/opt/homebrew/bin:$PATH
export DYLD_LIBRARY_PATH="/opt/homebrew/lib:$DYLD_LIBRARY_PATH"

# # CMake mapping =================================================================================
export PATH=/Applications/CMake.app/Contents/bin:$PATH


# Tool mapping =================================================================================
# # Vim
alias v="vim"
alias nv="nvim"
alias vim="nvim"

alias cat="bat"
alias ls="eza"

# Git =================================================================================
alias githuan='GIT_SSH_COMMAND="ssh -o IdentitiesOnly=yes -o IdentityFile=~/.ssh/id_ed25519_huanhkv" git'
alias git-set-huanhkv='git config --local user.name "Winter HoKha" && git config --local user.email "huanhkv@gmail.com" && git config --local user.signingkey "/Users/huan.ho/.ssh/id_ed25519_huanhkv.pub"'

# Colima =================================================================================
c="colima"
alias c=$c

# Minikube =================================================================================
m="minikube"
alias m=$m
alias mi="$m image"

# Kubectl =================================================================================
# # CLI
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

# Gcloud =================================================================================
alias gal="gcloud auth login"

# Other aliases =================================================================================
# # K8s Cluster
qa=""
stage=""
prod=""
prod_csa=""
vpstage=""
vpprod=""
