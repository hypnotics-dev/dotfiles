local helper = require("helpers.misc")
local term = require("helpers.term")
local map = helper.map


map("n", "<leader><CR>", term.make_small_term , "Open Term")

map("t", "<ESC>", "<C-\\><C-n>", "Return to Normal Mode")
