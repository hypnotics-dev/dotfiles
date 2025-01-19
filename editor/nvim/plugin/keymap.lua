-- All non plugin related keymaps
local helper = require("custom.helpers")
local map = helper.map

map("n", "<leader>w", ":write<CR>", "[W]rite Buffer")
