local wezterm = require 'wezterm'
local config = {}

-- Colors
config.colors = {
  cursor_bg = '#ff6188',
  cursor_fg = '#000000'
}
config.color_scheme = 'Monokai Soda (Gogh)'

-- Font
config.font = wezterm.font 'Mononoki NF'
config.font_size = 15
config.line_height = 1.2

-- Window
config.enable_tab_bar = false
config.window_background_opacity = 0.96
config.window_decorations = 'RESIZE'

return config
