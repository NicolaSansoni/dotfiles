return {
    {
        "nvim-telescope/telescope.nvim",
        version = "*",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-fzf-native.nvim",
        },
        cmd = { "Telescope" },
        opts = {
            pickers = {
                find_files = {
                    hidden = true,
                },
                live_grep = {
                    additional_args = {
                        "--hidden",
                    },
                },
            },
        },
        -- stylua: ignore
        keys = {
            { "<leader><leader>", function() require("telescope.builtin").buffers({}) end, desc = "Telescope Buffers" },
            { "<leader>/", function() require("telescope.builtin").live_grep({}) end, desc = "Telescope grep" },
            { "<leader>ff", function() require("telescope.builtin").find_files({}) end, desc = "Telescope Find Files" },
            { "<leader>fa", function() require("telescope.builtin").find_files({ no_ignore = true }) end, desc = "Telescope Find All" },
            { "<leader>fg", function() require("telescope.builtin").git_files({}) end, desc = "Telescope Git Files" },
        },
        config = function(_, opts)
            require("telescope").setup(opts)
            require("telescope").load_extension("fzf")
        end,
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
    },
}
