local wezterm = require 'wezterm'
local config = {}

config.enable_wayland = false
config.color_scheme = 'Abernathy'
config.enable_tab_bar = false
config.font = wezterm.font 'Cascadia Code'
config.window_background_opacity = 0.8
config.default_cursor_style = 'BlinkingBlock'
config.cursor_blink_rate = 600
config.animation_fps = 15

return config