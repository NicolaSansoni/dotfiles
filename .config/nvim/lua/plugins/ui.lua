return {
  -- Theme
  {
    "navarasu/onedark.nvim",
    opts = {
      transparent = true,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "onedark",
    },
  },
  -- notifications
  {
    "rcarriga/nvim-notify",
    opts = {
      background_colour = "#000000",
      minimum_width = 32,
      max_width = 64,
      max_height = 64,
      render = "compact",
      top_down = false,
    },
  },
  -- ui elements
  -- { "stevearc/dressing.nvim", enabled = false },
  { "folke/noice.nvim", enabled = false },

  -- dashboard and greeter
  { "nvimdev/dashboard-nvim", enabled = false },
  { "goodlord/alpha-nvim", enabled = false },
}
