local wezterm = require("wezterm")
local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.font = wezterm.font_with_fallback({
	{ family = "TX-02" },
	{ family = "JetBrainsMono Nerd Font" },
})
config.color_scheme = "Catppuccin Mocha"

config.window_decorations = "NONE"
config.hide_tab_bar_if_only_one_tab = true
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

config.max_fps = 120
config.animation_fps = 120

return config
