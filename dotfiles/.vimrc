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

set noswapfile
set backupcopy=yes

set t_Co=256
set encoding=UTF-8

" Plugins
"" Add Plugins
source $HOME/.vim/plugins/plugins.vim

" Map keys
source $HOME/.vim/maps.vim

" Theme/Color
syntax on
syntax enable
set background=dark

colorscheme gruvbox
