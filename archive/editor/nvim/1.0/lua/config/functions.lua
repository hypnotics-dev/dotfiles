-- TODO: Add rust convenience snippets
-- TODO: Add telescope function for broswing tabs

return {
    -- Functions for the rust programming language
    rust = {
        wrap = function(key, wrapper, delim, desc)
            vim.keymap.set('n', string.format('<leader>cs%s', key), string.format('lbcw%s<C-c>pa%s<C-c>', wrapper, delim),
                { desc = desc })
        end,
    },
    telescope = {

    },
    -- File System Functions
    fs = {
        -- Returns the project root as file path, patern defaults to .git
        projectRoot = function(patern)
            patern = patern or ".git"
            return vim.fs.dirname(vim.fs.find(patern, { upward = true })[1])
        end,
    },
}
