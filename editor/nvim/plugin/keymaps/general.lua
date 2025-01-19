-- All non plugin related keymaps
local helper = require("helpers.misc")
local map = helper.map

map("n", "<leader>w", ":write<CR>", "[W]rite Buffer")
