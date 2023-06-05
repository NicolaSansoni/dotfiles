local servers = {
  clangd = {},
  cssls = {},
  docker_compose_language_service = {},
  dockerls = {},
  dotls = {},
  emmet_ls = {},
  eslint = {},
  gopls = {},
  graphql = {},
  html = {},
  jsonls = {},
  lemminx = {},
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
  marksman = {},
  pyright = {},
  rust_analyzer = {},
  spectral = {},
  sqlls = {},
  svelte = {},
  tailwindcss = {},
  taplo = {},
  terraformls = {},
  tsserver = {},
  volar = {
    filetypes = {
      'typescript',
      'javascript',
      'typescriptreact',
      'javascriptreact',
      'vue',
      'json',
    },
  },
  yamlls = {},
  zls = {},
}

local function autoformatting()
  local format_is_enabled = true
  vim.api.nvim_create_user_command('KickstartFormatToggle', function()
    format_is_enabled = not format_is_enabled
    print('Setting autoformatting to: ' .. tostring(format_is_enabled))
  end, {})

  local _augroups = {}
  local get_augroup = function(client)
    if not _augroups[client.id] then
      local group_name = 'kickstart-lsp-format-' .. client.name
      local id = vim.api.nvim_create_augroup(group_name, { clear = true })
      _augroups[client.id] = id
    end
    return _augroups[client.id]
  end

  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('kickstart-lsp-attach-format', { clear = true }),
    callback = function(args)
      local client_id = args.data.client_id
      local client = vim.lsp.get_client_by_id(client_id)
      local bufnr = args.buf

      if not client.server_capabilities.documentFormattingProvider then
        return
      end

      if client.name == 'tsserver' then
        return
      end

      vim.api.nvim_create_autocmd('BufWritePre', {
        group = get_augroup(client),
        buffer = bufnr,
        callback = function()
          if not format_is_enabled then
            return
          end

          vim.lsp.buf.format {
            async = false,
            filter = function(c)
              return c.id == client.id
            end,
          }
        end,
      })
    end,
  })
end

local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end
    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

return {
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',
      { 'j-hui/fidget.nvim',       opts = {} },
      'folke/neodev.nvim',
    },
    config = function()
      autoformatting()

      require('neodev').setup()

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      local mason_lspconfig = require 'mason-lspconfig'
      mason_lspconfig.setup {
        ensure_installed = vim.tbl_keys(servers),
      }
      mason_lspconfig.setup_handlers {
        function(server_name)
          require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
          }
        end,
      }
    end,
  },
}
