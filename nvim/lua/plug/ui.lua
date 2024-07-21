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

                        require("ibl").setup { indent = { highlight = highlight } }
                end
        },

        {
                "folke/zen-mode.nvim",
                opts = {
                        width = 180,
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
                "nvim-lualine/lualine.nvim",
                dependencies = { "nvim-tree/nvim-web-devicons" },
                opts = function(_, opts)
                        require("lualine").setup({
                                options = {
                                        icons_enabled = true,
                                        theme = "auto",
                                        component_separators = { left = "", right = "" },
                                        section_separators = { left = "", right = "" },
                                        disabled_filetypes = {
                                                statusline = {},
                                                winbar = {},
                                        },
                                        ignore_focus = {},
                                        always_divide_middle = true,
                                        globalstatus = false,
                                        refresh = {
                                                statusline = 1000,
                                                tabline = 1000,
                                                winbar = 1000,
                                        },
                                },
                                sections = {
                                        lualine_a = { "mode" },
                                        lualine_b = { "branch", "diff", "diagnostics" },
                                        lualine_c = { "filename" },
                                        lualine_x = { "encoding", "fileformat", "filetype" },
                                        lualine_y = { "progress" },
                                        lualine_z = { "location" },
                                },
                                inactive_sections = {
                                        lualine_a = {},
                                        lualine_b = {},
                                        lualine_c = { 'filename' },
                                        lualine_x = { 'location' },
                                        lualine_y = {},
                                        lualine_z = {}
                                },
                        })
                end,
        },
        {
                "Tsuzat/NeoSolarized.nvim",
                lazy = false, -- make sure we load this during startup if it is your main colorscheme
                priority = 1000,
                config = function()
                        vim.cmd [[ colorscheme NeoSolarized ]]
                end,
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
                lazy = false,
                -- priority = 999,
                opts = {
                        style = "night",
                        transparent = true,
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
                event = 'VimEnter',
                opts = {
                        theme = 'hyper',
                        config = {},               --  config used for theme
                        hide = {
                                statusline = true, -- hide statusline default is true
                                tabline = true,    -- hide the tabline
                                winbar = true,     -- hide winbar
                        },
                },
                dependencies = { { 'nvim-tree/nvim-web-devicons' } }
        }
}
