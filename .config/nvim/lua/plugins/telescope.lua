return {
	{
		'nvim-telescope/telescope.nvim', 
		version = '*',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'nvim-telescope/telescope-fzf-native.nvim',
		},
		cmd = { "Telescope" },
		keys = {
			{ "<leader><leader>", "<cmd>Telescope buffers<cr>", { desc = "Telescope Buffers" }},
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Telescope Find Files" }},
			{ 
				"<leader>fa", 
				function() 
					require("telescope.builtin").find_files({ hidden = true, no_ignore = true }) 
				end, 
				{ desc = "Telescope Find All" }
			},
			{ "<leader>fg", "<cmd>Telescope git_files<cr>", { desc = "Telescope Git Files" }},
		},
	},
	{ 
		'nvim-telescope/telescope-fzf-native.nvim',
		build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
	},
}
