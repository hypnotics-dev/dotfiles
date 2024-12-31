return {
  {
    "mfussenegger/nvim-jdtls",
    ft = { "java" },
    config = function()
      local config = {
        -- The command that starts the language server
        -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
        cmd = {

          'java',

          '-Declipse.application=org.eclipse.jdt.ls.core.id1',
          '-Dosgi.bundles.defaultStartLevel=4',
          '-Declipse.product=org.eclipse.jdt.ls.core.product',
          '-Dlog.protocol=true',
          '-Dlog.level=ALL',
          '-Xmx1g',
          '--add-modules=ALL-SYSTEM',
          '--add-opens', 'java.base/java.util=ALL-UNNAMED',
          '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

          '-jar', function()
          local files = vim.fs.find("org.eclipse.equinox.launcher_*.jar",
            { path = "/usr/share/java/jdtls/plugins/", depth = 1 })

          for _, file in ipairs(files) do
            if file:match("org.eclipse.equinox.launcher_.*%.jar$") then
              return file
            end
          end

          vim.notify("Failed to find jdtls jar", vim.log.levels.ERROR)
          return ""
        end,


          '-configuration', '/usr/share/java/jdtls/config_linux',

          -- See `data directory configuration` section in the README
          -- TODO: figure out how to configure this properly

          -- '-data', '/path/to/unique/per/project/workspace/folder'
        },

        root_dir = vim.fs.root(0, { ".git", "mvnw", "gradlew" }),

        -- Here you can configure eclipse.jdt.ls specific settings
        -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
        -- for a list of options
        settings = {
          java = {
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
      }
      require('jdtls').start_or_attach(config)
    end,
  },
}
