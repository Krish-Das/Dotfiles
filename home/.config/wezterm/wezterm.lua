local wezterm = require("wezterm")
local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.font_size = 12
config.line_height = 1
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.harfbuzz_features = { "calt=0", "ss01=1", "zero" }
config.freetype_load_target = "HorizontalLcd" -- "Light" -- HorizontalLcd
config.freetype_render_target = "HorizontalLcd"
config.freetype_load_flags = "NO_HINTING|NO_AUTOHINT"

config.window_background_opacity = 0.95
config.window_padding = { left = 2, right = 1, top = 1, bottom = 1 }
config.cursor_thickness = 2

-- config.color_scheme = "Rosé Pine (Gogh)"
-- config.color_scheme = "Catppuccin Macchiato"
config.color_scheme = "Tokyo Night"
config.colors = {
  background = "black",
  -- cursor_bg = "#DC322F",
  -- cursor_fg = "#fedad5",
}

config.scrollback_lines = 10000
config.hide_tab_bar_if_only_one_tab = true
config.unicode_version = 14

return config
