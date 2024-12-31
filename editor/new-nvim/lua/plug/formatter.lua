-- https://github.com/stevearc/conform.nvim
--
-- TODO: stylua
--
-- Install formatter on system
-- Configure to read opts from a file or default
--
-- TODO: google-java-format
--
-- Install formatter on system
--
-- TODO: clang-format
--
-- Install formatter on system
-- Configure to read opts from a file or default
--
-- TODO: nixfmt
--
-- Install formatter on system
--
-- TODO: rustfmt
--
-- Install formatter on system
-- Configure to read opts from a file or default
--
return {
  {
    "stevearc/conform.nvim", -- replace with vim.lsp.buf.format
    opts = {
      formatter_by_ft = {
        -- TODO: Install stylua,google-java-format,clang-format,nixfmt and rustfmt
        lua = { "stylua" },
        java = { "google-java-format" },
        rust = { "rustfmt", lsp_format = "fallback" },
        c = { "clang-format" },
        cpp = { "clang-format" },
        nix = { "nixfmt" },
        -- TODO: Not sure if I want to use this, will investigate other spell check options as well
        --
        -- ["*"] = {"codespell"},
      },
      default_format_opts = {
        lsp_format = "fallback"
      },
      log_level = vim.log.levels.ERROR,
      notify_on_error = true,
      notify_no_formatters = false,
    },
  },
}
