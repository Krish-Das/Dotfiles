local c = {}
local wezterm = require("wezterm")
if wezterm.config_builder then
  c = wezterm.config_builder()
end

-- set different shell e.g.: fish
-- config.default_prog = { "/run/current-system/sw/bin/fish", "--interactive" }

c.term = "wezterm"

c.font_size = 13
-- config.line_height = 1.15
c.font = wezterm.font("JetBrainsMono Nerd Font")
c.harfbuzz_features = { "calt=0", "ss01=1", "zero" }
c.freetype_load_target = "HorizontalLcd" -- "Light" -- HorizontalLcd
c.freetype_render_target = "HorizontalLcd"
c.freetype_load_flags = "NO_HINTING|NO_AUTOHINT"

c.window_background_opacity = 1
c.window_padding = { left = 2, right = 1, top = 1, bottom = 1 }
c.cursor_thickness = 2
c.window_close_confirmation = "NeverPrompt"

---@diagnostic disable-next-line: unused-local
local schemes = { "Tokyo Night", "ChallengerDeep", "GitHub Dark" }
c.color_scheme = schemes[2] -- one indexed
c.colors = {
  background = "#030712",
  -- background = "black",
  -- cursor_bg = "#DC322F",
  -- cursor_fg = "#fedad5",
}

c.keys = { { key = "L", mods = "CTRL|SHIFT", action = wezterm.action.ShowLauncher } }
c.scrollback_lines = 10000
c.hide_tab_bar_if_only_one_tab = true
c.unicode_version = 14

return c
