-- bootstrapping lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)


require("config.settings")
require("config.theme")

require("lazy").setup({

	require("plug.treesitter"),
	require("plug.lsp"),
	require("plug.debug"),
	require("plug.telescope"),
	require("plug.ui"),
	require("plug.key"),
})

require("config.key")
