-- Core plugings
return {
    
    -- LSP
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
        },
        config = function()
            local lspconfig = require("lspconfig")
            lspconfig.pyright.setup({})
            lspconfig.clangd.setup({})
        end,
    },

    -- Nvim Treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        opts = {
            -- A list of parser names, or "all" (the listed parsers MUST always be installed)
            ensure_installed = {
                "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline",
                "python", "json", "yaml", "bash", "cmake",
            },
            -- ensure_installed = "maintained",
            highlight = { enable = true },
            indent = { enable = true },
            autotag = { enable = true },
            context_commentstring = { enable = true },
        },
        -- run = ":TSUpdate",
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

    -- Mason Plugins
    {
        "williamboman/mason.nvim",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "jay-babu/mason-null-ls.nvim",
            'nvimtools/none-ls.nvim',
            "jay-babu/mason-nvim-dap.nvim",
            "mfussenegger/nvim-dap",
            -- "neovim/nvim-lspconfig",
        },
        config = function()
            require("mason").setup({})

            require("mason-lspconfig").setup({
                ensure_installed = { 
                    -- Python
                    "pyright",
                    -- C language
                    "clangd",
                },
            })

            require("mason-null-ls").setup({
                ensure_installed = {
                    -- Python
                    "mypy", "ruff",
                    -- C language
                    "clang-format",
                },
            })

            local null_ls = require("null-ls")
            null_ls.setup({
                sources = {
                    null_ls.builtins.diagnostics.mypy,
                    null_ls.builtins.diagnostics.ruff,
                    null_ls.builtins.formatting.clang_format,
                },
            })

            require("mason-nvim-dap").setup({
                ensure_installed = {
                    "debugpy",
                    "codelldb",
                },
                automatic_installation = true,
            })

        end,
    },

    -- Nvim DAP
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio"
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")
            dapui.setup()

            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.after.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.after.event_exited["dapui_config"] = function()
                dapui.close()
            end

            vim.keymap.set('n', "<leader>db", ':DapToggleBreakpoint<CR>')
            vim.keymap.set('n', "<leader>dr", ':DapContinue<CR>')
            -- local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
            -- dap.configurations.python = {
            --     {
            --         type = 'python';
            --         request = 'launch';
            --         name = "Launch file";
            --         program = "${file}";
            --         pythonPath = function()
            --             return path -- '/usr/bin/python'
            --         end;
            --     },
            -- }
            -- dap.configurations.cpp = {
            --     {
            --         type = 'codelldb';
            --         request = 'launch';
            --         name = "Launch file";
            --         program = function()
            --             return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            --         end;
            --         stopOnEntry = true;
            --         args = {};
            --         cwd = '${workspaceFolder}';
            --         env = function()
            --             local variables = {}
            --             for k, v in pairs(vim.fn.environ()) do
            --                 table.insert(variables, string.format("%s=%s", k, v))
            --             end
            --             return variables
            --         end;
            --     },
            -- }
        end,

    },

    -- Nvim DAP Python
    {
        'mfussenegger/nvim-dap-python',
        dependencies = {
            'mfussenegger/nvim-dap',
            'rcarriga/nvim-dap-ui',
        },
        ft = "python",
        config = function()
            local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
            require("dap-python").setup(path)
            vim.keymap.set("n", "<leader>dpr", function() require("dap-python").test_method() end)
        end,
    },

}
