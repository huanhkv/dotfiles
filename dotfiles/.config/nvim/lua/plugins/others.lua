-- Other plugins
return {

    -- Finder
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
            vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
        end,
    },

    -- Markdown preview
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
        lazy = false
    },

    -- Floaterm
    {
        'voldikss/vim-floaterm',
        config = function()
            -- vim.g.floaterm_keymap_new = '<F2>'
            -- vim.cmd([[let g:floaterm_keymap_new = '<F2>']])
            -- vim.cmd([[let g:floaterm_keymap_toggle = '<F3>']])
            -- vim.cmd("let g:floaterm_keymap_prev = '<F5>'")
            -- vim.cmd("let g:floaterm_keymap_next = '<F6>'")
            -- vim.cmd("let g:floaterm_keymap_kill = '<F12>'")
            -- " noremap <F2> :FloatermNew --height=0.9 --width=0.9 --name='lazygit' echo %:p:h<CR>
            -- noremap <F4> :FloatermNew --height=0.9 --width=0.9 --name='lazygit' lazygit<CR>
        end,
    },


}
