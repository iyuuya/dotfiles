--------------------------------------------------------------------------------
--- outline
--------------------------------------------------------------------------------
return {
	{
		"stevearc/aerial.nvim",
		config = true,
		keys = {
			{ "<leader>A", group = "Aerial" },
			{ "<leader>Ap", "<cmd>AerialPrev<cr>", desc = "prev", mode = "n" },
			{ "<leader>An", "<cmd>AerialNext<cr>", desc = "next", mode = "n" },
			{ "<leader>At", "<cmd>AerialToggle!<cr>", desc = "toggle", mode = "n" },
		},
	},
}
