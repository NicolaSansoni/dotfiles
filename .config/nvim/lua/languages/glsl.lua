vim.filetype.add({
	extension = {
		glsl = "glsl",
		vert = "vert",
		tesc = "tesc",
		tese = "tese",
		frag = "frag",
		geom = "geom",
		comp = "comp",
	},
})

return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				glsl_analyzer = {},
			},
		},
	},
}
