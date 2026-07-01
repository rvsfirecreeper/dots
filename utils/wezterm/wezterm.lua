-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.

-- For example, changing the initial geometry for new Bindoj:
config.initial_cols = 120
config.initial_rows = 28

-- or, changing the font size and color scheme.
config.font_size = 13
config.color_scheme = 'wallust'
config.window_background_opacity = {{opacity}}
config.enable_tab_bar = false

config.window_padding = {
  left = 20,
  right = 20,
  top = 20,
  bottom = 20,
}
config.font = wezterm.font_with_fallback { '{{font}}', 'Noto Color Emoji' }
-- config.kde_window_background_blur = true
-- Finally, return the configuration to wezterm:
return config
