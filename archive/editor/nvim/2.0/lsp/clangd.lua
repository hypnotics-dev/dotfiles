return {
  cmd = { "clangd" },
  root_markers = { ".clangd", "compile_commands.json" },
  filetypes = { "c", "cpp", "cc", "cxx", "h", "hxx", "hpp" },
  on_attach = function() end,
  on_init = function()
    vim.notify("Clangd started", vim.log.levels.INFO)
  end,
}
