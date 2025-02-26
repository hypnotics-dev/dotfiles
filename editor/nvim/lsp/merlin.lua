local lsp = require("helpers.lsp")
return {
  cmd = { "ocamllsp" },
  root_markers = { "dune" },
  filetypes = { 'ocaml', 'menhir', 'ocamlinterface', 'ocamllex', 'reason', 'dune' },
  capabilities = lsp.get_lsp_snippets(),
  on_attach = function()
  end,
  on_init = function()
    vim.notify("Merlin Started", vim.log.levels.INFO)
  end,
}
