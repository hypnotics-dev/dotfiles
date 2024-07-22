-- Setting the mapleader
vim.g.mapleader = " "
vim.g.maplocalleader = " " -- not sure what this would be used for

-- We have nerd fonts
vim.g.have_nerd_font = true

-- Set tab settings
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

-- Set line numbers to relative
vim.opt.relativenumber = true

-- Allow for the mouse in nvim
vim.opt.mouse = "a"

-- We show the mode with lualine so we don't need nvim to do it
vim.opt.showmode = false

-- Allow for system clipboard to be used in nvim
vim.opt.clipboard = "unnamedplus"

-- disallow for the preservation of indents in line wraps, because we won't use line wraps
vim.opt.breakindent = false

-- Settings for no word wrapping and side scrolling
vim.opt.wrap = false
vim.o.sidescroll = 1 -- sidescroll will move X chars in the specified direction

-- Allows for an undo file to be created, important for viewing undo history and preserving undo
-- history
vim.opt.undofile = true
-- vim.opt.undodir = -- sets the location for the undo file

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep the signcolumn active at all times for lsp errors and breakpoints
vim.opt.signcolumn = "yes"

-- Set update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 800


-- Set split directions
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.list = true
vim.opt.listchars = { tab = "» ", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 20

-- Unset the C-x keybind

vim.keymap.set("n", "<C-A>", "<C-x>")
