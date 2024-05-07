return {
    "stevearc/conform.nvim",
    dependencies = {
        "williamboman/mason.nvim",
    },
    opts = {
        format_on_save = {
            lsp_fallback = true,
            timeout_ms = 500,
        },
    },
    cmd = { "ConformInfo" },
    event = { "BufWritePre" },
    keys = {
        { "<leader>cf", "<cmd>lua require('conform').format({ lsp_fallback = true })<CR>", { desc = "Format Code" } },
    },
    --  init = function()
    --      vim.opt.formatexpr = "v:lua.require'conform'.formatexpr()"
    --  end,
}
