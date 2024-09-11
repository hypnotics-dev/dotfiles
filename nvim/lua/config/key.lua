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
map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show [E]rror messages" })
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open [Q]uickfix list" })

-- File I/O stuff
map(ni, "<C-x><C-s>", "<cmd>w<CR>", { desc = "[S]ave file", silent = true })
map('n', "<leader>fs", "<cmd>w<CR>", { desc = "[F]ile [S]ave", silent = true })
map("n", "<leader>wc", "<cmd>bd<CR>", { desc = "[C]lose Buffer" })
map("n", "<leader>fn", '<cmd>new<CR>', { desc = '[F]ile [N]ew' })

-- Change term exit keybind
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit Terminal Mode" })

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
end, { silent = true, desc = "Treesitter [j]ump to context" })

-- Harpoon keybinds
local harpoon = require("harpoon")

map("n", "<leader>wa", function()
    harpoon:list():add()
end, { desc = "Harpoon [A]dd" })

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

map("n", "<leader>wn", function()
    harpoon:list():prev()
end, { desc = "Harpoon [N]ext buffer" })
map("n", "<leader>wp", function()
    harpoon:list():next()
end, { desc = "Harpoon [P]revious buffer" })

-- Toggle Zen mode
map("n", "<leader>wz", "<cmd>ZenMode<CR>", { desc = "Toggle ZenMode On/Off" })

-- Invoke oil
map("n", "<leader>fo", "<cmd>Oil<CR>", { desc = "Open [O]il" })

-- todo comments insert
map("n", "<leader>cct", "oTODO: <cmd>normal gccA<CR> ", { desc = "Add [T]ODO" })
map("n", "<leader>ccf", "oFIXME: <cmd>normal gccA<CR> ", { desc = "Add [F]IXME" })
map("n", "<leader>ccb", "oBUG: <cmd>normal gccA<CR> ", { desc = "Add [B]UG" })
map("n", "<leader>ccn", "oNOTE: <cmd>normal gccA<CR> ", { desc = "Add [N]OTE" })
map("n", "<leader>cch", "oHACK: <cmd>normal gccA<CR> ", { desc = "Add [H]ACK" })
map("n", "<leader>ccp", "oPERF: <cmd>normal gccA<CR> ", { desc = "Add [P]ERF" })
map("n", "<leader>cce", "oTEST: <cmd>normal gccA<CR> ", { desc = "Add T[E]ST" })
map("n", "<leader>ccw", "oWARN: <cmd>normal gccA<CR> ", { desc = "Add [W]ARN" })

-- Move.nvim
map('n', '<A-j>', '<cmd>MoveLine(1)<CR>', { desc = "Move line up", silent = true, })
map('n', '<A-k>', '<cmd>MoveLine(-1)<CR>', { desc = "Move line down", silent = true, })
map('n', '<A-h>', '<cmd>MoveWord(-1)<CR>', { desc = "Move word left", silent = true, })
map('n', '<A-l>', '<cmd>MoveWord(1)<CR>', { desc = "Move word right", silent = true, })
map('v', '<A-j>', '<cmd>MoveBlock(1)<CR>', { desc = "Move line up", silent = true, })
map('v', '<A-k>', '<cmd>MoveBlock(-1)<CR>', { desc = "Move line down", silent = true, })
map('v', '<A-h>', '<cmd>MoveWord(-1)<CR>', { desc = "Move word left", silent = true, })
map('v', '<A-l>', '<cmd>MoveWord(1)<CR>', { desc = "Move word right", silent = true, })

map('n', '<leader>wcp', '<cmd>colorscheme palenight<CR>', { desc = "Swap to palenight" })
