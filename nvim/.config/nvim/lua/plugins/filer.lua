--------------------------------------------------------------------------------
--- filer
--------------------------------------------------------------------------------
return {
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			{ "nvim-tree/nvim-web-devicons", opts = {} },
		},
		opts = {},
		keys = {
			{ "<leader>ee", "<cmd>NvimTreeToggle<cr>", desc = "Toggle NvimTree", mode = "n" },
		},
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		opts = {},
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "<leader>ef", "<cmd>Neotree filesystem<cr>", desc = "Neotree filesystem", mode = "n" },
			{ "<leader>eb", "<cmd>Neotree buffers<cr>", desc = "Neotree buffers", mode = "n" },
			{ "<leader>eg", "<cmd>Neotree git_status<cr>", desc = "Neotree git_status", mode = "n" },
		}
	},
	{
		"stevearc/oil.nvim",
		opts = {},
		keys = {
			{ "<leader>eo", "<cmd>Oil<cr>", desc = "Open Oil", mode = "n" },
		},
	},
}
