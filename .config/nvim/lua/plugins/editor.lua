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
      {
        "<leader>ss",
        function()
          require("telescope.builtin").lsp_document_symbols({
            symbol_width = 80,
            symbols = require("lazyvim.config").get_kind_filter(),
          })
        end,
        desc = "Goto Symbol",
      },
      {
        "<leader>sS",
        function()
          require("telescope.builtin").lsp_dynamic_workspace_symbols({
            fname_width = 40,
            symbol_width = 40,
            symbols = require("lazyvim.config").get_kind_filter(),
          })
        end,
        desc = "Goto Symbol (Workspace)",
      },
    },
  },

  { "folke/flash.nvim", enabled = false },
}
