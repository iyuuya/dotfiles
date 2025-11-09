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
	--- file explorer
	--------------------------------------------------------------------------------
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
	--------------------------------------------------------------------------------
	--- lsp
	--------------------------------------------------------------------------------
	{
		"mason-org/mason.nvim",
		opts = {},
		keys = {
			{ "<leader>l", group = "LSP" },
			{ "<leader>lf", "<cmd>lua vim.lsp.buf.format()<cr>", desc = "format", mode = "n" },
			{ "K", "<cmd>lua vim.lsp.buf.hover()<CR>", desc = "", mode = "n" },
			{ "<leader>lr", "<cmd>lua vim.lsp.buf.references()<CR>", desc = "", mode = "n" },
			{ "<leader>ld", "<cmd>lua vim.lsp.buf.definition()<CR>", desc = "", mode = "n" },
			{ "<leader>lD", "<cmd>lua vim.lsp.buf.declaration()<CR>", desc = "", mode = "n" },
			{ "<leader>li", "<cmd>lua vim.lsp.buf.implementation()<CR>", desc = "", mode = "n" },
			{ "<leader>lt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", desc = "", mode = "n" },
			{ "<leader>ln", "<cmd>lua vim.lsp.buf.rename()<CR>", desc = "", mode = "n" },
			{ "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", desc = "", mode = "n" },
			{ "<leader>de", "<cmd>lua vim.diagnostic.open_float()<CR>", desc = "", mode = "n" },
			{ "<leader>d]", "<cmd>lua vim.diagnostic.goto_next()<CR>", desc = "", mode = "n" },
			{ "<leader>d[", "<cmd>lua vim.diagnostic.goto_prev()<CR>", desc = "", mode = "n" },
		},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
	},
	--------------------------------------------------------------------------------
	--- outline
	--------------------------------------------------------------------------------
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
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
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
	{ "nvim-neo-tree/neo-tree.nvim", opts = {}, dependencies = { "nvim-lua/plenary.nvim" } },
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
