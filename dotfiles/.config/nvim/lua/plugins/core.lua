-- Core plugings
return {
    
    -- LSP
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",  -- Ensure Mason is installed
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = { "pyright", "clangd" },
            })

            local lspconfig = require("lspconfig")
            lspconfig.pyright.setup({})
            lspconfig.clangd.setup({})
        end,
    },

    -- Post-install/update hook with neovim command
    {
        'nvim-treesitter/nvim-treesitter',
        run = ":TSUpdate",
        cmd = {
            "TSInstall",
            "TSUninstall",
            "TSUpdate",
            "TSUpdateSync",
            "TSInstallInfo",
            "TSInstallSync",
            "TSInstallFromGrammar",
        },
        event = "User FileOpened",
    },

    -- Autocomplete
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "cmp-nvim-lsp",
            "cmp_luasnip",
            -- "cmp-buffer",
            -- "cmp-path",
            -- "cmp-cmdline",
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
    { "hrsh7th/cmp-nvim-lsp", lazy=true },
    { "saadparwaiz1/cmp_luasnip", lazy=true },
    -- { "hrsh7th/cmp-buffer", lazy=true },
    -- { "hrsh7th/cmp-path", lazy=true },
    -- { "hrsh7th/cmp-cmdline", lazy=true },

}
