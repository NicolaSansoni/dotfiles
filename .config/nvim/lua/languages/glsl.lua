vim.filetype.add({
	extension = {
		glsl = "glsl",
		vert = "glsl",
		tesc = "glsl",
		tese = "glsl",
		frag = "glsl",
		geom = "glsl",
		comp = "glsl",
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
