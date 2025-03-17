-- TODO: Create a keybind to bring up a virtual terminal that has started a dune utop session
-- TODO: Create code action to make a symbol public through its module file
-- TODO: Keybind for dune build (should notify me with vim.notify of the result)

vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

local map = require("helpers.misc").map
local comp = require("helpers.compiler")

map("n", "<leader><leader><return>", comp.dune_cont_builder,"Start Dune Builder")
