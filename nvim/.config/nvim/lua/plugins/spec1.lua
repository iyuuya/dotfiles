return {
	--------------------------------------------------------------------------------
	--- which-key
	--------------------------------------------------------------------------------
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {},
	},
	--------------------------------------------------------------------------------
	--- Language specific
	--------------------------------------------------------------------------------
	{
		"tpope/vim-rails",
	},

	{
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
	{
		"shellRaining/hlchunk.nvim",
		opts = {
			chunk = { enable = true },
			indent = { enable = true },
			line_num = { enable = true },
			blank = { enable = true },
		},
	},
	{ "MunifTanjim/nui.nvim" },
	{ "nvim-lua/plenary.nvim" },
	{ "nvim-tree/nvim-web-devicons" },
	{ "antosha417/nvim-lsp-file-operations", opts = {} },
	{ "folke/snacks.nvim", opts = {} },
	{
		"3rd/image.nvim",
		opts = {
			backend = "sixel",
		},
	},
	{ "s1n7ax/nvim-window-picker", opts = {} },
	{ "rcarriga/nvim-notify", opts = {} },
	{
		"folke/noice.nvim",
		opts = {
			lsp = {
				-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
				},
			},
			-- you can enable a preset for easier configuration
			presets = {
				bottom_search = true, -- use a classic bottom cmdline for search
				command_palette = true, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = false, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = true, -- add a border to hover docs and signature help
			},
		},
	},
	{ "folke/snacks.nvim", opts = {} },
	{ "folke/trouble.nvim", opts = {} },
	{ "rachartier/tiny-inline-diagnostic.nvim", opts = {} },
	{ "ray-x/lsp_signature.nvim", opts = {} },
	{ "j-hui/fidget.nvim", opts = {} },
	{
		"folke/lazydev.nvim",
		ft = "lua",
		dependencies = {
			{
				"DrKJeff16/wezterm-types",
				lazy = true,
				version = false, -- Get the latest version
			},
		},
		opts = {
			library = {
				-- Other library configs...
				{ path = "wezterm-types", mods = { "wezterm" } },
			},
		},
	},
}
