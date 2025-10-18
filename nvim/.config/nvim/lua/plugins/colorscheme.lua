--------------------------------------------------------------------------------
--- colorscheme
--------------------------------------------------------------------------------
return {
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000,
	},
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		opts = {
			terminal_colors = true, -- add neovim terminal colors
			undercurl = true,
			underline = true,
			bold = true,
			italic = {
				strings = true,
				emphasis = true,
				comments = true,
				operators = false,
				folds = true,
			},
			strikethrough = true,
			invert_selection = true,
			invert_signs = true,
			invert_tabline = true,
			inverse = true, -- invert background for search, diffs, statuslines and errors
			contrast = "hard", -- can be "hard", "soft" or empty string
			palette_overrides = {},
			overrides = {},
			dim_inactive = false,
			transparent_mode = true,
		},
		{
			"neanias/everforest-nvim",
			version = false,
			lazy = false,
			priority = 1000,
			config = function()
				local ef = require("everforest")
				ef.setup({
					background = "hard", -- hard, medium, soft
					transparent_background_level = 3, -- 0, 1, 2, 3
					italics = true,
					disable_italic_comments = false,
					ui_contrast = "low", -- high, low, none
					sign_column_background = "dark", -- none, dark, light
					lualine_bold = true,
				})
				ef.load()
				require("lualine").setup({
					options = {
						theme = "everforest",
					},
				})
			end,
		},
	},
}
