-- OPTIONS ---------------------------------------------------------------------
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 0

-- Gradle Options --------------------------------------------------------------
local helpers = require("helpers.misc")
vim.b.gradle_root = helpers.root_dir({".gradle"})
-- TODO add project specific options
vim.g.gradle_makeprg_params = "build" -- default arg to execute
vim.b.gradle_makeprg_params = nil
--------------------------------------------------------------------------------


