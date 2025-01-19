-- Keymap
local helpers = require("custom.helpers")
local map = helpers.map
local conf = require("conform")

map("n", "<leader>cf", function() conf.format({ async = true, lsp_format = "fallback", quiet = false, }, nil) end,
  "[C]ode [F]ormat")

map("v", "<leader>cf", function() conf.format({ async = true, lsp_format = "fallback", quiet = false, }, nil) end,
  "[C]ode [F]ormat")
