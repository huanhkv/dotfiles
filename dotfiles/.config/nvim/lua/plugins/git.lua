return {
    "lewis6991/gitsigns.nvim",
    config = function()

        require("gitsigns").setup()

        -- vim.keymap.nnoremap { "<leader>gh", "<cmd>lua require('gitsigns').toggle_signs()<CR>", desc = "Toggle Git Signs" }

        vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", { desc = "Preview Hunk" })
        vim.keymap.set("n", "<leader>gt", ":Gitsigns toggle_current_line_blame<CR>", { desc = "Toggle current line blame" })
    end,
}
