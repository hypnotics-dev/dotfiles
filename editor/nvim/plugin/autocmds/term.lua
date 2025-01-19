local augroup = vim.api.nvim_create_augroup("custom-term-autocmds", {clear = true})

vim.api.nvim_create_autocmd("TermOpen", {
  group = augroup,
  callback = function (args)
    vim.opt.number = false
    vim.opt.relativenumber = false
  end
})

vim.api.nvim_create_autocmd("TermClose", {
  group = augroup,
  buffer = vim.t.term_bufnr,
  callback = function (args)
    vim.t.jobs = nil
    vim.t.term_bufnr = nil
  end
})
