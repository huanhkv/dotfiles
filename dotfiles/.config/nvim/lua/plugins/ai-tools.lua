
-- Coding plugins
return {

    { "github/copilot.vim" },

    -- -- Collama
    -- {
    --     'yuys13/collama.nvim',
    --     -- lazy = false,
    --     config = function()
    --         ---@type CollamaConfig
    --         local config = {
    --             model = 'qwen2.5-coder:7b',
    --         }
    --     
    --         local augroup = vim.api.nvim_create_augroup('my_collama_augroup', { clear = true })
    --     
    --         -- auto execute debounced_request
    --         vim.api.nvim_create_autocmd({ 'InsertEnter', 'CursorMovedI', 'TextChangedI' }, {
    --             group = augroup,
    --             callback = function()
    --                 require('collama.copilot').debounced_request(config, 1000)
    --             end,
    --         })
    --         -- auto cancel
    --         vim.api.nvim_create_autocmd({ 'InsertLeave', 'VimLeavePre' }, {
    --             group = augroup,
    --             callback = function()
    --                 require('collama.copilot').clear()
    --             end,
    --         })
    --         -- map accept key
    --         vim.keymap.set('i', '<M-j>', require('collama.copilot').accept)
    --     end,
    -- },

    -- Ollama
    -- {
    --     "nomnivore/ollama.nvim",
    --     dependencies = {
    --         "nvim-lua/plenary.nvim",
    --     },

    --     -- All the user commands added by the plugin
    --     cmd = { "Ollama", "OllamaModel", "OllamaServe", "OllamaServeStop" },

    --     keys = {
    --         -- Sample keybind for prompt menu. Note that the <c-u> is important for selections to work properly.
    --         {
    --             "<leader>oo",
    --             ":<c-u>lua require('ollama').prompt()<cr>",
    --             desc = "ollama prompt",
    --             mode = { "n", "v" },
    --         },

    --         -- Sample keybind for direct prompting. Note that the <c-u> is important for selections to work properly.
    --         {
    --             "<leader>oG",
    --             ":<c-u>lua require('ollama').prompt('Generate_Code')<cr>",
    --             desc = "ollama Generate Code",
    --             mode = { "n", "v" },
    --         },
    --     },

    --     ---@type Ollama.Config
    --     opts = {
    --         -- your configuration overrides
    --     }
    -- }, 

    -- -- CopilotChat
    -- {
    --     "CopilotC-Nvim/CopilotChat.nvim",
    --     dependencies = {
    --         { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
    --         { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    --     },
    --     build = "make tiktoken", -- Only on MacOS or Linux
    --     opts = {
    --         -- See Configuration section for options
    --     },
    --     -- See Commands section for default commands if you want to lazy load on them
    -- },

}
