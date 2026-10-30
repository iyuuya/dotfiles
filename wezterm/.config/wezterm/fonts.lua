-- Font
local wz = require("wezterm")

return {
	-- 日本語フォールバックを明示しないと macOS 側で韓国語フォント (Apple SD Gothic Neo) に
	-- フォールバックされ、「気」など日本固有字形が豆腐になる
	font = wz.font_with_fallback({
		"JetBrains Mono",
		"Hiragino Sans",
	}),
	font_size = 12.0,
}
