local lsp = require("helpers.lsp")
return {
  cmd = { "lua-language-server" },
  root_markers = { ".git", ".editorconfig" },
  filetypes = { "lua" },
  capabilities = lsp.get_lsp_snippets(),
  on_attach = function()
  end,
  on_init = function()
    vim.notify("LuaLS Started", vim.log.levels.INFO)
  end,
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace",
      },
    },
  }
}
