local helper = require("helpers.misc")
local map = helper.map

map("n", "<A-j>", ":cnext<CR>", "QuickFix List Next")
map("n", "<A-k>", ":cprev<CR>", "QuickFix List Previous")
map("n", "<A-n>", ":lnext<CR>", "Location List Next")
map("n", "<A-p>", ":lprev<CR>", "Location List Previous")
