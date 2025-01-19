local helper = require("custom.helpers")
local map = helper.map


map("n", "<leader><CR>",helper.make_small_term , "Open Term")

map("t", "<ESC>", "<C-\\><C-n>", "Return to Normal Mode")
