local wezterm = require 'wezterm'
local act = wezterm.action
local config = wezterm.config_builder()

-- Show which key table is active in the status area ???????
wezterm.on('update-right-status', function(window, _)
  local name = window:active_key_table()
  if name then
    name = 'TABLE: ' .. name
  end
  window:set_right_status(name or '')
end)

config.inactive_pane_hsb = {
  saturation = 0.9,
  brightness = 0.8
}

config.window_background_opacity = 0.75
config.color_scheme = 'Aardvark Blue'
config.enable_tab_bar = false

config.leader = {key = 'Space', mods = 'CTRL'}
config.keys = require 'keys'

return config
