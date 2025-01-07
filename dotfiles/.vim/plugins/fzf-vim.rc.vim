" Configuration options for fzf.vim --------------------------------------------------------- {{{

" Initialize configuration dictionary
let g:fzf_vim = {}

" }}}

" Preview window --------------------------------------------------------- {{{

" This is the default option:
"   - Preview window on the right with 50% width
"   - CTRL-/ will toggle preview window.
" - Note that this array is passed as arguments to fzf#vim#with_preview function.
" - To learn more about preview window options, see `--preview-window` section of `man fzf`.
let g:fzf_vim.preview_window = ['right,50%', 'ctrl-/']

" Preview window is hidden by default. You can toggle it with ctrl-/.
" It will show on the right with 50% width, but if the width is smaller
" than 70 columns, it will show above the candidate list
let g:fzf_vim.preview_window = ['hidden,right,50%,<70(up,40%)', 'ctrl-/']

" Empty value to disable preview window altogether
let g:fzf_vim.preview_window = []

" fzf.vim needs bash to display the preview window.
" On Windows, fzf.vim will first see if bash is in $PATH, then if
" Git bash (C:\Program Files\Git\bin\bash.exe) is available.
" If you want it to use a different bash, set this variable.
"   let g:fzf_vim = {}
"   let g:fzf_vim.preview_bash = 'C:\Git\bin\bash.exe'

" }}}


" Command-level options --------------------------------------------------------- {{{

" [Buffers] Jump to the existing window if possible (default: 0)
let g:fzf_vim.buffers_jump = 1

" [Ag|Rg|RG] Display path on a separate line for narrow screens (default: 0)
" * Requires Perl and fzf 0.53.0 or later
let g:fzf_vim.grep_multi_line = 0
   " PATH:LINE:COL:LINE
let g:fzf_vim.grep_multi_line = 1
   " PATH:LINE:COL:
   " LINE
let g:fzf_vim.grep_multi_line = 2
   " PATH:LINE:COL:
   " LINE
   " (empty line)

" [[B]Commits] Customize the options used by 'git log':
let g:fzf_vim.commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

" [Tags] Command to generate tags file
let g:fzf_vim.tags_command = 'ctags -R'

" [Commands] --expect expression for directly executing the command
let g:fzf_vim.commands_expect = 'alt-enter,ctrl-x'

" }}}
