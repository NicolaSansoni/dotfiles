return {
    {
        "hedyhli/outline.nvim",
        cmd = { "Outline", "OutlineOpen" },
        keys = {
            { "<leader>so", "<cmd>Outline<CR>", desc = "Show Outline" },
        },
        opts = {
            relative_width = false,
            width = 36,
        },
    },
}
