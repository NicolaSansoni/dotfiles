return {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    dependecies = {
        "nvim-tree/nvim-web-devicons",
    },
    keys = {
        { "<leader>sf", "<cmd>NvimTreeFindFileToggle<cr>", { desc = "Show File Tree" } },
    },
    opts = {
        sync_root_with_cwd = true,
        reload_on_bufenter = true,
        respect_buf_cwd = true,

        view = {
            side = "right",
            -- number = true,
            -- relativenumber = true,
            centralize_selection = true,
            width = 36,
        },
        actions = {
            use_system_clipboard = false,
            open_file = {
                eject = false,
                resize_window = false,
            },
        },
    },
    init = function()
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1
    end,
}
