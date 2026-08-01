-- WezTerm as a dumb, frameless window.
-- tmux owns sessions, windows, tabs and panes; wezterm owns nothing but pixels.

local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Normal KDE title bar (drag + close buttons); tmux still owns tabs/panes.
config.window_decorations = "TITLE|RESIZE"
config.enable_tab_bar = false
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
config.window_close_confirmation = "NeverPrompt"
config.audible_bell = "Disabled"
config.window_background_opacity = 1.0

-- Font
config.font = wezterm.font_with_fallback({
  "MesloLGS Nerd Font",
  "Noto Sans Mono",
})
config.font_size = 12.0
config.line_height = 1.2

-- Colors
config.color_scheme = "Tokyo Night"

-- Cursor & scrollback (tmux keeps its own; this is just the outer buffer)
config.default_cursor_style = "BlinkingBlock"
config.cursor_blink_rate = 500
config.scrollback_lines = 100000

-- Hands stay on the keyboard.
config.hide_mouse_cursor_when_typing = true

-- Drop wezterm's built-in tab/pane bindings entirely; those belong to tmux.
-- Everything not listed below passes straight through to the terminal.
config.disable_default_key_bindings = true
config.keys = {
  { key = "Enter", mods = "ALT", action = wezterm.action.ToggleFullScreen },
  { key = "c", mods = "CTRL|SHIFT", action = wezterm.action.CopyTo("ClipboardAndPrimarySelection") },
  { key = "v", mods = "CTRL|SHIFT", action = wezterm.action.PasteFrom("Clipboard") },
  -- Font size: bind both the plain and shifted forms of each key, since
  -- default bindings are disabled and nothing falls back.
  { key = "=", mods = "CTRL", action = wezterm.action.IncreaseFontSize },
  { key = "+", mods = "CTRL", action = wezterm.action.IncreaseFontSize },
  { key = "+", mods = "CTRL|SHIFT", action = wezterm.action.IncreaseFontSize },
  { key = "-", mods = "CTRL", action = wezterm.action.DecreaseFontSize },
  { key = "_", mods = "CTRL|SHIFT", action = wezterm.action.DecreaseFontSize },
  { key = "0", mods = "CTRL", action = wezterm.action.ResetFontSize },
}

-- When launched from the KDE menu, wezterm inherits the systemd user PATH,
-- which has no ~/.local/bin. Put it back for everything wezterm spawns...
local home = os.getenv("HOME") or ""
config.set_environment_variables = {
  PATH = home .. "/.local/bin:" .. (os.getenv("PATH") or ""),
}

-- ...and spawn tmux by absolute path, since default_prog is resolved before
-- the above applies. Attaches to the existing session if there is one.
config.default_prog = { home .. "/.local/bin/tmux", "new-session", "-A", "-s", "main" }

return config
