-- All non plugin related keymaps
local helper = require("helpers.misc")
local map = helper.map

map("n", "<leader>w", ":write<CR>", "[W]rite Buffer")
map("n", "<leader>fc", ":!wl-copy < %<CR>", "[F]ile [C]opy")
map("v", "<leader>rc", '"+yy', "[R]ange [C]opy")
