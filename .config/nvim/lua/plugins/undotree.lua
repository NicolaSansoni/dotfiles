return {
    {
        "mbbill/undotree",
        cmd = { "UndotreeToggle", "UndotreeShow" },
        keys = {
            { "<leader>su", "<cmd>UndotreeToggle<cr>", desc = "Undo history" },
            -- { "<leader>su", "<cmd>UndotreeShow<cr>", desc = "Undo history" },
        },
        init = function()
            vim.g.undotree_ShortIndicators = 1
            vim.g.undotree_WindowLayout = 1
            vim.g.undotree_SplitWidth = 36
        end,
    },
}
