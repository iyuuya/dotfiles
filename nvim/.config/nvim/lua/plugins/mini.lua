return {
	{
		"nvim-mini/mini.nvim",
		config = function()
			require("mini.deps").setup()
			local now, later = MiniDeps.now, MiniDeps.later
			now(function()
				require("mini.icons").setup()
			end)

			now(function()
				require("mini.misc").setup()
				MiniMisc.setup_restore_cursor()
			end)

			now(function()
				require("mini.surround").setup()
			end)

			now(function()
				require("mini.pairs").setup()
			end)

			now(function()
				require("mini.comment").setup()
			end)

			later(function()
				require("mini.diff").setup()
			end)

			later(function()
				require("mini.git").setup()
			end)

			now(function()
				require("mini.sessions").setup()

				local function is_blank(arg)
					return arg == nil or arg == ""
				end
				local function get_sessions(lead)
					-- ref: https://qiita.com/delphinus/items/2c993527df40c9ebaea7
					return vim.iter(vim.fs.dir(MiniSessions.config.directory))
						:map(function(v)
							local name = vim.fs.basename(v)
							return vim.startswith(name, lead) and name or nil
						end)
						:totable()
				end
				vim.api.nvim_create_user_command("SessionWrite", function(arg)
					local session_name = is_blank(arg.args) and vim.v.this_session or arg.args
					if is_blank(session_name) then
						vim.notify("No session name specified", vim.log.levels.WARN)
						return
					end
					vim.cmd("%argdelete")
					MiniSessions.write(session_name)
				end, { desc = "Write session", nargs = "?", complete = get_sessions })

				vim.api.nvim_create_user_command("SessionDelete", function(arg)
					MiniSessions.select("delete", { force = arg.bang })
				end, { desc = "Delete session", bang = true })

				vim.api.nvim_create_user_command("SessionLoad", function()
					MiniSessions.select("read", { verbose = true })
				end, { desc = "Load session" })

				vim.api.nvim_create_user_command("SessionEscape", function()
					vim.v.this_session = ""
				end, { desc = "Escape session" })

				vim.api.nvim_create_user_command("SessionReveal", function()
					if is_blank(vim.v.this_session) then
						vim.print("No session")
						return
					end
					vim.print(vim.fs.basename(vim.v.this_session))
				end, { desc = "Reveal session" })
			end)

			now(function()
				require("mini.starter").setup({})
			end)
		end,
	},
}
