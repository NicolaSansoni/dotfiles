return {
    "ThePrimeagen/git-worktree.nvim",
    dependencies = {
        "nvim-telescope/telescope.nvim",
    },
    opts = {},
    keys = {
        {
            "<leader>fw",
            "<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<cr>",
            { desc = "Find Git Worktree" },
        },
        {
            "<leader>fW",
            "<cmd>lua require('telescope').extensions.git_worktree.create_git_worktrees()<cr>",
            { desc = "Create Git Worktree" },
        },
    },
    config = function(_, opts)
        require("git-worktree").setup(opts)
        require("telescope").load_extension("git_worktree")
    end,
}
