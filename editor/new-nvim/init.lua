require('config.settings')
require('config.lazy')
require('config.lsp')
require('config.keymap')

-- Loads all autocmds
vim.cmd('runtime lua/custom/autocmds/*.lua')

-- Plugs
-- https://github.com/stevearc/quicker.nvim
--
-- flash.nvim
-- treesj
