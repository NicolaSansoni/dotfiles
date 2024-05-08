return {
    {
        "mbbill/undotree",
        cmd = "UndotreeToggle",
        keys = {
            { "<leader>su", vim.cmd.UndotreeToggle, desc = "Undo history" },
        },
        init = function()
            vim.g.undotree_WindowLayout = 3
            vim.g.undotree_SplitWidth = 36
        end,
    },
}
