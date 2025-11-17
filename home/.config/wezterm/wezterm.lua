local wezterm = require("wezterm")
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

config.window_padding = { left = 1, right = 1, top = 1, bottom = 1 }

config.font_size = 11.5
config.font = wezterm.font("JetBrains Mono")
config.harfbuzz_features = { "calt=0", "ss01=1", "zero" }
-- config.freetype_load_flags = "NO_HINTING" -- "NO_HINTING|NO_AUTOHINT"
config.freetype_load_target = "HorizontalLcd" -- "Light" -- HorizontalLcd
config.freetype_render_target = "HorizontalLcd"

config.color_scheme = "Peppermint"
config.window_background_opacity = 0.9

config.scrollback_lines = 10000
config.hide_tab_bar_if_only_one_tab = true
config.unicode_version = 14

return config
