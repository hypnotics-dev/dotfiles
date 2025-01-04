return {
  cmd = { "lua-language-server" },
  root_markers = { ".git", ".editorconfig" },
  filetypes = { "lua" },
  capabilities = {},
  on_attach = function()
  end,
  on_init = function()
    vim.notify("LuaLS Started", vim.log.levels.INFO)
  end,
}
