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
  {
    "folke/noice.nvim",
    opts = {
      cmdline = {
        view = "cmdline",
        format = {
          conceal = false,
          cmdline = false,
          search_down = false,
          search_up = false,
          filter = false,
          lua = false,
          help = false,
        },
      },
    },
  },

  -- dashboard, greeter and tabs
  { "nvimdev/dashboard-nvim", enabled = false },
  { "goodlord/alpha-nvim", enabled = false },
  { "akinsho/bufferline.nvim", enabled = false },
}
