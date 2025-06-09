local lsp = require("helpers.lsp")
return {
  cmd = { "ocamllsp" },
  root_markers = { "dune", "dune-project", "dune-workspace" },
  filetypes = { 'ocaml', 'menhir', 'ocamlinterface', 'ocamllex', 'reason', 'dune' },
  capabilities = lsp.get_lsp_snippets(),
  on_attach = function()
  end,
  on_init = function()
    vim.notify("Merlin has Come", vim.log.levels.INFO)
  end,
}
