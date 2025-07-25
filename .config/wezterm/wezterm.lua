local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- Font configuration with Nerd Font (geek font) support
config.font = wezterm.font('SauceCodePro Nerd Font', { weight = 'Regular' })
config.font_size = 22.0
config.line_height = 1.2

-- Font fallback for symbols and emojis with Nerd Font variants
config.font_rules = {
    {
      intensity = 'Bold',
      italic = false,
      font = wezterm.font('SauceCodePro Nerd Font', { weight = 'Bold' })
    },
    {
      intensity = 'Normal',
      italic = true,
      font = wezterm.font('SauceCodePro Nerd Font', { style = 'Italic' })
    },
    {
      intensity = 'Bold',
      italic = true,
      font = wezterm.font('SauceCodePro Nerd Font', { weight = 'Bold', style = 'Italic' })
    }
}

-- Enable better glyph handling for Nerd Font symbols
config.harfbuzz_features = { 'calt=1', 'clig=1', 'liga=1' }

-- Color scheme
-- I like these color schemes for jjui
-- config.color_scheme = 'Atelierforest (light) (terminal.sexy)'
config.color_scheme = 'Ayu Light (Gogh)'
-- config.color_scheme = 'Brewer (light) (terminal.sexy)'
-- config.color_scheme = 'Catppuccin Latte (Gogh)'
-- config.color_scheme = 'Colorcli (Gogh)'
-- config.color_scheme = 'Eighties (light) (terminal.sexy)'
-- config.color_scheme = 'Londontube (light) (terminal.sexy)'
-- config.color_scheme = 'Ocean (light) (terminal.sexy)'

-- Window configuration
config.window_close_confirmation = 'NeverPrompt'
config.adjust_window_size_when_changing_font_size = false

-- Tab configuration
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false

-- Terminal configuration
config.scrollback_lines = 10000
config.enable_scroll_bar = false
config.cursor_blink_rate = 800
config.default_cursor_style = 'BlinkingBlock'

-- Performance
config.front_end = 'WebGpu'
config.webgpu_power_preference = 'HighPerformance'

-- Key bindings
config.keys = {
    {
      key = 'F11',
      action = wezterm.action.ToggleFullScreen,
    },
    {
      key = '+',
      mods = 'CTRL',
      action = wezterm.action.IncreaseFontSize,
    },
    {
      key = '-',
      mods = 'CTRL',
      action = wezterm.action.DecreaseFontSize,
    },
    {
      key = '=',
      mods = 'CTRL',
      action = wezterm.action.ResetFontSize,
    }
}

return config
