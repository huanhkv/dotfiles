call plug#begin( stdpath('data') . '/plugged')

" Plug 'neovim/nvim-lspconfig'
" Plug 'glepnir/lspsaga.nvim', { 'branch': 'main' }
" 
" Plug 'folke/tokyonight.nvim'
" Plug 'liuchengxu/vim-which-key'

" " From devaslife channel
" Plug 'tpope/vim-fugitive' 
" Plug 'tpope/vim-rhubarb' 

" Recommend vim command when press : 
" Jump to file from import path
" Open file manager

" GUI PLUGINS ------------------------------------------------------------ {{{

" Status bar - Tab bar
Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
 
" " Developer icons
" Plug 'ryanoasis/vim-devicons'
 
" NERDTree
Plug 'preservim/nerdtree' " Folder Tree

" " Code minimap
" Plug 'wfxr/minimap.vim', {'do': ':!cargo install --locked code-minimap'}

" }}}

" Editor PLUGINS --------------------------------------------------------- {{{
    
" Auto pairs
Plug 'cohama/lexima.vim'

" Completion 
Plug 'nvim-lua/completion-nvim'

" nvim-treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" }}}

" Tools PLUGINS --------------------------------------------------------- {{{
    
" Start screen
Plug 'mhinz/vim-startify'

" " Find ???
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.2' }
" or                                , { 'branch': '0.1.x' } 

" Markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

" " LaTeX
" Plug 'lervag/vimtex'

" " Floaterm
" Plug 'voldikss/vim-floaterm'

" " Vim Script
" Plug 'olivercederborg/poimandres.nvim'
 
" }}}

call plug#end()

" " Vim devicons ----------------------------------------------------------- {{{
" let g:webdevicons_enable = 1                            " loading the plugin
" let g:webdevicons_enable_nerdtree = 1                   " adding the flags to NERDTree
" " }}}
" 
" " Vim Floaterm ----------------------------------------------------------- {{{
" let g:floaterm_keymap_new    = '<F2>'
" " noremap <F2> :FloatermNew --height=0.9 --width=0.9 --name='lazygit' echo %:p:h<CR>
" let g:floaterm_keymap_toggle = '<F3>'
" noremap <F4> :FloatermNew --height=0.9 --width=0.9 --name='lazygit' lazygit<CR>
" let g:floaterm_keymap_prev   = '<F5>'
" let g:floaterm_keymap_next   = '<F6>'
" let g:floaterm_keymap_kill   = '<F12>'
" " }}}
 
