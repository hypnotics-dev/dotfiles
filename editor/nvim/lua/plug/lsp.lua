return {
  {
    "mfussenegger/nvim-jdtls",
    ft = { "java" },
    config = function()
      local jdtls_path = "/home/hypnotics/.local/share/java/jdtls/"
      -- local jdtls_path = "/usr/share/java/jdtls/"
      local cache = "/home/hypnotics/.cache/jdtls/workspace/"
      local root_dir = require("jdtls.setup").find_root({ ".git", "gradlew", "build.gradle" })

      local workspace_dir = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
      local config = {
        -- The command that starts the language server
        -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
        cmd = {

          '/usr/lib/jvm/java-21-openjdk/bin/java',

          '-Declipse.application=org.eclipse.jdt.ls.core.id1',
          '-Dosgi.bundles.defaultStartLevel=4',
          '-Declipse.product=org.eclipse.jdt.ls.core.product',
          '-Dlog.protocol=true',
          '-Dlog.level=ALL',
          '-Xmx1g',
          '--add-modules=ALL-SYSTEM',
          '--add-opens', 'java.base/java.util=ALL-UNNAMED',
          '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
          '-jar', jdtls_path .. 'plugins/org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar',


          '-configuration', jdtls_path .. 'config_linux/',

          -- See `data directory configuration` section in the README
          -- TODO: figure out how to configure this properly

          "-data", vim.fn.expand('~/.cache/jdtls-workspace/') .. workspace_dir
        },

        root_dir = root_dir,

        -- Here you can configure eclipse.jdt.ls specific settings
        -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
        -- for a list of options
        settings = {
          java = {
            autobuild = { enabled = false },
            configuration = {
            }
          }
        },

        -- Language server `initializationOptions`
        -- You need to extend the `bundles` with paths to jar files
        -- if you want to use additional eclipse.jdt.ls plugins.
        --
        -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
        --
        -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
        init_options = {
          bundles = {}
        },
        on_attach = function(client, bufnr)
          client.handlers["textDocument/publishDiagnostics"] = function() end
        end
      }
      require('jdtls').start_or_attach(config)
    end,
  },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  { -- optional cmp completion source for require statements and module annotations
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, {
        name = "lazydev",
        group_index = 0, -- set group index to 0 to skip loading LuaLS completions
      })
    end,
  },
}
