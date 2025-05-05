-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Window settings
config.window_padding = {
  left = 5,
  right = 5,
  top = 2,
  bottom = 2,
}

-- Font Settings
--
-- config.font = wezterm.font({...})
--
config.font = wezterm.font_with_fallback({
  -- {
  -- 	family = "TX-02",
  -- 	stretch = "Normal",
  -- 	-- harfbuzz_features = { "cv29", "cv30", "ss01", "ss03", "ss06", "ss07", "ss09" },
  -- },
  { family = "JetBrains Mono" },
})
config.font_size = 12

-- config.freetype_load_flags = "NO_HINTING|NO_AUTOHINT"
-- config.freetype_load_target = "Light" -- HorizontalLcd
-- config.freetype_render_target = "HorizontalLcd"

-- Asthetics and colors
config.color_scheme = "Catppuccin Mocha (Gogh)"

config.window_background_opacity = 0.9

-- Behaviour
config.scrollback_lines = 10000
config.hide_tab_bar_if_only_one_tab = true
config.unicode_version = 14

return config
