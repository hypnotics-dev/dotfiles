-- Enable lsps here
vim.lsp.enable({"luals", "clangd", "jdtls", "rust_analyzer", "bashls"})

vim.lsp.config('*', {capabilities = {textDocument = {semanticTokens = {multilineTokenSupport = true}}}})

-- NOTE: If auto imports unfold the folds, then either create a new autocmd or remove this one
vim.api.nvim_create_autocmd(
  'LspNotify', {
    callback = function(args)
      if args.data.method == 'textDocument/didOpen' then vim.lsp.foldclose('imports', vim.fn.bufwinid(args.buf)) end
    end,
  }
)
