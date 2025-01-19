local augroup = vim.api.nvim_create_augroup("custom-term-autocmds", {clear = true})
local term = require("helpers.term")

vim.api.nvim_create_autocmd("TermOpen", {
  group = augroup,
  callback = function (args)
    vim.opt.number = false
    vim.opt.relativenumber = false
  end
})

vim.api.nvim_create_autocmd("TermClose", {
  group = augroup,
  buffer = term.data.bufnr,
  callback = function (args)
    term.data.job_id = nil
    term.data.bufnr = nil
  end
})
