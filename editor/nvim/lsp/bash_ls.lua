return {
  cmd = { "bash-language-server" },
  root_markers = { ".git", "*.sh" },
  filetypes = { "bash", "sh", "zsh" },
  on_attach = function()
    vim.notify("Bash language Server Connected", vim.logs.LEVELS.WARN)
  end,
  on_init = function() end,
}
