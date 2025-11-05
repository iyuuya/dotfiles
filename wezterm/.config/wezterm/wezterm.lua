local wezterm = require("wezterm") ---@type Wezterm
local config = {} ---@type Config

local function merge(dest, src)
  for k, v in pairs(src) do
    if type(v) == "table" and type(dest[k]) == "table" then
      merge(dest[k], v)
    else
      dest[k] = v
    end
  end
end

if wezterm.config_builder then
  config = wezterm.config_builder()
end
config.automatically_reload_config = true

-- ColorScheme
config.color_scheme = "Everforest Dark Hard (Gogh)"
-- config.color_scheme = "iceberg-dark"
-- config.color_scheme = "Gruvbox dark, hard (base16)"
-- config.color_scheme = "Tomorrow Night Bright"

merge(config, require("fonts"))
merge(config, require("windows"))
merge(config, require("tabs"))
merge(config, require("keys"))

return config
