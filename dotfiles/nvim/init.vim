"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""               
"               
"               ██╗███╗  ██╗██╗████████╗██╗   ██╗██╗███╗   ███╗
"               ██║████╗ ██║██║╚══██╔══╝██║   ██║██║████╗ ████║
"               ██║██╔██╗██║██║   ██║   ██║   ██║██║██╔████╔██║
"               ██║██║╚████║██║   ██║   ╚██╗ ██╔╝██║██║╚██╔╝██║
"               ██║██║ ╚███║██║   ██║    ╚████╔╝ ██║██║ ╚═╝ ██║
"               ╚═╝╚═╝  ╚══╝╚═╝   ╚═╝     ╚═══╝  ╚═╝╚═╝     ╚═╝
"               
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""               

" Core
set nocompatible

filetype on
filetype plugin on
filetype indent on
filetype plugin indent on

set number
set cursorline
set cursorcolumn
set relativenumber
set shiftwidth=4
set tabstop=4
set expandtab
set nobackup
set scrolloff=10
set nowrap
set incsearch
set ignorecase
set smartcase
set showcmd
set showmode
set showmatch
set hlsearch
set history=1000
set wildmenu
set wildmode=list:longest
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

set softtabstop=4
set autoindent 
set smarttab
set mouse=a

" set noswapfile
set backupcopy=yes

" Theme/Color
syntax on
syntax enable
colorscheme gruvbox
set background=dark
set t_Co=256

" Plugins
source $HOME/.config/nvim/plugins/plugins.vim
source $HOME/.config/nvim/plugins/completion-nvim.rc.vim
source $HOME/.config/nvim/plugins/minimap.rc.vim
source $HOME/.config/nvim/plugins/airline.rc.vim
source $HOME/.config/nvim/plugins/nerdtree.rc.vim

:runtime $HOME/,config/nvim/plugins/*.rc.vim

" Map
source $HOME/.config/nvim/maps.vim
