-- Window

if os.getenv("PIXELMODE") then
  return {
    window_decorations = "RESIZE",
    window_padding = {
      left = 0,
      right = 0,
      top = 0,
      bottom = 0,
    },
    window_background_opacity = 1,
    macos_window_background_blur = 0,
    enable_scroll_bar = false,
    initial_cols = 160,
    initial_rows = 48,
  }
else
  return {
    window_decorations = "RESIZE",
    window_padding = {
      left = 0,
      right = 0,
      top = 0,
      bottom = 0,
    },
    window_background_opacity = 0.9,
    win32_system_backdrop = "Acrylic",
    macos_window_background_blur = 40,
    enable_scroll_bar = false,
    initial_cols = 240,
    initial_rows = 80,
  }
end
