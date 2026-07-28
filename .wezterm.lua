local wezterm = require("wezterm")
-- local theme = wezterm.plugin.require("https://github.com/neapsix/wezterm").main

local config = wezterm.config_builder()
config.color_scheme = "iTerm2 Dark Background"

-- local HackNf = wezterm.font("Hack Nerd Font Mono")
--Iosevka Nerd Font Mono
-- local CaskaydiaMonoNf = wezterm.font("CaskaydiaMono Nerd Font Mono")
--IosevkaTerm Nerd Font Mono
local IosevkaNf = wezterm.font({
	-- family = "Iosevka Nerd Font Mono",
	family = "IosevkaTerm Nerd Font Mono",
	-- harfbuzz_features = { "calt=0", "liga=0", "dlig=0" },
})

config.font = IosevkaNf
config.font_size = 20
-- config.harfbuzz_features = { "calt=0", "liga=0", "dlig=0" }
config.window_background_opacity = 0.8
config.enable_tab_bar = false

config.keys = {
	{ key = "Enter", mods = "SHIFT", action = wezterm.action({ SendString = "\x1b\r" }) },
	{
		key = "m",
		mods = "CTRL",
		action = wezterm.action.Nop,
	},
}

config.colors = {
	cursor_fg = "#000000",
}

return config
