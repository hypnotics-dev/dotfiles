-- Globals
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.have_nerd_font = true

-- Tab options
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

-- Line number
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.showmode = false

vim.opt.breakindent = false
vim.opt.wrap = false
vim.o.sidescroll = 1 -- sidescroll will move X chars in the specified direction

vim.opt.scrolloff = 5

vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = "yes"

vim.opt.updatetime = 250
vim.opt.timeoutlen = 250

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.list = true
vim.opt.listchars = { tab = "» ", nbsp = "␣", lead = "." }
vim.opt.showtabline = 0

vim.opt.background = "dark"

vim.g.no_ocaml_maps = 1

vim.lsp.enable({
  "lua_ls",
  "clangd",
  "rust_analyzer",
  "bash_ls",
  "merlin",
})
