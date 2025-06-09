local helpers = require("helpers.misc")
local map = helpers.map
local harp = require("harpoon")

map("n", "<leader>fa", function() harp:list():add() end, "[F]ile [A]dd (harpoon)")
map("n", "<leader>fo", function() harp.ui:toggle_quick_menu(harp:list()) end, "[F]ile [O]pen")
map("n", "<leader>fr", function() harp:list():remove() end, "[F]ile [R]emove")
map("n", "<leader>sH", function() helpers.build_telescope_from_files(harp:list(), "Harpoon") end, "[S]earch [H]arpoon")
