return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				-- suggestion = {enabled = false},
				-- panel = {enabled = false},
				copilot_node_command = "node",
			})
		end,
	},
	{
		"zbirenbaum/copilot-cmp",
		after = { "copilot.lua" },
		config = function() end,
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
			{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
		},
		build = "make tiktoken", -- Only on MacOS or Linux
		opts = {
			debug = true, -- Enable debugging
			-- See Configuration section for rest
		},
		-- See Commands section for default commands if you want to lazy load on them
		config = function()
			vim.defer_fn(function()
				require("copilot_cmp").setup()
				require("CopilotChat").setup({
					show_help = "yes",
					prompts = {
						Explain = {
							prompt = "/COPILOT_EXPLAIN コードを日本語で説明してください",
							mapping = "<leader>Ce",
							description = "コードの説明をお願いする",
						},
						Review = {
							prompt = "/COPILOT_REVIEW コードを日本語でレビューしてください。",
							mapping = "<leader>Cr",
							description = "コードのレビューをお願いする",
						},
						Fix = {
							prompt = "/COPILOT_FIX このコードには問題があります。バグを修正したコードを表示してください。説明は日本語でお願いします。",
							mapping = "<leader>Cf",
							description = "コードの修正をお願いする",
						},
						Optimize = {
							prompt = "/COPILOT_REFACTOR 選択したコードを最適化し、パフォーマンスと可読性を向上させてください。説明は日本語でお願いします。",
							mapping = "<leader>Co",
							description = "コードの最適化をお願いする",
						},
						Docs = {
							prompt = "/COPILOT_GENERATE 選択したコードに関するドキュメントコメントを日本語で生成してください。",
							mapping = "<leader>Cd",
							description = "コードのドキュメント作成をお願いする",
						},
						Tests = {
							prompt = "/COPILOT_TESTS 選択したコードの詳細なユニットテストを書いてください。説明は日本語でお願いします。",
							mapping = "<leader>Ct",
							description = "テストコード作成をお願いする",
						},
						FixDiagnostic = {
							prompt = "コードの診断結果に従って問題を修正してください。修正内容の説明は日本語でお願いします。",
							mapping = "<leader>Ci",
							description = "コードの修正をお願いする",
							selection = require("CopilotChat.select").diagnostics,
						},
						Commit = {
							prompt = "実装差分に対するコミットメッセージを英語で記述してください。",
							mapping = "<leader>Cco",
							description = "コミットメッセージの作成をお願いする",
							selection = require("CopilotChat.select").gitdiff,
						},
						CommitStaged = {
							prompt = "ステージ済みの変更に対するコミットメッセージを英語で記述してください。",
							mapping = "<leader>Cs",
							description = "ステージ済みのコミットメッセージの作成をお願いする",
							selection = function(source)
								return require("CopilotChat.select").gitdiff(source, true)
							end,
						},
					},
				})
			end, 100)
		end,
		keys = {
			-- lvim.builtin.which_key.mappings["C"] = {
			--   name   = "Copilot",
			--   e      = { "", "コード説明" },
			--   r      = { "", "レビュー" },
			--   f      = { "", "バグ修正案" },
			--   o      = { "", "最適化" },
			--   d      = { "", "ドキュメント生成" },
			--   t      = { "", "テストコード生成" },
			--   i      = { "", "診断修正" },
			--   s      = { "", "コミットメッセージ作成(ステージ済み)" },
			--   ["co"] = { "", "コミットメッセージ作成(実装差分)" },
		},
	},
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		version = false,
		build = "make",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			--- The below dependencies are optional,
			"nvim-telescope/telescope.nvim", -- for file_selector provider telescope
			"hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
			"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
			"zbirenbaum/copilot.lua", -- for providers='copilot'
			"ravitemer/mcphub.nvim",
		},
		keys = {
			{
				"<leader>a+",
				function()
					local tree_ext = require("avante.extensions.nvim_tree")
					tree_ext.add_file()
				end,
				desc = "Select file in NvimTree",
				ft = "NvimTree",
			},
			{
				"<leader>a-",
				function()
					local tree_ext = require("avante.extensions.nvim_tree")
					tree_ext.remove_file()
				end,
				desc = "Deselect file in NvimTree",
				ft = "NvimTree",
			},
		},
		config = function()
			require("avante").setup({
				provider = "copilot",
				auto_suggestions_provider = "copilot",
				-- 動作設定
				behaviour = {
					auto_suggestions = false,
					auto_set_highlight_group = true,
					auto_set_keymaps = true,
					auto_apply_diff_after_generation = false,
					support_paste_from_clipboard = false,
					minimize_diff = true,
				},
				selector = {
					exclude_auto_select = { "NvimTree" },
				},
				-- ウィンドウ設定
				windows = {
					position = "right", -- サイドバーの位置
					wrap = true, -- テキストの折り返し
					width = 30, -- サイドバーの幅
				},
				system_prompt = function()
					local hub = require("mcphub").get_hub_instance()
					return hub:get_active_servers_prompt()
				end,
				custom_tools = function()
					return {
						require("mcphub.extensions.avante").mcp_tool(),
					}
				end,
			})
		end,
	},
	{
		"ravitemer/mcphub.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim", -- Required for Job and HTTP requests
		},
		-- cmd = "MCPHub", -- lazily start the hub when `MCPHub` is called
		build = "npm install -g mcp-hub@latest", -- Installs required mcp-hub npm module
		config = function()
			require("mcphub").setup({
				-- Required options
				port = 53000, -- Port for MCP Hub server
				config = vim.fn.expand("~/.config/mcphub/mcpservers.json"), -- Absolute path to config file

				log = {
					level = vim.log.levels.WARN,
					to_file = false,
					file_path = nil,
					prefix = "MCPHub",
				},
				extensions = {
					-- Enable or disable extensions
					-- codecompanion = true, -- Code Companion extension
					avante = {
						make_slash_commands = true,
					}, -- Avante extension
				},
			})
		end,
	},
	{
		"olimorris/codecompanion.nvim",
		config = function()
			require("codecompanion").setup({
				strategies = {
					chat = {
						tools = {
							["mcp"] = {
								callback = function()
									return require("mcphub.extensions.codecompanion")
								end,
								opts = {
									requires_approval = true, -- 安全性トグル
									temperature = 0.7, -- 創造性を制御
								},
							},
						},
					},
				},
			})
		end,
	},
	{
		"johnseth97/codex.nvim",
		lazy = true,
		cmd = { "Codex", "CodexToggle" }, -- Optional: Load only on command execution
		keys = {
			{
				"<leader>co", -- Change this to your preferred keybinding
				function()
					require("codex").toggle()
				end,
				desc = "Toggle Codex popup",
			},
		},
		opts = {
			keymaps = {
				toggle = nil, -- Keybind to toggle Codex window (Disabled by default, watch out for conflicts)
				quit = "<C-q>", -- Keybind to close the Codex window (default: Ctrl + q)
			}, -- Disable internal default keymap (<leader>cc -> :CodexToggle)
			border = "rounded", -- Options: 'single', 'double', or 'rounded'
			width = 0.8, -- Width of the floating window (0.0 to 1.0)
			height = 0.8, -- Height of the floating window (0.0 to 1.0)
			model = nil, -- Optional: pass a string to use a specific model (e.g., 'o3-mini')
			autoinstall = true, -- Automatically install the Codex CLI if not found
		},
	},
	{
		"coder/claudecode.nvim",
		dependencies = { "folke/snacks.nvim" },
		config = true,
		keys = {
			{ "<leader>c", nil, desc = "AI/Claude Code" },
			{ "<leader>cc", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
			{ "<leader>cf", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
			{ "<leader>cr", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
			{ "<leader>cC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
			{ "<leader>cm", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
			{ "<leader>cb", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
			{ "<leader>cs", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
			{
				"<leader>cs",
				"<cmd>ClaudeCodeTreeAdd<cr>",
				desc = "Add file",
				ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
			},
			-- Diff management
			{ "<leader>ca", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
			{ "<leader>cd", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
		},
	},
}
