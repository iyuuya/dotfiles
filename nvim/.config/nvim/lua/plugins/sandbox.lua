return {
	{
		"0PandaDEV/ziit-neovim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("ziit").setup({
				api_key = "4d69114f-1d5e-4e69-b04c-cd86b838a2d5",
				base_url = 'https://app.ziit.orb.local', -- optional, defaults to https://ziit.app
				enabled = true,
				heartbeat_interval = 30,
			})
		end,
	},
}
