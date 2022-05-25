local wezterm = require("wezterm")

return {
  color_scheme = "iceberg-dark",
  font = wezterm.font("PixelMplus12"),
  font_size = 16.0,
  initial_cols = 160,
  initial_rows = 40,
  keys = {
    {key="1",mods="CMD",action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},
    {key="2",mods="CMD",action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}},
    {key="d",mods="CMD|SHIFT",action="ShowLauncher"},
  }
}
