local wezterm = require 'wezterm'
local config = {}

config.color_scheme = 'Github Light (Gogh)'
config.font_size = 22

-- using sway tiling window manager
config.adjust_window_size_when_changing_font_size = false

-- disable tabs
config.enable_tab_bar = false

return config

