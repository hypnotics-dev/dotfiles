local augroup = vim.api.nvim_create_augroup("custom-term-autocmds", {clear = true})
local term = require("helpers.term")

vim.api.nvim_create_autocmd("TermOpen", {
  group = augroup,
  callback = function (args)
    vim.opt.number = false
    vim.opt.relativenumber = false
  end
})
