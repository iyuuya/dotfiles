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
			{ "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle NvimTree", mode = "n" },
		},
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		opts = {},
		dependencies = { "nvim-lua/plenary.nvim" },
	},
}
