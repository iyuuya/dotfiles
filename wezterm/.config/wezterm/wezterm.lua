local wezterm = require 'wezterm'
local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end
config.automatically_reload_config = true

-- ColorScheme
-- config.color_scheme = "iceberg-dark"
-- config.color_scheme = "Everforest Dark (Gogh)"
config.color_scheme = "Gruvbox dark, hard (base16)"
-- config.color_scheme = 'Tomorrow Night Bright'

-- Font
-- config.font = wezterm.font("SauceCodePro Nerd Font Propo")
config.font = wezterm.font("JetBrains Mono")
config.font_size = 10.0

-- Window
config.window_decorations = "RESIZE"
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}
config.window_background_opacity = 0.9
config.win32_system_backdrop = 'Acrylic'
config.macos_window_background_blur = 10
config.enable_scroll_bar = true

config.initial_cols = 240
config.initial_rows = 80

-- Tab
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true

return config

--   -- key bindings
--   keys = {
--     { key = "1", mods = "CMD",       action = wezterm.action { SplitHorizontal = { domain = "CurrentPaneDomain" } } },
--     { key = "2", mods = "CMD",       action = wezterm.action { SplitVertical = { domain = "CurrentPaneDomain" } } },
--     { key = "d", mods = "CMD|SHIFT", action = "ShowLauncher" },
--   }
