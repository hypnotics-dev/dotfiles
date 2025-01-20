-- Highlight text when yanked

local global = require("config.vars")

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' },
    {
        pattern = "*.rs",
        callback = function()
            vim.cmd(string.format("luafile %slua/config/rust.lua", global.sys.confPath))
        end
    })
