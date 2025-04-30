local wez = require 'wezterm'
local M = {}

M.colors = require 'ui.theme'

M.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

M.inactive_pane_hsb = {
  saturation = 0.85,
  brightness = 0.8,
}

M.window_background_opacity = 0.9

M.text_background_opacity = 0.85

M.font = wez.font 'Hack Nerd Font Mono'


return M


