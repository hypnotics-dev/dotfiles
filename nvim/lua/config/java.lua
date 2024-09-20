-- Configuration file to be loaded whenever a java file is edited

local M = {}

local mason_path_jdtls = vim.fn.stdpath("data") .. "/mason/packages/jdtls/plugins/"
local mason_path_java_debug = vim.fn.stdpath("data") .. "/mason/packages/java-debug-adapter/extension/server/"

local equinox
for file in io.popen("dir " .. mason_path_jdtls .. " /b"):lines() do
    if string.find(file, "launcher_") then
        equinox = mason_path_jdtls .. file
        break
    end
end

local debug_jar
for file in io.popen("dir " .. mason_path_java_debug .. " /b"):lines() do
    if string.find(file, "debug") then
        debug_jar = mason_path_java_debug .. file
        break
    end
end

local data_dir = vim.fn.getcwd() .. "_jdtls_data"
local config_linux = vim.fn.stdpath("data") .. "/mason/packages/jdtls/config_linux"

local config = {
    -- The command that starts the language server
    -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
    cmd = {
        "java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xmx1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens", "java.base/java.util=ALL-UNNAMED",
        "--add-opens", "java.base/java.lang=ALL-UNNAMED",

        "-jar", equinox,
        "-configuration", config_linux,
        "-data", data_dir,
    },

    root_dir = require("jdtls.setup").find_root({ ".git", "gradlew" }),

    -- Here you can configure eclipse.jdt.ls specific settings
    -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
    -- for a list of options
    settings = {
        java = {},
    },

    -- Language server `initializationOptions`
    -- You need to extend the `bundles` with paths to jar files
    -- if you want to use additional eclipse.jdt.ls plugins.
    --
    -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
    --
    -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
    init_options = {
        bundles = {
            vim.fn.glob(debug_jar, true),
        },
    },
}

local function getConfig()
    return config
end

M.getConfig = getConfig


return M
