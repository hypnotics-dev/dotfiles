return {
  cmd = { "clangd" },
  root_markers = { ".clangd", "compile_commands.json" },
  file_types = { "c", "cpp", "cc", "cxx", "h", "hxx", "hpp" },
  on_attach = function() end,
  on_init = function() end,
}
