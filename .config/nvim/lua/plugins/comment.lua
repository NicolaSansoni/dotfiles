return {
    "numToStr/Comment.nvim",
    dependencies = {
        "JoosepAlviste/nvim-ts-context-commentstring",
    },
    opts = {},
    keys = {
        { "gc", mode = { "n", "v" } },
        { "gb", mode = { "n", "v" } },
    },
    config = function(_, opts)
        opts.pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()
        require("Comment").setup(opts)
    end,
}
