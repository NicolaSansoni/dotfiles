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
    -- stylua: ignore
    keys = {
        { "<leader>cf", function() require("conform").format({ lsp_fallback = true }) end, desc = "Format Code" },
    },
    init = function()
        -- vim.opt.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
}
