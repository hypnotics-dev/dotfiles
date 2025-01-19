local helper = require("helpers.misc")
local map = helper.map


map("n", "<leader><CR>",helper.make_small_term , "Open Term")

map("t", "<ESC>", "<C-\\><C-n>", "Return to Normal Mode")
