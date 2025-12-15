local wz = require("wezterm")
local act = wz.action

local pixelmode = wz.config_builder()
pixelmode.font = wz.font("PixelMplus12")
pixelmode.color_scheme = "iceberg-dark"
pixelmode.font_size = 20.0

local livemode = wz.config_builder()
livemode.font = wz.font("JetBrains Mono")
livemode.color_scheme = "Catppuccin Mocha"
livemode.font_size = 16.0

local notemode = wz.config_builder()
notemode.font = wz.font("JetBrains Mono")
-- notemode.color_scheme = "Builtin Solarized Light"
notemode.color_scheme = "Everforest Light Hard (Gogh)"
notemode.font_size = 18.0
notemode.window_background_opacity = 1
notemode.macos_window_background_blur = 0
notemode.enable_scroll_bar = false

local configs = {
	default = {},
	pixelmode = pixelmode,
	livemode = livemode,
	notemode = notemode,
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

local colors = {}
local function make_pallete(ansi)
	local SGR = "\x1b["
	local str = ""
	for _, v in ipairs(ansi) do
		local r = tonumber(v:sub(2, 3), 16)
		local g = tonumber(v:sub(4, 5), 16)
		local b = tonumber(v:sub(6, 7), 16)
		local add = string.format("%s48;2;%d;%d;%dm ", SGR, r, g, b)
		str = str .. add
	end
	return str
end
for k, v in pairs(wz.color.get_builtin_schemes()) do
	table.insert(colors, {
		id = k,
		label = wz.format({
			{ Text = make_pallete(v.ansi) },
			{ Text = make_pallete(v.brights) },
			{ Text = "\x1b[0m " },
			{ Foreground = { Color = v.foreground } },
			{ Background = { Color = v.background } },
			{ Text = k },
		}),
	})
end

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
			action = act.ShowDebugOverlay,
		},
		{
			key = "d",
			mods = "CMD",
			action = "ShowLauncher",
		},
		{
			mods = "LEADER",
			key = "l",
			action = act.InputSelector({
				title = "Launch…",
				choices = (function()
					local choices = {}
					for _, item in ipairs(launch_menu) do
						table.insert(choices, { label = item.label, id = item.label })
					end
					return choices
				end)(),
				action = wz.action_callback(function(window, pane, id, label)
					if not id then
						return
					end

					for _, item in ipairs(launch_menu) do
						if item.label == id then
							wz.mux.spawn_window({ args = item.args })
						end
					end
				end),
			}),
		},
		{
			mods = "LEADER",
			key = "t",
			action = act.ShowLauncherArgs({
				flags = "FUZZY|TABS",
				title = "Select tab",
			}),
		},
		{
			mods = "LEADER",
			key = "$",
			action = act.PromptInputLine({
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
					{ label = "pixelmode", id = "pixelmode" },
					{ label = "livemode", id = "livemode" },
					{ label = "notemode", id = "notemode" },
				},
			}),
		},
		{
			mods = "LEADER",
			key = "C",
			action = wz.action_callback(function(win, pane)
				win:perform_action(
					wz.action.InputSelector({
						title = "color_scheme",
						choices = colors,
						action = wz.action_callback(function(inner_window, _, id)
							if id then
								inner_window:set_config_overrides({
									color_scheme = id,
								})
							end
						end),
						fuzzy = true,
					}),
					pane
				)
			end),
		},
	},
	launch_menu = launch_menu,
}
