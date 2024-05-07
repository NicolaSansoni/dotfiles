return {
	lspconfig = {
		lua_ls = {
			settings = {
				Lua = {
					completion = {
						callSnippet = 'Replace',
					},
				},
			},
		},
	},
	ensure_installed = { "stylua" },
	formatters_by_ft = { lua = { "stylua" } },
}

