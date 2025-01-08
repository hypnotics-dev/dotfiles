-- Enable lsps here

vim.lsp.enable({
  "lua_ls",
  "clangd",
  "rust_analyzer",
  "bash_ls",
})


vim.lsp.config('*', {
  capabilities = {
    textDocument = {
      semanticTokens = {
        multilineTokenSupport = true
      },
      completion = {
        completionItem = {
          commitCharactersSupport = true,
          deprecatedSupport = true,
          insertReplaceSupport = true,
          insertTextModeSupport = {
            valueSet = { 1, 2 }
          },
          labelDetailsSupport = true,
          preselectSupport = true,
          resolveSupport = {
            properties = { "documentation", "additionalTextEdits", "insertTextFormat", "insertTextMode", "command" }
          },
          snippetSupport = true,
          tagSupport = {
            valueSet = { 1 }
          }
        },
        completionList = {
          itemDefaults = { "commitCharacters", "editRange", "insertTextFormat", "insertTextMode", "data" }
        },
        contextSupport = true,
        dynamicRegistration = false,
        insertTextMode = 1
      },
    },
  },
})


-- NOTE: If auto imports unfold the folds, then either create a new autocmd or remove this one
vim.api.nvim_create_autocmd(
  'LspNotify', {
    callback = function(args)
      if args.data.method == 'textDocument/didOpen' then vim.lsp.foldclose('imports', vim.fn.bufwinid(args.buf)) end
    end,
  }
)



