
-- Coding plugins
return {

    -- Autopairs
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true,
        -- use opts = {} for passing setup options
        -- this is equivalent to setup({}) function
        -- dependencies = { "nvim-treesitter/nvim-treesitter", "hrsh7th/nvim-cmp" },
    },

    -- Autocomplete
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            'hrsh7th/cmp-nvim-lsp', -- LSP source for nvim-cmp
            'saadparwaiz1/cmp_luasnip', -- Snippets source for nvim-cmp
            -- 'L3MON4D3/LuaSnip', -- Snippets plugin
            -- "cmp-nvim-lsp",
            -- "cmp_luasnip",
            -- "hrsh7th/cmp-buffer",
            -- "hrsh7th/cmp-path",
            -- "hrsh7th/cmp-cmdline",
        },
            
        config = function()
            local cmp = require("cmp")

            cmp.setup({
                mapping = cmp.mapping.preset.insert({
                    ["<Tab>"] = cmp.mapping.select_next_item(),
                    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                }),
                sources = {
                    { name = "nvim_lsp" },  -- LSP completion
                    { name = "luasnip" },  -- Snippets
                    { name = "buffer" },  -- Text buffer completion
                },
            })
        end,
        event = { "InsertEnter", "CmdlineEnter" },
    },

    -- Hover
    -- {
    --     "lewis6991/hover.nvim",
    --     config = function()
    --         require("hover").setup {
    --             init = function()
    --                 -- Require providers
    --                 require("hover.providers.lsp")
    --                 -- require('hover.providers.gh')
    --                 -- require('hover.providers.gh_user')
    --                 -- require('hover.providers.jira')
    --                 -- require('hover.providers.dap')
    --                 -- require('hover.providers.fold_preview')
    --                 -- require('hover.providers.diagnostic')
    --                 -- require('hover.providers.man')
    --                 -- require('hover.providers.dictionary')
    --             end,
    --             preview_opts = {
    --                 border = 'single'
    --             },
    --             -- Whether the contents of a currently open hover window should be moved
    --             -- to a :h preview-window when pressing the hover keymap.
    --             preview_window = false,
    --             title = true,
    --             mouse_providers = {
    --                 'LSP'
    --             },
    --             mouse_delay = 1000
    --         }

    --         -- Setup keymaps
    --         vim.keymap.set("n", "K", require("hover").hover, {desc = "hover.nvim"})
    --         vim.keymap.set("n", "gK", require("hover").hover_select, {desc = "hover.nvim (select)"})
    --         vim.keymap.set("n", "<C-p>", function() require("hover").hover_switch("previous") end, {desc = "hover.nvim (previous source)"})
    --         vim.keymap.set("n", "<C-n>", function() require("hover").hover_switch("next") end, {desc = "hover.nvim (next source)"})

    --         -- Mouse support
    --         vim.keymap.set('n', '<MouseMove>', require('hover').hover_mouse, { desc = "hover.nvim (mouse)" })
    --         vim.o.mousemoveevent = true
    --     end
    -- },
    
}
