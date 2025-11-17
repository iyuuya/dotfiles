return {
	--------------------------------------------------------------------------------
	--- core
	--------------------------------------------------------------------------------
	{ "nvim-lua/plenary.nvim" },
	{ "folke/snacks.nvim", opts = {} },
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
	{
		"Mythos-404/xmake.nvim",
		opts = {},
	},
}
