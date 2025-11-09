--------------------------------------------------------------------------------
--- fuzzy finder
--------------------------------------------------------------------------------
return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "<leader>f", group = "file" },
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File", mode = "n" },
		},
	},
	{
		"iyuuya/telescope-rails.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		keys = {
			{ "<leader>r", group = "rails" },
			{ "<leader>rm", "<cmd>Telescope rails models<cr>", desc = "model", mode = "n" },
			{ "<leader>rc", "<cmd>Telescope rails controllers<cr>", desc = "controller", mode = "n" },
			{ "<leader>rv", "<cmd>Telescope rails views<cr>", desc = "view", mode = "n" },
			{ "<leader>rs", "<cmd>Telescope rails specs<cr>", desc = "spec", mode = "n" },
			{ "<leader>rh", "<cmd>Telescope rails helpers<cr>", desc = "batch", mode = "n" },
			{ "<leader>rb", "<cmd>Telescope rails batches<cr>", desc = "batch", mode = "n" },
			{ "<leader>rj", "<cmd>Telescope rails jobs<cr>", desc = "job", mode = "n" },
			{ "<leader>rV", "<cmd>Telescope rails view_models<cr>", desc = "view model", mode = "n" },
			{ "<leader>ra", "<cmd>Telescope rails assets<cr>", desc = "asset", mode = "n" },
		},
	},
}
