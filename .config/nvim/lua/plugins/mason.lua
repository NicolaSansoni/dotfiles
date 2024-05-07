return {
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		build = ":MasonUpdate",
		opts = {
			ensure_installed = vim.g.lang.ensure_installed or {},
		},
		config = function(_, opts)
			require("mason").setup(opts)
			require("mason-registry"):on("package:install:success", function()
				vim.defer_fn(function()
					require("lazy.core.handler.event").trigger({
						event = "FileType",
						bug = vim.api.nvim_get_current_buf(),
					})
				end, 100)
			end)
		end,
	},
}
