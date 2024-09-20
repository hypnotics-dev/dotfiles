-- Ensures that external dependencies are installed
require("ensure-deps")

-- Load pre-plugin settings
require("config.settings")

-- Load plugins
require("lazy").setup({

    require("plug.treesitter"),
    require("plug.lsp"),
    require("plug.debug"),
    require("plug.telescope"),
    require("plug.ui"),
    require("plug.key"),
})

-- Load post-plugin settings
require("config.key")
require("config.theme")
require("config.autocmd")
