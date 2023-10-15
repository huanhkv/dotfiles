require 'nvim-treesitter.configs'.setup {
    ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "python", "javascript" },

    indent = {
        enable = false,
        disable = {},
    }

    highlight = {
        enable = true,
        disable = {},
    },
}
