-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = "Dracula+"

config.hide_tab_bar_if_only_one_tab = true

config.window_decorations = "RESIZE"

config.initial_cols = 100

config.initial_rows = 30

config.window_close_confirmation = "NeverPrompt"

config.tab_bar_at_bottom = true

config.font_size = 14.5

config.use_fancy_tab_bar = true

-- config.window_padding = {
-- 	left = 0,
-- 	right = 0,
-- 	top = 0,
-- 	bottom = 0,
-- }

config.window_frame = {
	active_titlebar_bg = "#222437",
	font = wezterm.font({ family = "Roboto", weight = "Bold" }),
	font_size = 13.0,
}
config.colors = {
	tab_bar = {
		-- The color of the strip that goes along the top of the window
		-- (does not apply when fancy tab bar is in use)
		background = "#222437",

		-- The active tab is the one that has focus in the window
		active_tab = {
			-- The color of the background area for the tab
			bg_color = "#77ABFF",
			-- The color of the text for the tab
			fg_color = "#1B1D2C",

			-- Specify whether you want "Half", "Normal" or "Bold" intensity for the
			-- label shown for this tab.
			-- The default is "Normal"
			intensity = "Normal",

			-- Specify whether you want "None", "Single" or "Double" underline for
			-- label shown for this tab.
			-- The default is "None"
			underline = "None",

			-- Specify whether you want the text to be italic (true) or not (false)
			-- for this tab.  The default is false.
			italic = false,

			-- Specify whether you want the text to be rendered with strikethrough (true)
			-- or not for this tab.  The default is false.
			strikethrough = false,
		},

		-- Inactive tabs are the tabs that do not have focus
		inactive_tab = {
			bg_color = "#394264",
			fg_color = "#77ABFF",

			-- The same options that were listed under the `active_tab` section above
			-- can also be used for `inactive_tab`.
		},
	},
}

-- Rebind the command key
local function is_vim(pane)
	local is_vim_env = pane:get_user_vars().IS_NVIM == "true"
	if is_vim_env == true then
		return true
	end
	-- This gsub is equivalent to POSIX basename(3)
	-- Given "/foo/bar" returns "bar"
	-- Given "c:\\foo\\bar" returns "bar"
	local process_name = string.gsub(pane:get_foreground_process_name(), "(.*[/\\])(.*)", "%2")
	return process_name == "nvim" or process_name == "vim"
end

--- cmd+keys that we want to send to neovim.
local super_vim_keys_map = {
	s = utf8.char(0xAA),
	x = utf8.char(0xAB),
	b = utf8.char(0xAC),
	["."] = utf8.char(0xAD),
	o = utf8.char(0xAF),
	["/"] = utf8.char(0xB0),
}

local function bind_super_key_to_vim(key)
	return {
		key = key,
		mods = "CMD",
		action = wezterm.action_callback(function(win, pane)
			local char = super_vim_keys_map[key]
			if char and is_vim(pane) then
				-- pass the keys through to vim/nvim
				win:perform_action({
					SendKey = { key = char, mods = nil },
				}, pane)
			else
				win:perform_action({
					SendKey = {
						key = key,
						mods = "CMD",
					},
				}, pane)
			end
		end),
	}
end

config.keys = {
	bind_super_key_to_vim("s"),
	bind_super_key_to_vim("b"),
	bind_super_key_to_vim("/"),
	-- toggles a vertical terminal
	{
		key = "F12",
		action = wezterm.action_callback(function(_, pane)
			local tab = pane:tab()
			local panes = tab:panes_with_info()
			if #panes == 1 then
				pane:split({
					direction = "Bottom",
					size = 0.3,
				})
			elseif not panes[1].is_zoomed then
				panes[1].pane:activate()
				tab:set_zoomed(true)
			elseif panes[1].is_zoomed then
				tab:set_zoomed(false)
				panes[2].pane:activate()
			end
		end),
	},
	-- enter backtick with Option + `
	{
		key = "`",
		mods = "OPT",
		action = wezterm.action_callback(function(_, pane)
			pane:send_text("`")
		end),
	},
}

-- Return the Tab's current working directory
local function get_cwd(tab)
	return tab.active_pane.current_working_dir.file_path or ""
end

-- Remove all path components and return only the last value
local function remove_abs_path(path)
	return path:gsub("(.*[/\\])(.*)", "%2")
end

-- Return the pretty path of the tab's current working directory
local function tab_title(tab)
	local current_dir = get_cwd(tab)
	local home = os.getenv("HOME")
	local title = current_dir == home and "~" or remove_abs_path(current_dir)
	return tab.tab_index + 1 .. ": " .. title
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	return tab_title(tab)
end)

-- and finally, return the configuration to wezterm
return config
