local wezterm = require("wezterm")
-- local theme = wezterm.plugin.require("https://github.com/neapsix/wezterm").main

local config = wezterm.config_builder()
config.color_scheme = "iTerm2 Dark Background"

config.font = wezterm.font("Hack Nerd Font Mono")
-- config.colors = theme.colors()
config.enable_tab_bar = false

config.keys = {
	{ key = "Enter", mods = "SHIFT", action = wezterm.action({ SendString = "\x1b\r" }) },
}

return config
