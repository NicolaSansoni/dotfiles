-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- local luasnip = require("luasnip")
vim.keymap.set({ "i" }, "<Tab>", "<Tab>", { silent = true })
vim.keymap.set({ "s" }, "<Tab>", "<Nop>", { silent = true })
vim.keymap.set({ "i", "s" }, "<S-Tab>", "<Nop>", { silent = true })
