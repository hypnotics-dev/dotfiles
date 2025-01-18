local helper = require("custom.helpers")
local map = helper.map

map("n", "<leader>ce", ":.lua<CR>", "[C]ode [E]val (Lua)")
map("v", "<leader>ce", ":lua<CR>", "[C]ode [E]val (Lua)")
