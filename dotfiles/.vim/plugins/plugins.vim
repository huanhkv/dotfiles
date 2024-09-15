" PLUGINS ------------------------------------------------------------ {{{
call plug#begin('~/.vim/plugged')

" Recommend vim command when press : 
" Jump to file from import path
" Open file manager
Plug 'liuchengxu/vim-which-key'


" GUI PLUGINS ------------------------------------------------------------ {{{

" " Theme
" Plug 'olivercederborg/poimandres.nvim'
" Plug 'jdkanani/vim-material-theme'

" Status bar - Tab bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
 
" Developer icons
Plug 'ryanoasis/vim-devicons'
 
" NERDTree
Plug 'preservim/nerdtree' " Folder Tree

" " Code minimap
" Plug 'wfxr/minimap.vim', { 'do': ':!cargo install --locked code-minimap' }

" }}}

" Coding PLUGINS --------------------------------------------------------- {{{
    
" Auto pairs
Plug 'cohama/lexima.vim'

" LSP
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'

" Auto complete
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

" }}}

" Other Tools PLUGINS --------------------------------------------------------- {{{
    
" Start screen
Plug 'mhinz/vim-startify'

" Find
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" " Markdown
" Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug'] }

" " LaTeX
" Plug 'lervag/vimtex'

" Floaterm
Plug 'voldikss/vim-floaterm'

" }}}

call plug#end()

" }}}

" Config for plugins ------------------------------------------------------------ {{{

source $HOME/.vim/plugins/airline.rc.vim
source $HOME/.vim/plugins/fzf-vim.rc.vim
" source $HOME/.vim/plugins/minimap.rc.vim
source $HOME/.vim/plugins/nerdtree.rc.vim
source $HOME/.vim/plugins/vim-devicons.rc.vim
source $HOME/.vim/plugins/vim-floaterm.rc.vim

" :runtime $HOME/.vim/plugins/*.rc.vim

" }}}
