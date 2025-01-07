# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# My Aliases BEGIN ====================================================================================================

# Brew mapping
export PATH=/opt/homebrew/bin:$PATH

# Vim
alias nv="nvim"

# Minikube
m="minikube"
alias m=$m
alias mi="$m image"

# Kubectl
# # CLI
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
# # Alias
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

# My Aliases END ====================================================================================================

export GPG_TTY=$(tty)
alias gal="gcloud auth login"

k8s_master_1_port="110"
k8s_worker_1_port="111"
alias km1="ssh huanhkv@localhost -p "$k8s_master_1_port
alias kw1="ssh huanhkv@localhost -p "$k8s_worker_1_port
