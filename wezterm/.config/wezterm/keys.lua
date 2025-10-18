local wz = require("wezterm")

--   -- key bindings
--   keys = {
--     { key = "1", mods = "CMD",       action = wezterm.action { SplitHorizontal = { domain = "CurrentPaneDomain" } } },
--     { key = "2", mods = "CMD",       action = wezterm.action { SplitVertical = { domain = "CurrentPaneDomain" } } },
--     { key = "d", mods = "CMD|SHIFT", action = "ShowLauncher" },
--   }

return {
	leader = {
		mods = "CTRL",
		key = "a",
		timeout_milliseconds = 1000,
	},
	keys = {
		{
			mods = "LEADER",
			key = "l",
			action = wz.action.ShowDebugOverlay,
		},
		{
			mods = "LEADER",
			key = "s",
			action = wz.action.ShowLauncherArgs({
				flags = "FUZZY|WORKSPACES|TABS|COMMANDS",
				title = "Select workspace",
			}),
		},
		{
			mods = "LEADER",
			key = "$",
			action = wz.action.PromptInputLine({
				description = "(wezterm) Set workspace title:",
				action = wz.action_callback(function(win, pane, line)
					if line then
						wz.mux.rename_workspace(wz.mux.get_active_workspace(), line)
					end
				end),
			}),
		},
	},
}
