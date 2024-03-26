local telescope_builtin = require("telescope.builtin")

local function ts(picker, opts)
  return function()
    return telescope_builtin[picker](opts)
  end
end

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        position = "current",
      },
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_hidden = false,
        },
      },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>ff", ts("find_files"), desc = "Find Files" },
      { "<leader>fF", false },
      {
        "<leader>faf",
        ts("find_files", { hidden = true, no_ignore = true }),
        desc = "Find All Files",
      },
      { "<leader>sg", ts("live_grep"), desc = "Grep" },
      { "<leader>sG", ts("live_grep", { cwd = false }), desc = "Grep (cwd)" },
      { "<leader>sw", ts("grep_string", { word_match = "-w" }), desc = "Word" },
      {
        "<leader>sW",
        ts("grep_string", { cwd = false, word_match = "-w" }),
        desc = "Word (cwd)",
      },
      { "<leader>sw", ts("grep_string"), mode = "v", desc = "Selection" },
      {
        "<leader>sW",
        ts("grep_string", { cwd = false }),
        mode = "v",
        desc = "Selection (cwd)",
      },
    },
  },

  { "folke/flash.nvim", enabled = false },
}
