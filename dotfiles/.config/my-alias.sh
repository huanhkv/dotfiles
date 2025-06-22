alias ..='cd ..'
alias ...='cd ../..'

mkcd() { mkdir -p "$1" && cd "$1"; }

k8s_master_1_port="110"
k8s_worker_1_port="111"
alias km1="ssh huanhkv@localhost -p "$k8s_master_1_port
alias kw1="ssh huanhkv@localhost -p "$k8s_worker_1_port

# Brew mapping =================================================================================
export PATH=/opt/homebrew/bin:$PATH

# Tool mapping =================================================================================
alias nv="nvim"
alias cat="bat"
alias ls="exa"

# Colima =================================================================================
c="colima"
alias c=$c

# Minikube =================================================================================
m="minikube"
alias m=$m
alias mi="$m image"

# Kubectl =================================================================================

k="kubectl"
c=" config"
d=" describe"
l=" logs"
g=" get"
p=" pod"
u=" use-context"
# # Cluster
qa=""
stage=""
prod=""
vpstage=""
vpprod=""

alias k=$k

alias kg=$k$g
alias kd=$k$d
alias kl=$k$l
alias kc=$k$c
alias ku=$k$c$u

alias kgp=$k$g$p
alias kdp=$k$d$p
alias kcgc=$k$c" get-contexts"

alias kuqa=$k$c$u$qa
alias kustage=$k$c$u$stage
alias kuprod=$k$c$u$prod
alias kuvpstage=$k$c$u$vpstage
alias kuvpprod=$k$c$u$vpprod

# Workbench
sc_ip=""
lp_ip=""
l4_0_ip=""
l4_1_ip=""
red_ip=""

## sc
alias sc="ssh jupyter@"$sc_ip

## lp
alias lp="ssh jupyter@"$lp_ip
alias lp-huanhkv="ssh huanhkv@"$lp_ip

## L4
alias l40="ssh jupyter@"$l4_0_ip
alias l40-huanhkv="ssh huanhkv@"$l4_0_ip

## L4-1
alias l41="ssh jupyter@"$l4_1_ip
alias l41-huanhkv="ssh huanhkv@"$l4_1_ip

alias red="ssh jupyter@"$red_ip
alias red-huanhkv="ssh huanhkv@"$red_ip


# Gcloud =================================================================================
alias gal="gcloud auth login"
