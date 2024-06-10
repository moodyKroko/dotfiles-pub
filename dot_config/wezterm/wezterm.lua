-- Pull in the wezterm API
local wezterm = require("wezterm")
local session_manager = require("wezterm-session-manager/session-manager")
local mux = wezterm.mux
local act = wezterm.action

-- functions
local process_icons = {
	["docker"] = wezterm.nerdfonts.linux_docker,
	["docker-compose"] = wezterm.nerdfonts.linux_docker,
	["psql"] = wezterm.nerdfonts.dev_postgresql,
	["kuberlr"] = wezterm.nerdfonts.linux_docker,
	["kubectl"] = wezterm.nerdfonts.linux_docker,
	["stern"] = wezterm.nerdfonts.linux_docker,
	["nvim"] = wezterm.nerdfonts.custom_vim,
	["make"] = wezterm.nerdfonts.seti_makefile,
	["vim"] = wezterm.nerdfonts.dev_vim,
	["go"] = wezterm.nerdfonts.seti_go,
	["zsh"] = wezterm.nerdfonts.dev_terminal,
	["bash"] = wezterm.nerdfonts.cod_terminal_bash,
	["btm"] = wezterm.nerdfonts.mdi_chart_donut_variant,
	["htop"] = wezterm.nerdfonts.mdi_chart_donut_variant,
	["cargo"] = wezterm.nerdfonts.dev_rust,
	["sudo"] = wezterm.nerdfonts.fa_hashtag,
	["lazydocker"] = wezterm.nerdfonts.linux_docker,
	["git"] = wezterm.nerdfonts.dev_git,
	["lua-language-server"] = wezterm.nerdfonts.seti_lua,
	["wget"] = wezterm.nerdfonts.mdi_arrow_down_box,
	["curl"] = wezterm.nerdfonts.mdi_flattr,
	["gh"] = wezterm.nerdfonts.dev_github_badge,
	["ruby"] = wezterm.nerdfonts.cod_ruby,
	["pwsh"] = wezterm.nerdfonts.seti_powershell,
	["node"] = wezterm.nerdfonts.dev_nodejs_small,
	["dotnet"] = wezterm.nerdfonts.md_language_csharp,
}

local function basename(s)
	return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

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

config.window_padding = {
	left = 5,
	right = 0,
	top = 0,
	bottom = 0,
}

config.exit_behavior = "Close"
config.debug_key_events = true

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

config.launch_menu = launch_menu

wezterm.on("gui-startup", function()
	local _, _, _ = mux.spawn_window({
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

config.line_height = 1.2 -- default font is 12
config.font = wezterm.font_with_fallback({
	"Hack",
	"JetBrainsMono Nerd Font",
	"Fira Code",
})

-- Dim inactive panes
config.inactive_pane_hsb = {
	saturation = 0.7,
	brightness = 0.7,
}

config.use_fancy_tab_bar = false
config.status_update_interval = 1000
config.tab_max_width = 60
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true
config.show_new_tab_button_in_tab_bar = false

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local pane = tab.active_pane
	local title = pane.title:match("([^/\\]+).exe$")

	local icon = process_icons[title] or wezterm.nerdfonts.seti_checkbox_unchecked

	local fTitle = string.format(" %s %s", title, icon)

	return wezterm.format({
		{ Text = " " .. fTitle .. " " },
	})
end)

wezterm.on("update-right-status", function(window)
	window:set_right_status(window:active_workspace())
end)

-- session-manager
wezterm.on("save_state", function(window, pane)
	session_manager.save_state(window, pane)
end)

wezterm.on("load_state", function(window)
end)
	session_manager.load_state()

wezterm.on("restore_state", function(window)
	session_manager.restore_state(window)
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

	-- Prompt for a name to use for a new workspace and switch to it
	{
		key = "w",
		mods = "LEADER",
		action = act.PromptInputLine({
			description = wezterm.format({
				{ Attribute = { Intensity = "Bold" } },
				{ Foreground = { AnsiColor = "Fuchsia" } },
				{ Text = "Enter name for new workspace" },
			}),
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					window:perform_action(
						act.SwitchToWorkspace({
							name = line,
						}),
						pane
					)
				end
			end),
		}),
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

	-- save/load/restore sessions
	{ key = "S", mods = "LEADER|SHIFT", action = act({ EmitEvent = "save_state" }) },
	{ key = "L", mods = "LEADER|SHIFT", action = act({ EmitEvent = "load_state" }) },
	{ key = "R", mods = "LEADER|SHIFT", action = act({ EmitEvent = "restore_state" }) },

	-- We can make separate keybindings for resizing panes
	-- But Wezterm offers custom "mode" in the name of "KeyTable"
	{
		key = "r",
		mods = "LEADER|ALT",
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
		key = "r",
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
