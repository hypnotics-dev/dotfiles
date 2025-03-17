local helper = require("helpers.misc")
local map = helper.map

map("n", "<leader><leader>e", ".lua<CR>", "[C]ode [E]val (Lua)")
map("n", "<leader><leader>E", ":source %<CR>", "[C]ode [E]val (Lua)")
map("v", "<leader><leader>e", ":lua<CR>", "[C]ode [E]val (Lua)")
