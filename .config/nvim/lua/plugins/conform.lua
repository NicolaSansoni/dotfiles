return {
    "stevearc/conform.nvim",
    dependencies = {
        "williamboman/mason.nvim",
    },
    opts = {
        formatters_by_ft = vim.g.lang.formatters_by_ft or {},
        format_on_save = {
            lsp_fallback = true,
            timeout_ms = 500,
        },
    },
    cmd = { "ConformInfo" },
    keys = {
        { "<leader>cf", "<cmd>lua require('conform').format({ lsp_fallback = true })<CR>", { desc = "Format Code" } },
    },
}
