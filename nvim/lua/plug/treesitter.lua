return {
    -- Commenting in Neovim
    {
        "numToStr/Comment.nvim",
        opts = {
            -- Adds padding to comments
            padding = true,
            -- If the cursor should remain @ the cur position
            sticky = true,
            ignore = nil,
            ---LHS of operator-pending mappings in NORMAL and VISUAL mode
            opleader = {
                ---Line-comment keymap
                line = "gc",
                ---Block-comment keymap
                block = "gb",
            },
            mappings = {
                ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
                basic = false,
                ---Extra mapping; `gco`, `gcO`, `gcA`
                extra = false,
            },
            ---Function to call before (un)comment
            pre_hook = nil,
            ---Function to call after (un)comment
            post_hook = nil,
        },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        dependencies = {
            { "nvim-treesitter/nvim-treesitter-textobjects" },
            {
                "nvim-treesitter/nvim-treesitter-context",
                opts = {
                    max_lines = 1,            -- How many lines the window should span. Values <= 0 mean no limit.
                    min_window_height = 0,    -- Minimum editor window height to enable context. Values <= 0 mean no limit.
                    line_numbers = true,
                    multiline_threshold = 20, -- Maximum number of lines to show for a single context
                    trim_scope = "outer",     -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
                    mode = "cursor",          -- Line used to calculate context. Choices: 'cursor', 'topline'
                },
            },
        },
        opts = {
            ensure_installed = { "all" },
            -- Autoinstall languages that are not installed
            auto_install = true,
            highlight = {
                enable = true,
                -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
                --  If you are experiencing weird indenting issues, add the language to
                --  the list of additional_vim_regex_highlighting and disabled languages for indent.
                additional_vim_regex_highlighting = { "ruby" },
            },
            indent = { enable = true, disable = { "ruby" } },
        },
        config = function(_, opts)
            require("nvim-treesitter.install").prefer_git = true
            ---@diagnostic disable-next-line: missing-fields
            require("nvim-treesitter.configs").setup({
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ["af"] = { query = "@function.outer", desc = "Select outer part of a function region" },
                            ["if"] = { query = "@function.inner", desc = "Select inner part of a function region" },
                            ["ac"] = { query = "@class.outer", desc = "Select outer part of a class region" },
                            ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                            ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
                        },
                        selection_modes = {
                            ["@parameter.outer"] = "v", -- charwise
                            ["@function.outer"] = "V",  -- linewise
                            ["@class.outer"] = "<c-v>", -- blockwise
                        },
                        include_surrounding_whitespace = true,
                    },
                    swap = {
                        enable = true,
                        swap_next = {
                            ["<leader>cl"] = "@parameter.inner",
                        },
                        swap_previous = {
                            ["<leader>ch"] = "@parameter.inner",
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true, -- whether to set jumps in the jumplist
                        goto_next_start = {
                            ["]m"] = { query = "@function.outer", desc = "Next function" },
                            ["]]"] = { query = "@class.outer", desc = "Next class" },
                            ["]o"] = { query = "@loop.*", desc = "Next loop" },
                            ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
                            ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
                        },
                        goto_next_end = {
                            ["]M"] = { query = "@function.outer", desc = "Next function end" },
                            ["]["] = { query = "@class.outer", desc = "Next class end" },
                        },
                        goto_previous_start = {
                            ["[m"] = { query = "@function.outer", desc = "Previous function" },
                            ["[["] = { query = "@class.outer", desc = "Previous class" },
                            ["[o"] = { query = "@loop.*", desc = "Previous loop" },
                            ["[s"] = { query = "@scope", query_group = "locals", desc = "Previous scope" },
                            ["[z"] = { query = "@fold", query_group = "folds", desc = "Previous fold" },
                        },
                        goto_previous_end = {
                            ["[M"] = { query = "@function.outer", desc = "Previous function end" },
                            ["[]"] = { query = "@class.outer", desc = "Previous class end" },
                        },
                        goto_next = {
                            ["]c"] = { query = "@conditional.outer", desc = "Next conditional" },
                            ["]/"] = { query = "@comment.outer", desc = "Next Comment" },
                            ["]r"] = { query = "@return.outer", desc = "Next return" },
                            ["]="] = { query = "@assignment.outer", desc = "Next assignment" }
                        },
                        goto_previous = {
                            ["[c"] = { query = "@conditional.outer", desc = "Previous conditional" },
                            ["[/"] = { query = "@comment.outer", desc = "Previous Comment" },
                            ["[r"] = { query = "@return.outer", desc = "Previous return" },
                            ["[="] = { query = "@assignment.outer", desc = "Previous assignment" }
                        },
                    },
                    lsp_interop = {
                        enable = true,
                        border = "none",
                        floating_preview_opts = {},
                        -- TODO: Find a way to clean up keybind desc
                        -- Peek Definition Code @function.outer is not clean
                        -- maybe move these to a subgroup [C]ode [P]eek
                        peek_definition_code = {
                            ["<leader>cpf"] = "@function.outer",
                            ["<leader>cpc"] = "@class.outer",
                        },
                    },
                    highlight = {
                        enable = true,
                    },
                    incremental_selection = {
                        enable = true,
                        keymaps = {
                            init_selection = "<CR>",
                            scope_incremental = "<CR>",
                            node_incremental = "<TAB>",
                            node_decremental = "S-TAB",
                        },
                    },
                },
            })
        end,
    },
    {
        "kylechui/nvim-surround",
        event = "VeryLazy",
        config = function()
            -- TODO: add cheatsheet for surround binds
            require("nvim-surround").setup()
        end,
    },
}
