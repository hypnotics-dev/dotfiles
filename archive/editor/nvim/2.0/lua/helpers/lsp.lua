local M = {}

function M.get_lsp_snippets(remap)
  local cap = vim.lsp.protocol.make_client_capabilities()
  cap.textDocument.completion = require("cmp_nvim_lsp").default_capabilities().textDocument.completion

  if (type(remap) == "table") then
    vim.tbl_deep_extend('force',cap,remap)
  end

  return cap
end

M.autogroups = {
  keymap = vim.api.nvim_create_augroup("hyp/lsp/keymap", {clear=true}),
  folds = vim.api.nvim_create_augroup("hyp/lsp/folds", {clear=true})
}

return M
