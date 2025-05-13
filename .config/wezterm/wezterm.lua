local wezterm = require("wezterm")

local config = wezterm.config_builder()

local constants = require("constants")

config.font = wezterm.font("FiraCode Nerd Font")

config.colors = require("cyberdream")
config.line_height = 1.2
config.font_size = 12

config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true
config.window_background_image = constants.bg_image
config.window_background_opacity = 0.9
config.macos_window_background_blur = 10

config.inactive_pane_hsb = {
	saturation = 0.5,
	brightness = 0.2,
}
-- Misc
config.max_fps = 120
config.prefer_egl = true

-- CTRL + SHIFT + P  === command palette
-- Leader is the same as my old tmux prefix
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
	-- splitting
	{
		mods = "LEADER",
		key = "-",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		mods = "LEADER",
		key = "=",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		mods = "LEADER",
		key = "m",
		action = wezterm.action.TogglePaneZoomState,
	},
	{
		key = "c",
		mods = "LEADER",
		action = wezterm.action.ActivateCopyMode,
	},
	{ key = "a", mods = "LEADER", action = wezterm.action.ActivatePaneByIndex(0) },
	{ key = "b", mods = "LEADER", action = wezterm.action.ActivatePaneByIndex(1) },
	{ key = "c", mods = "LEADER", action = wezterm.action.ActivatePaneByIndex(2) },
	{ key = "[", mods = "LEADER", action = wezterm.action.ActivateTabRelative(-1) },
	{ key = "]", mods = "LEADER", action = wezterm.action.ActivateTabRelative(1) },
	{
		key = "x",
		mods = "LEADER",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},
	{
		key = "X",
		mods = "LEADER",
		action = wezterm.action.CloseCurrentTab({ confirm = true }),
	},
}

return config
