return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v2.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
      {
        's1n7ax/nvim-window-picker',
        config = function()
          require('window-picker').setup {
            autoselect_one = true,
            include_current = false,
            filter_rules = {
              bo = {
                filetype = { 'neo-tree', 'neo-tree-popup', 'notify' },
                buftype = { 'terminal', 'quickfix' },
              },
            },
            other_win_hl_color = '#e35e4f',
          }
        end,
      },
    },
    config = function()
      vim.cmd [[ let g:neo_tree_remove_legacy_commands = 1 ]]

      vim.fn.sign_define('DiagnosticSignError', { text = ' ', texthl = 'DiagnosticSignError' })
      vim.fn.sign_define('DiagnosticSignWarn', { text = ' ', texthl = 'DiagnosticSignWarn' })
      vim.fn.sign_define('DiagnosticSignInfo', { text = ' ', texthl = 'DiagnosticSignInfo' })
      vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })

      require('neo-tree').setup {
        sources = {
          'filesystem',
          'document_symbols',
        },
        source_selector = {
          statusline = true,
          sources = {
            { source = 'filesystem' },
            { source = 'document_symbols' },
          },
        },
        popup_border_style = 'none',
        close_if_last_window = true,
        window = {
          position = 'right',
          width = 30,
          mappings = {
            ['<space>'] = 'none',
          },
        },
        default_component_configs = {
          git_status = {
            symbols = {
              added = '',
              modified = '',
              deleted = '✖',
              renamed = '',
              untracked = '',
              ignored = '',
              unstaged = '',
              staged = '',
              conflict = '',
            },
          },
        },
        filesystem = {
          filtered_items = {
            visible = true,
            hide_dotfiles = false,
            hide_gitignored = false,
            hide_hidden = false,
          },
          follow_current_file = true,
        },
        document_symbols = {
          window = {
            mappings = {
              ['<cr>'] = 'toggle_node',
              ['g'] = 'jump_to_symbol',
              ['A'] = 'noop', -- also accepts the config.show_path and config.insert_as options.
              ['d'] = 'noop',
              ['y'] = 'noop',
              ['x'] = 'noop',
              ['p'] = 'noop',
              ['c'] = 'noop',
              ['m'] = 'noop',
              ['a'] = 'noop',
              ['/'] = 'filter',
              ['f'] = 'filter_on_submit',
            },
          },
        },
      }

      vim.keymap.set('n', '\\', ':Neotree focus<CR>', { desc = 'Open File tree' })
      vim.keymap.set('n', '<leader>\\', ':Neotree focus document_symbols<CR>', { desc = 'Open Symbols tree' })
    end,
  },
}
