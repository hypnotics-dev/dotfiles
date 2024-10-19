-- TODO: Add rust convenience snippets
-- TODO: Add telescope function for broswing tabs

return {
    rust = {
        wrap = function(key, wrapper, delim, desc)
            vim.keymap.set('n', string.format('<leader>cs%s', key), string.format('lbcw%s<C-c>pa%s<C-c>', wrapper, delim),
                { desc = desc })
        end,
    },
    telescope = {

    },
}
