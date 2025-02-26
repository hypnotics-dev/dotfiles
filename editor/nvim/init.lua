require('config.settings')

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { import = "plug" },
  },
  checker = { enabled = true },
})

local lsp = require("helpers.lsp")

vim.lsp.config('*', {
  capabilities = lsp.get_lsp_snippets({
    textDocument = {
      semanticTokens = {
        multilineTokenSupport = true, }
    }
  }),
  root_markers = { '.git' },
})

-- Plugs
-- https://github.com/stevearc/quicker.nvim
--
-- flash.nvim
-- treesj
