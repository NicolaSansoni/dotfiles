require("config")

local lang = {
    lspconfig = {},
    ensure_installed = {},
    formatters_by_ft = {},
}

local languages = vim.api.nvim_get_runtime_file("lua/lang/*.lua", true)
for _, f in pairs(languages) do
    f = f:match("[^/]*.lua$")
    f = f:sub(0, #f - 4)

    local module = require("lang/" .. f)

    lang.lspconfig = vim.tbl_deep_extend("force", lang.lspconfig, module.lspconfig)
    lang.ensure_installed = vim.tbl_deep_extend("force", lang.ensure_installed, module.ensure_installed)
    lang.formatters_by_ft = vim.tbl_deep_extend("force", lang.formatters_by_ft, module.formatters_by_ft)
end

vim.g.lang = lang

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = {
        { import = "plugins" },
    },
    defaults = {
        lazy = true,
        version = false,
    },
    install = {
        colorscheme = { "onedark" },
    },
})

vim.cmd.colorscheme("onedark")
