vim.keymap.set('n', '<M-h>', ':nohlsearch<CR>')

-- Buffer
vim.keymap.set('n', '<C-p>', ':bprevious<CR>')
vim.keymap.set('n', '<C-n>', ':bnext<CR>')
vim.keymap.set('n', '<C-S-d>', ':bdelete<CR>')

-- LSP
vim.keymap.set("n", "]g", vim.diagnostic.goto_next)
vim.keymap.set("n", "[g", vim.diagnostic.goto_prev)
