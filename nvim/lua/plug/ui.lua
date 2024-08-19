return {
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
    },
    "HiPhish/rainbow-delimiters.nvim",

    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        config = function()
            local highlight = {
                "RainbowRed",
                "RainbowYellow",
                "RainbowBlue",
                "RainbowOrange",
                "RainbowGreen",
                "RainbowViolet",
                "RainbowCyan",
            }
            local hooks = require "ibl.hooks"
            -- create the highlight groups in the highlight setup hook, so they are reset
            -- every time the colorscheme changes
            hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
                vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
                vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
                vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
                vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
                vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
                vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
                vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
            end)

            require("ibl").setup {
                indent = { highlight = highlight },
                scope = { enabled = false, },
                exclude = {
                    buftypes = {
                        "terminal",
                        "nofile",
                        "quickfix",
                        "prompt",
                    },
                    filetypes = {
                        "dashboard",
                        "lspinfo",
                        "packer",
                        "checkhealth",
                        "help",
                        "man",
                        "gitcommit",
                        "Telescope Prompt",
                        "Telescope Result",
                        "yaml",
                    },
                },

            }
        end
    },

    {
        "folke/zen-mode.nvim",
        opts = {
            window = {
                width = 250,
            },
            plugins = {
                todo = { enabled = true },
            },
        },
    },
    {
        "stevearc/oil.nvim",
        dependencies = { "echasnovski/mini.icons" },
        opts = {
            -- Oil will take over directory buffers (e.g. `vim .` or `:e src/`)
            -- Set to false if you want some other plugin (e.g. netrw) to open when you edit directories.
            default_file_explorer = true,
            -- Id is automatically added at the beginning, and name at the end
            -- See :help oil-columns
            columns = {
                "icon",
                -- "permissions",
                "size",
                -- "mtime",
            },
            -- Buffer-local options to use for oil buffers
            buf_options = {
                buflisted = false,
                bufhidden = "hide",
            },
            -- Window-local options to use for oil buffers
            win_options = {
                wrap = false,
                signcolumn = "no",
                cursorcolumn = false,
                foldcolumn = "0",
                spell = false,
                list = false,
                conceallevel = 3,
            },
            -- :help oil.skip_confirm_for_simple_edits
            skip_confirm_for_simple_edits = false,
            prompt_save_on_select_new_entry = true,
            cleanup_delay_ms = false, --removed oil buffer on timer
            lsp_file_methods = {
                timeout_ms = 1000,
                autosave_changes = false,
            },
            -- Constrain the cursor to the editable parts of the oil buffer
            constrain_cursor = "editable",
            watch_for_changes = true,
            -- See :help oil-actions for a list of all available actions
            keymaps = {
                ["g?"] = "actions.show_help",
                ["<CR>"] = "actions.select",
                ["<C-s>"] = {
                    "actions.select",
                    opts = { vertical = true },
                    desc = "Open the entry in a vertical split",
                },
                ["<C-h>"] = {
                    "actions.select",
                    opts = { horizontal = true },
                    desc = "Open the entry in a horizontal split",
                },
                ["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open the entry in new tab" },
                ["<C-p>"] = "actions.preview",
                ["<C-o>"] = "actions.close",
                ["<C-l>"] = "actions.refresh",
                ["-"] = "actions.parent",
                ["_"] = "actions.open_cwd",
                ["`"] = "actions.cd",
                ["~"] = { "actions.cd", opts = { scope = "tab" }, desc = ":tcd to the current oil directory" },
                ["gs"] = "actions.change_sort",
                ["gx"] = "actions.open_external",
                ["g."] = "actions.toggle_hidden",
                ["g\\"] = false,
            },
            -- Set to false to disable all of the above keymaps
            use_default_keymaps = false,
            view_options = {
                -- Show files and directories that start with "."
                show_hidden = false,
                -- This function defines what is considered a "hidden" file
                is_hidden_file = function(name, bufnr)
                    return vim.startswith(name, ".")
                end,
                -- This function defines what will never be shown, even when `show_hidden` is set
                is_always_hidden = function(name, bufnr)
                    return false
                end,
                natural_order = true,
                case_insensitive = false,
                sort = {
                    { "type", "asc" },
                    { "name", "asc" },
                },
            },
            -- Configuration for the floating window in oil.open_float
            float = {
                -- Padding around the floating window
                padding = 2,
                max_width = 0,
                max_height = 0,
                border = "rounded",
                win_options = {
                    winblend = 0,
                },
                -- preview_split: Split direction: "auto", "left", "right", "above", "below".
                preview_split = "auto",
                -- This is the config that will be passed to nvim_open_win.
                -- Change values here to customize the layout
                override = function(conf)
                    return conf
                end,
            },
            -- Configuration for the actions floating preview window
            preview = {
                -- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
                -- min_width and max_width can be a single value or a list of mixed integer/float types.
                -- max_width = {100, 0.8} means "the lesser of 100 columns or 80% of total"
                max_width = 0.9,
                -- min_width = {40, 0.4} means "the greater of 40 columns or 40% of total"
                min_width = { 40, 0.4 },
                -- optionally define an integer/float for the exact width of the preview window
                width = nil,
                -- Height dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
                -- min_height and max_height can be a single value or a list of mixed integer/float types.
                -- max_height = {80, 0.9} means "the lesser of 80 columns or 90% of total"
                max_height = 0.9,
                -- min_height = {5, 0.1} means "the greater of 5 columns or 10% of total"
                min_height = { 5, 0.1 },
                -- optionally define an integer/float for the exact height of the preview window
                height = nil,
                border = "rounded",
                win_options = {
                    winblend = 0,
                },
                -- Whether the preview window is automatically updated when the cursor is moved
                update_on_cursor_moved = true,
            },
            -- Configuration for the floating progress window
            progress = {
                max_width = 0.9,
                min_width = { 40, 0.4 },
                width = nil,
                max_height = { 10, 0.9 },
                min_height = { 5, 0.1 },
                height = nil,
                border = "rounded",
                minimized_border = "none",
                win_options = {
                    winblend = 0,
                },
            },
            -- Configuration for the floating SSH window
            ssh = {
                border = "rounded",
            },
            -- Configuration for the floating keymaps help window
            keymaps_help = {
                border = "rounded",
            },
        },
    },
    {
        "Tsuzat/NeoSolarized.nvim",
        opts = {
            style = "dark",         -- "dark" or "light"
            transparent = true,     -- true/false; Enable this to disable setting the background color
            terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
            enable_italics = true,  -- Italics for different hightlight groups (eg. Statement, Condition, Comment, Include, etc.)
            styles = {
                -- Style to be applied to different syntax groups
                comments = { italic = true },
                keywords = { bold = true },
                functions = { bold = true, italic = true },
                variables = {},
                string = { italic = true },
                underline = true, -- true/false; for global underline
                undercurl = true, -- true/false; for global undercurl
            },
            -- Add specific hightlight groups
            on_highlights = function(highlights, colors)
                highlights.Include.fg = colors.red -- Using `red` foreground for Includes
            end,
        },
    },
    {
        "folke/tokyonight.nvim",
        opts = {
            style = "night",
            transparent = false,
            terminal_colors = true,
            styles = {
                comments = { italic = true },
                keywords = { bold = true },
                functions = { bold = true, italic = true },
                variables = {},
                string = { italic = true, },
                -- Background styles. Can be "dark", "transparent" or "normal"
                sidebars = "dark", -- style for sidebars, see below
                floats = "dark",   -- style for floating windows
            },
            dim_inactive = true,
        },
    },
    {
        'nvimdev/dashboard-nvim',
        -- TODO: Add locations to jump to instead of projects, also ad options for create file here and create tmp file.
        event = 'VimEnter',
        opts = {
            theme = 'hyper',
            config = {},           --  config used for theme
            hide = {
                statusline = true, -- hide statusline default is true
                tabline = true,    -- hide the tabline
                winbar = true,     -- hide winbar
            },
        },
        dependencies = { { 'nvim-tree/nvim-web-devicons' } }
    },
    {
        'lewis6991/gitsigns.nvim',
        event = "VimEnter",
        init = function()
            require('gitsigns').setup {
                signs                        = {
                    add          = { text = '+' },
                    change       = { text = '~' },
                    delete       = { text = '_' },
                    topdelete    = { text = '‾' },
                    changedelete = { text = '-' },
                    untracked    = { text = '┆' },
                },
                signs_staged                 = {
                    add          = { text = '+' },
                    change       = { text = '~' },
                    delete       = { text = '_' },
                    topdelete    = { text = '‾' },
                    changedelete = { text = '-' },
                    untracked    = { text = '┆' },
                },
                signs_staged_enable          = true,
                signcolumn                   = true,  -- Toggle with `:Gitsigns toggle_signs`
                numhl                        = true,  -- Toggle with `:Gitsigns toggle_numhl`
                linehl                       = false, -- Toggle with `:Gitsigns toggle_linehl`
                word_diff                    = false, -- Toggle with `:Gitsigns toggle_word_diff`
                watch_gitdir                 = {
                    follow_files = true
                },
                auto_attach                  = true,
                attach_to_untracked          = false,
                current_line_blame           = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
                current_line_blame_opts      = {
                    virt_text = true,
                    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
                    delay = 1000,
                    ignore_whitespace = false,
                    virt_text_priority = 100,
                },
                current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
                sign_priority                = 6,
                update_debounce              = 100,
                status_formatter             = nil,   -- Use default
                max_file_length              = 40000, -- Disable if file is longer than this (in lines)
                preview_config               = {
                    -- Options passed to nvim_open_win
                    border = 'single',
                    style = 'minimal',
                    relative = 'cursor',
                    row = 0,
                    col = 1
                },

                on_attach                    = function(bufnr)
                    local gitsigns = require('gitsigns')

                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- Navigation
                    map('n', ']c', function()
                        if vim.wo.diff then
                            vim.cmd.normal({ ']h', bang = true })
                        else
                            gitsigns.nav_hunk('next')
                        end
                    end)

                    map('n', '[c', function()
                        if vim.wo.diff then
                            vim.cmd.normal({ '[h', bang = true })
                        else
                            gitsigns.nav_hunk('prev')
                        end
                    end)

                    map('n', '<leader>gs', gitsigns.stage_hunk, { desc = "[S]tage Hunk" })
                    map('n', '<leader>gr', gitsigns.reset_hunk, { desc = "[R]eset Hunk" })
                    map('v', 'gs', function() gitsigns.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
                        { desc = "[S]tage Hunk" })
                    map('v', 'gr', function() gitsigns.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
                        { desc = "[R]eset Hunk" })
                    map('n', '<leader>gS', gitsigns.stage_buffer, { desc = "[S]tage Buffer" })
                    map('n', '<leader>gu', gitsigns.undo_stage_hunk, { desc = "[U]ndo Stage Hunk" })
                    map('n', '<leader>gR', gitsigns.reset_buffer, { desc = "[R]eset Buffer" })
                    map('n', '<leader>gp', gitsigns.preview_hunk, { desc = "[P]review Hunk" })
                    map('n', '<leader>gb', function() gitsigns.blame_line { full = true } end, { desc = "[B]lame Line" })
                    map('n', '<leader>gtb', gitsigns.toggle_current_line_blame, { desc = "[B]lame Current Line" })
                    map('n', '<leader>gd', gitsigns.diffthis, { desc = "[D]iff This" })
                    -- Not sure what the difference between diffthis and diffthis('~') is
                    -- map('n', '<leader>gD', function() gitsigns.diffthis('~') end)
                    map('n', '<leader>gtd', gitsigns.toggle_deleted, { desc = "[D]eleted" })
                    map('n', '<leader>gth', '<cmd>Gitsigns toggle_linehl<CR>', { desc = "[H]ighlts Lines" })

                    -- Text object
                    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
                end
            }
        end

    },
    {
        "alexmozaidze/palenight.nvim",
        opts = {
            italic = true,
        },
    },
    {
        "miikanissi/modus-themes.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            variant = "default", -- Theme comes in four variants `default`, `tinted`, `deuteranopia`, and `tritanopia`
            dim_inactive = true, -- "non-current" windows are dimmed
            hide_inactive_statusline = false,
            styles = {
                comments = { underline = true, bold = false, italic = true, },
                keywords = { underline = false, bold = true, italic = true, },
                functions = { underline = false, bold = true, italic = false, },
                variables = { underline = false, bold = false, italic = true, },
            },
            -- on_colors = function(colors)
            --     colors.error = colors.red_faint -- Change error color to the "faint" variant
            -- end,
            -- on_highlights = function(highlight, color)
            --     highlight.Boolean = { fg = color.green } -- Change Boolean highlight to use the green color
            -- end,
        },
    }
}
