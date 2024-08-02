return {
    "stevearc/conform.nvim",
    dependencies = {
        "williamboman/mason.nvim",
    },
    opts = {
        default_format_opts = {
            lsp_format = "fallback",
        },
        format_on_save = {
            timeout_ms = 1000,
        },
    },
    cmd = { "ConformInfo" },
    event = { "BufWritePre" },
    -- stylua: ignore
    keys = {
        { "<leader>cf", function() require("conform").format() end, desc = "Format Code" },
    },
}
