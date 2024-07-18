-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

local ni = { "n", "i" }
local map = function(mode, keys, cmd, opts)
	vim.keymap.set(mode, keys, cmd, opts)
end

-- Diagnostic keymaps
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
-- Set the C-x definition of some of these commands
map(ni, "<C-x>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
map(ni, "<C-x>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Save as a keybind
map(ni, "<C-x><C-s>", "<cmd>w<CR>", { desc = "[S]ave file", silent = true })
map('n', "<leader>fs", "<cmd>w<CR>", { desc = "[F]ile [S]ave", silent = true })

-- Change term exit keybind
map("t", "<C-x>/", "<C-\\><C-n>", { desc = "Exit Terminal Mode" })

map(ni, "<C-x>fc", "<Esc>:Fidget clear<CR>", { desc = "[F]idget [C]lear" })

map("n", "]t", function()
	require("todo-comments").jump_next()
end, { desc = "Next TODO comment" })

map("n", "[t", function()
	require("todo-comments").jump_prev()
end, { desc = "Previous TODO comment" })

map("n", "<leader>st", "<cmd>TodoTelescope<CR>", { desc = "[S]earch [T]odo[T]elescope" })

-- Treesitter make text objects repeatable
local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
map({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
map({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)
map({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
map({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
map({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
map({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })

-- Treesitter jump to context
map("n", "<leader>cj", function()
	require("treesitter-context").go_to_context(vim.v.count1)
end, { silent = true })

-- Harpoon keybinds
local harpoon = require("harpoon")

map("n", "<leader>wa", function()
	harpoon:list():add()
end, { desc = "Harpoon [A]dd" })
-- map(ni, "<C-x>ha", function()
-- 	harpoon:list():add()
-- end, { desc = "[H]arpoon [A]dd" })

map("n", "<A-1>", function()
	harpoon:list():select(1)
end)
map("n", "<A-2>", function()
	harpoon:list():select(2)
end)
map("n", "<A-3>", function()
	harpoon:list():select(3)
end)
map("n", "<A-4>", function()
	harpoon:list():select(4)
end)

-- map(ni, "<C-x>hn", function()
-- 	harpoon:list():prev()
-- end, { desc = "[H]arpoon [N]ext buffer" })
-- map(ni, "<C-x>hp", function()
-- 	harpoon:list():next()
-- end, { desc = "[H]arpoon [P]revious buffer" })
map("n", "<leader>wn", function()
	harpoon:list():prev()
end, { desc = "Harpoon [N]ext buffer" })
map("n", "<leader>wp", function()
	harpoon:list():next()
end, { desc = "Harpoon [P]revious buffer" })

-- Toggle Zen mode
map("n", "<leader>wz", "<cmd>ZenMode<CR>", { desc = "Toggle ZenMode On/Off" })
map(ni, "<C-x>z", "<cmd>ZenMode<CR>", { desc = "Toggle ZenMode On/Off" })

-- TODO: text movement in visual mode

-- Invoke oil
map("n", "<leader>fo", "<cmd>Oil<CR>", { desc = "Open [O]il" })

map("n", "<leader>wc", "<cmd>bd<CR>", { desc = "[C]lose Buffer" })
map("n", "<leader>fn", '<cmd>new<CR>', { desc = '[F]ile [N]ew' })

-- NOTE: for some reason spider requires <cmd> syntax
map({ "o", "x", "n" }, 'e', "<cmd>lua require('spider').motion('e')<CR>", { desc = 'Spider-e' })
map({ "o", "x", "n" }, 'w', "<cmd>lua require('spider').motion('w')<CR>", { desc = 'Spider-w' })
map({ "o", "x", "n" }, 'b', "<cmd>lua require('spider').motion('b')<CR>", { desc = 'Spider-b' })

-- TODO: add key bind to add TODO, FIXME, BUGS, NOTE, HACK, PERF, TEST, WARN
