local lsp = require("helpers.lsp")
return {
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  root_markers = { "Cargo.toml" },
  on_attach = function() end,
  capabilities = lsp.get_lsp_snippets(),
  on_init = function()
    vim.notify("Rust_Analyzer Started", vim.log.levels.INFO)
  end,
}
