-- Other plugins
return {

    -- Which key
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Local Keymaps (which-key)",
            },
        },
    },

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
            vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'Telescope diagnostics' })
            vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols, { desc = 'Telescope LSP document symbols' })
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
        lazy = false,
        config = function()
            vim.keymap.set("n", "<F2>", ":FloatermNew<CR>", { silent = true })
            vim.keymap.set("t", "<F2>", "<C-\\><C-n>:FloatermNew<CR>", { silent = true })
            vim.keymap.set("n", "<F3>", ":FloatermToggle<CR>", { silent = true })
            vim.keymap.set("t", "<F3>", "<C-\\><C-n>:FloatermToggle<CR>", { silent = true })
            vim.keymap.set("n", "<F5>", ":FloatermPrev<CR>", { silent = true })
            vim.keymap.set("t", "<F5>", "<C-\\><C-n>:FloatermPrev<CR>", { silent = true })
            vim.keymap.set("n", "<F6>", ":FloatermNext<CR>", { silent = true })
            vim.keymap.set("t", "<F6>", "<C-\\><C-n>:FloatermNext<CR>", { silent = true })
            vim.keymap.set("n", "<F12>", ":FloatermKill<CR>", { silent = true })
            vim.keymap.set("t", "<F12>", "<C-\\><C-n>:FloatermKill<CR>", { silent = true })
            vim.keymap.set("n", "<F4>", ":FloatermNew --height=0.9 --width=0.9 --name='lazygit' lazygit<CR>", { silent = true })
        end,
    },


}
