"lua require'lspconfig'.pyls.setup{on_attach=require'completion'.on_attach}
"" Use completion-nvim in every buffer
"autocmd BufEnter * lua require'completion'.on_attach()

" Recommended Setting ----------------------------------------------------------- {{{

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
 
" " Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect
" 
" " Avoid showing message extra message when using completion
set shortmess+=c

" }}}

" Enable/Disable auto popup ----------------------------------------------------- {{{

" let g:completion_enable_auto_popup = 1

" "map <c-p> to manually trigger completion
" imap <silent> <c-p> <Plug>(completion_trigger)
" 
" imap <tab> <Plug>(completion_smart_tab)
" imap <s-tab> <Plug>(completion_smart_s_tab)

" }}}

" Changing Completion Confirm key ----------------------------------------------- {{{
" let g:completion_confirm_key = ""
" imap <expr> <cr>  pumvisible() ? complete_info()["selected"] != "-1" ?
"                  \ "\<Plug>(completion_confirm_completion)"  : "\<c-e>\<CR>" :  "\<CR>"
" }}}
