vim.api.nvim_create_autocmd('LSPAttach', {
  callback = function (args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    -- if client:supports_method("textDocument/completion") then
    --   vim.lsp.completion.enable(true,client.id, 0,{autotrigger = true})
    -- end
  end

})
