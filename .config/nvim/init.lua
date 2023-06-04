require('setup.vim')

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  require('plugins.lsp'),
  require('plugins.treesitter'),
  require('plugins.telescope'),
  require('plugins.misc'),
})

require('setup.lsp')
require('setup.treesitter')
require('setup.telescope')
require('setup.misc')
