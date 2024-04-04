-- Pull in the wezterm API
local wezterm = require("wezterm")
local mux = wezterm.mux
local act = wezterm.action

-- This table will hold the configuration.
local config = {}
local launch_menu = {}
local dimmer = { brightness = 0.04 }

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- Spawn a powershell in login mode
config.default_prog = { "pwsh.exe", "-NoLogo" }

table.insert(launch_menu, {
	label = "PowerShell",
	args = { "powershell.exe", "-NoLogo" },
})

table.insert(launch_menu, {
	label = "Pwsh",
	args = { "pwsh.exe", "-NoLogo" },
})

table.insert(launch_menu, {
	label = "Ubuntu",
	args = { "wsl.exe" },
	set_environment_variables = {
		TERM = "xterm-256color",
	},
})

config.window_padding = {
	left = 5,
	right = 0,
	top = 0,
	bottom = 0,
}

config.exit_behavior = "Close"

config.launch_menu = launch_menu

wezterm.on("gui-startup", function(cmd)
	local tab, build_pane, window = mux.spawn_window({
		position = { x = 900, y = 5 },
		workspace = "start",
	})
end)

config.initial_rows = 42
config.initial_cols = 100

--"tokyonight_night" --"Catppuccin Mocha"
--"Shaman (Gogh)" --"Aci (Gogh)"
config.color_scheme = "Catppuccin Mocha"
config.colors = { cursor_fg = "black" }
config.bold_brightens_ansi_colors = true
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"

config.background = {
	{
		source = {
			File = os.getenv("UserProfile") .. "/.config/wezterm/bg-wallpaper.jpg",
		},
		attachment = "Fixed",
		hsb = dimmer,
		vertical_align = "Middle",
		horizontal_align = "Center",
	},
}

config.hide_tab_bar_if_only_one_tab = true

config.line_height = 1.2 -- default font is 12
config.font = wezterm.font_with_fallback({
	"Hack",
	"JetBrains Mono",
	"Fira Code",
})

-- Dim inactive panes
config.inactive_pane_hsb = {
	saturation = 0.7,
	brightness = 0.7,
}

-- on wezterm startup
-- wezterm.on("gui-startup", function(cmd)
-- use this once you are working on a project
-- local args = {}

-- -- setup a workspace for coding on current project
-- local project_dir = "E:/Projects/React/valentine-site"
-- setup initial starting position
-- local tab, build_pane, window = mux.spawn_window({
-- 	position = { x = 900, y = 5 },
-- })

-- -- open another tab for terminal
-- local _, editor_pane, _ = window:spawn_tab({})
--
-- -- open window with 2 split pane for server and console
-- local console_pane = build_pane:split({
-- 	direction = "Top",
-- 	size = 0.5,
-- 	cwd = project_dir,
-- })
--  build_pane:send_text 'npm run dev\n'

-- new workspace
-- local tab, pane, window = mux.spawn_window({
-- 	workspace = "base",
--    cwd = wezterm.home_dir .. '/wezterm',
-- })

-- set startup coding workspace
-- 	mux.set_active_workspace("base")
-- end)

wezterm.on("update-right-status", function(window, pane)
	window:set_right_status(window:active_workspace())
end)

wezterm.on("format-tab-title", function(tab)
	local title = tab.tab_title
	local title_str = ""

	if title and #title > 0 then
		title_str = title
	else
		title_str = tab.active_pane.title
	end

	return string.gsub(title_str, "(.*[/\\])(.*)", "%2")
end)

-- Keys config
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
	-- Send C-a when pressing C-a twice
	{ key = "a", mods = "LEADER|CTRL", action = act.SendKey({ key = "a", mods = "CTRL" }) },
	{ key = "c", mods = "LEADER", action = act.ActivateCopyMode },
	{ key = "phys:Space", mods = "LEADER", action = act.ActivateCommandPalette },

	-- Pane keybindings
	{
		key = '"',
		mods = "LEADER|SHIFT",
		action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "%",
		mods = "LEADER|SHIFT",
		action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},

	-- pane movements
	{ key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
	{ key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
	{ key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
	{ key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },

	-- Tab movements
	{ key = "n", mods = "LEADER", action = act.ActivateTabRelative(1) },
	{ key = "p", mods = "LEADER", action = act.ActivateTabRelative(-1) },

	-- close pane
	{ key = "q", mods = "LEADER", action = act.CloseCurrentPane({ confirm = true }) },
	{ key = "z", mods = "LEADER", action = act.TogglePaneZoomState },
	{ key = "o", mods = "LEADER", action = act.RotatePanes("Clockwise") },

	-- show sessions switcher
	{
		key = "s",
		mods = "LEADER",
		action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }),
	},
	-- Switch workspace relatively
	{
		mods = "LEADER|SHIFT",
		key = "(",
		action = act.SwitchWorkspaceRelative(-1),
	},
	{
		key = ")",
		mods = "LEADER|SHIFT",
		action = act.SwitchWorkspaceRelative(1),
	},

	-- We can make separate keybindings for resizing panes
	-- But Wezterm offers custom "mode" in the name of "KeyTable"
	{
		key = "r",
		mods = "LEADER",
		action = act.ActivateKeyTable({ name = "resize_pane", one_shot = false }),
	},

	-- Create a new tab in same domain
	{
		key = "c",
		mods = "LEADER",
		action = act.SpawnTab("CurrentPaneDomain"),
	},

	-- Rename a tab
	{
		key = "R",
		mods = "LEADER",
		action = act.PromptInputLine({
			description = "Enter new name",
			action = wezterm.action_callback(function(window, _, line)
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},

	-- open wezterm config file
	{
		key = ",",
		mods = "LEADER",
		action = act.SpawnCommandInNewTab({
			cwd = os.getenv("WEZTERM_CONFIG_DIR"),
			set_environment_variables = {
				TERM = "screen-256color",
			},
			args = {
				"nvim",
				os.getenv("WEZTERM_CONFIG_FILE"),
			},
		}),
	},
}

config.key_tables = {
	resize_pane = {
		{ key = "h", action = act.AdjustPaneSize({ "Left", 5 }) },
		{ key = "j", action = act.AdjustPaneSize({ "Down", 5 }) },
		{ key = "k", action = act.AdjustPaneSize({ "Up", 5 }) },
		{ key = "l", action = act.AdjustPaneSize({ "Right", 5 }) },
		{ key = "Escape", action = "PopKeyTable" },
		{ key = "Enter", action = "PopKeyTable" },
	},
	move_tab = {
		{ key = "h", action = act.MoveTabRelative(-1) },
		{ key = "j", action = act.MoveTabRelative(-1) },
		{ key = "k", action = act.MoveTabRelative(1) },
		{ key = "l", action = act.MoveTabRelative(1) },
		{ key = "Escape", action = "PopKeyTable" },
		{ key = "Enter", action = "PopKeyTable" },
	},
}

-- and finally, return the configuration to wezterm
return config
