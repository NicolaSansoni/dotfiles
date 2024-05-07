return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    keys = {
        { "<leader>h", "<cmd>lua require('harpoon'):list():add()<CR>" },
        { "<leader>sh", "<cmd>lua require('harpoon').ui:toggle_quick_menu(harpoon:list())<CR>" },
        { "<leader>1", "<cmd>lua require('harpoon'):list():select(1)<CR>" },
        { "<leader>2", "<cmd>lua require('harpoon'):list():select(2)<CR>" },
        { "<leader>3", "<cmd>lua require('harpoon'):list():select(3)<CR>" },
        { "<leader>4", "<cmd>lua require('harpoon'):list():select(4)<CR>" },
        { "<leader>5", "<cmd>lua require('harpoon'):list():select(4)<CR>" },
    },
}
