local aug = require("helpers.lsp")

-- FOLDS
vim.api.nvim_create_autocmd( 'LspNotify', {
  desc = "Folds imports on file open",
  group = aug.autogroups.folds,
  callback = function(args)
    if args.data.method == 'textDocument/didOpen' then vim.lsp.foldclose('imports', vim.fn.bufwinid(args.buf)) end
  end,
  }
)
