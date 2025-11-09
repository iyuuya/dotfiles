--------------------------------------------------------------------------------
--- lsp
--------------------------------------------------------------------------------
return {
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
}
