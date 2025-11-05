local wz = require("wezterm")
local act = wz.action

local pixelmode = wz.config_builder()
pixelmode.font = wz.font("PixelMplus12")
pixelmode.color_scheme = "iceberg-dark"
pixelmode.font_size = 20.0

local configs = {
	default = {},
	pixelmode = pixelmode,
}

local launch_menu = {
  {
    label = "iarch",
    args = { "/Users/yuya-ito/.orbstack/bin/orb", "run", "-m", "iarch" },
  },
  {
    label = "iubuntu",
    args = { "/Users/yuya-ito/.orbstack/bin/orb", "run", "-m", "iubuntu" },
  },
}

--   -- key bindings
--   keys = {
--     { key = "1", mods = "CMD",       action = wezterm.action { SplitHorizontal = { domain = "CurrentPaneDomain" } } },
--     { key = "2", mods = "CMD",       action = wezterm.action { SplitVertical = { domain = "CurrentPaneDomain" } } },
--     { key = "d", mods = "CMD|SHIFT", action = "ShowLauncher" },
--   }

return {
	leader = {
		mods = "CMD",
		key = "a",
		timeout_milliseconds = 1000,
	},
	keys = {
		{
			mods = "LEADER",
			key = "d",
			action = wz.action.ShowDebugOverlay,
		},
		{
			key = "d",
			mods = "CMD",
			action = "ShowLauncher",
		},
		{
			mods = "LEADER",
			key = "l",
      action = act.InputSelector {
        title = "Launch…",
        choices = (function()
          local choices = {}
          for _, item in ipairs(launch_menu) do
            table.insert(choices, { label = item.label, id = item.label })
          end
          return choices
        end)(),
        action = wz.action_callback(function(window, pane, id, label)
          if not id then return end

          for _, item in ipairs(launch_menu) do
            if item.label == id then
              wz.mux.spawn_window({ args = item.args })
            end
          end
        end),
      }
		},
		{
			mods = "LEADER",
			key = "t",
			action = wz.action.ShowLauncherArgs({
				flags = "FUZZY|TABS",
				title = "Select tab",
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
            local tab = pane:tab()
            if tab then
              tab:set_title(line)
            end
					end
				end),
			}),
		},
		{
			mods = "LEADER",
			key = "c",
			action = act.InputSelector({
				action = wz.action_callback(function(window, pane, id, label)
					if not id and not label then
						wz.log_info("cancelled")
					else
						local cfg = configs[id] or {}
						window:set_config_overrides(cfg)
					end
				end),
				title = "Select Configuration Profile",
				choices = {
					{ label = "default", id = "default" },
					-- This is the second entry
					{ label = "pixelmode", id = "pixelmode" },
				},
			}),
		},
	},
  launch_menu = launch_menu,
}
