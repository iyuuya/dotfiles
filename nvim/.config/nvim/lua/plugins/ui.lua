return {
	{ "nvim-tree/nvim-web-devicons" },
	{ "MunifTanjim/nui.nvim" },
	{ "rcarriga/nvim-notify", opts = {} },
	{ "j-hui/fidget.nvim", opts = {} },
	{ "s1n7ax/nvim-window-picker", opts = {} },

	{ -- Statusline
		"nvim-lualine/lualine.nvim",
		opts = {
			options = {
				theme = "everforest",
				component_separators = "",
				section_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
				lualine_b = { "filename", "branch", "diff" },
				lualine_c = {
					"%=", --[[ add your center components here in place of this comment ]]
				},
				lualine_x = {},
				lualine_y = { "filetype", "progress", "selectioncount" },
				lualine_z = {
					{ "location", separator = { right = "" }, left_padding = 2 },
				},
			},
			inactive_sections = {
				lualine_a = { "filename" },
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = { "location" },
			},
			tabline = {},
			extensions = {},
		},
	},

	{ -- Highlight code chunks and indents
		"shellRaining/hlchunk.nvim",
		opts = {
			chunk = { enable = true },
			indent = { enable = true },
			line_num = { enable = true },
			blank = { enable = true },
		},
	},

	{
		"3rd/image.nvim",
		opts = {
			backend = "sixel",
		},
	},
}
