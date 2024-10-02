return {
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            -- Creates a beautiful debugger UI
            'rcarriga/nvim-dap-ui',

            -- Required dependency for nvim-dap-ui
            'nvim-neotest/nvim-nio',

            -- Installs the debug adapters for you
            'jay-babu/mason-nvim-dap.nvim',

            {
                'theHamsta/nvim-dap-virtual-text',
                opts = {
                    enabled = true,                     -- enable this plugin (the default)
                    enabled_commands = true,            -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
                    highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
                    highlight_new_as_changed = false,   -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
                    show_stop_reason = true,            -- show stop reason when stopped for exceptions
                    commented = false,                  -- prefix virtual text with comment string
                    only_first_definition = true,       -- only show virtual text at first definition (if there are multiple)
                    all_references = false,             -- show virtual text on all all references of the variable (not only definitions)
                    clear_on_continue = false,          -- clear virtual text on "continue" (might cause flickering when stepping)
                    -- position of virtual text, see `:h nvim_buf_set_extmark()`, default tries to inline the virtual text. Use 'eol' to set to end of line
                    virt_text_pos = vim.fn.has 'nvim-0.10' == 1 and 'inline' or 'eol',
                }
            },

        },
        config = function()
            local dap = require 'dap'
            local dapui = require 'dapui'

            require('mason-nvim-dap').setup {
                -- Makes a best effort to setup the various debuggers with
                -- reasonable debug configurations
                automatic_installation = true,

                -- You can provide additional configuration to the handlers,
                -- see mason-nvim-dap README for more information
                handlers = {},

                -- You'll need to check that you have the required things installed
                -- online, please don't ask me how to install them :)
                ensure_installed = {
                    -- Update this to ensure that you have the debuggers for the langs you want
                    'bash-debug-adapter',
                    'cortex-debug',
                    'java-debug-adapter',
                },
            }

            -- Basic debugging keymaps, feel free to change to your liking!
            vim.keymap.set('n', '<leader>dc', dap.continue, { desc = '[D]ebug: Start/[C]ontinue' })
            vim.keymap.set('n', '<leader>di', dap.step_into, { desc = '[D]ebug: Step [I]nto' })
            vim.keymap.set('n', '<leader>do', dap.step_over, { desc = '[D]ebug: Step [O]ver' })
            vim.keymap.set('n', '<leader>dt', dap.step_out, { desc = '[D]ebug: Step Ou[t]' })
            vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint,
                { desc = '[D]ebug: Toggle [B]reakpoint' })
            vim.keymap.set('n', '<leader>dB', function()
                dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
            end, { desc = '[D]ebug: Set [B]reakpoint' })

            -- Dap UI setup
            -- For more information, see |:help nvim-dap-ui|
            dapui.setup {
                -- Set icons to characters that are more likely to work in every terminal.
                --    Feel free to remove or use ones that you like more! :)
                --    Don't feel like these are good choices.
                icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
                controls = {
                    icons = {
                        pause = '⏸',
                        play = '▶',
                        step_into = '⏎',
                        step_over = '⏭',
                        step_out = '⏮',
                        step_back = 'b',
                        run_last = '▶▶',
                        terminate = '⏹',
                        disconnect = '⏏',
                    },
                },
            }

            -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
            vim.keymap.set('n', '<leader>du', dapui.toggle, { desc = '[D]ebug: See last session result.' })

            dap.listeners.after.event_initialized['dapui_config'] = dapui.open
            dap.listeners.before.event_terminated['dapui_config'] = dapui.close
            dap.listeners.before.event_exited['dapui_config'] = dapui.close
        end,
    },
    {
        "folke/trouble.nvim",
        opts = {
            auto_close = false,      -- auto close when there are no items
            auto_open = false,       -- auto open when there are items
            auto_preview = true,     -- automatically open preview when on an item
            auto_refresh = true,     -- auto refresh when open
            auto_jump = false,       -- auto jump to the item when there's only one
            focus = false,           -- Focus the window when opened
            restore = true,          -- restores the last location in the list when opening
            follow = true,           -- Follow the current item
            indent_guides = true,    -- show indent guides
            max_items = 200,         -- limit number of items that can be displayed per section
            multiline = true,        -- render multi-line messages
            pinned = false,          -- When pinned, the opened trouble window will be bound to the current buffer
            warn_no_results = true,  -- show a warning when there are no results
            open_no_results = false, -- open the trouble window when there are no results
            win = {},                -- window options for the results window. Can be a split or a floating window.
            -- Window options for the preview window. Can be a split, floating window,
            -- or `main` to show the preview in the main editor window.
            preview = {
                type = "main",
                -- when a buffer is not yet loaded, the preview window will be created
                -- in a scratch buffer with only syntax highlighting enabled.
                -- Set to false, if you want the preview to always be a real loaded buffer.
                scratch = true,
            },
            -- Throttle/Debounce settings. Should usually not be changed.
            throttle = {
                refresh = 20,                            -- fetches new data when needed
                update = 10,                             -- updates the window
                render = 10,                             -- renders the window
                follow = 100,                            -- follows the current item
                preview = { ms = 100, debounce = true }, -- shows the preview for the current item
            },
            -- Key mappings can be set to the name of a builtin action,
            -- or you can define your own custom action.
            keys = {
                ["?"] = "help",
                r = "refresh",
                R = "toggle_refresh",
                q = "close",
                o = "jump_close",
                ["<esc>"] = "cancel",
                ["<cr>"] = "jump",
                ["<2-leftmouse>"] = "jump",
                ["<c-s>"] = "jump_split",
                ["<c-v>"] = "jump_vsplit",
                -- go down to next item (accepts count)
                -- j = "next",
                ["}"] = "next",
                ["]]"] = "next",
                -- go up to prev item (accepts count)
                -- k = "prev",
                ["{"] = "prev",
                ["[["] = "prev",
                dd = "delete",
                d = { action = "delete", mode = "v" },
                i = "inspect",
                p = "preview",
                P = "toggle_preview",
                zo = "fold_open",
                zO = "fold_open_recursive",
                zc = "fold_close",
                zC = "fold_close_recursive",
                za = "fold_toggle",
                zA = "fold_toggle_recursive",
                zm = "fold_more",
                zM = "fold_close_all",
                zr = "fold_reduce",
                zR = "fold_open_all",
                zx = "fold_update",
                zX = "fold_update_all",
                zn = "fold_disable",
                zN = "fold_enable",
                zi = "fold_toggle_enable",
                gb = { -- example of a custom action that toggles the active view filter
                    action = function(view)
                        view:filter({ buf = 0 }, { toggle = true })
                    end,
                    desc = "Toggle Current Buffer Filter",
                },
                s = { -- example of a custom action that toggles the severity
                    action = function(view)
                        local f = view:get_filter("severity")
                        local severity = ((f and f.filter.severity or 0) + 1) % 5
                        view:filter({ severity = severity }, {
                            id = "severity",
                            template = "{hl:Title}Filter:{hl} {severity}",
                            del = severity == 0,
                        })
                    end,
                    desc = "Toggle Severity Filter",
                },
            },
            modes = {
                -- sources define their own modes, which you can use directly,
                -- or override like in the example below
                lsp_references = {
                    -- some modes are configurable, see the source code for more details
                    params = {
                        include_declaration = true,
                    },
                },
                -- The LSP base mode for:
                -- * lsp_definitions, lsp_references, lsp_implementations
                -- * lsp_type_definitions, lsp_declarations, lsp_command
                lsp_base = {
                    params = {
                        -- don't include the current location in the results
                        include_current = false,
                    },
                },
                -- more advanced example that extends the lsp_document_symbols
                symbols = {
                    desc = "document symbols",
                    mode = "lsp_document_symbols",
                    focus = false,
                    win = { position = "right" },
                    filter = {
                        -- remove Package since luals uses it for control flow structures
                        ["not"] = { ft = "lua", kind = "Package" },
                        any = {
                            -- all symbol kinds for help / markdown files
                            ft = { "help", "markdown" },
                            -- default set of symbol kinds
                            kind = {
                                "Class",
                                "Constructor",
                                "Enum",
                                "Field",
                                "Function",
                                "Interface",
                                "Method",
                                "Module",
                                "Namespace",
                                "Package",
                                "Property",
                                "Struct",
                                "Trait",
                            },
                        },
                    },
                },
            },
            -- stylua: ignore
            icons = {
                indent        = {
                    top         = "│ ",
                    middle      = "├╴",
                    -- last        = "└╴",
                    last        = "╰╴", -- rounded
                    fold_open   = " ",
                    fold_closed = " ",
                    ws          = "  ",
                },
                folder_closed = " ",
                folder_open   = " ",
                kinds         = {
                    Array         = " ",
                    Boolean       = "󰨙 ",
                    Class         = " ",
                    Constant      = "󰏿 ",
                    Constructor   = " ",
                    Enum          = " ",
                    EnumMember    = " ",
                    Event         = " ",
                    Field         = " ",
                    File          = " ",
                    Function      = "󰊕 ",
                    Interface     = " ",
                    Key           = " ",
                    Method        = "󰊕 ",
                    Module        = " ",
                    Namespace     = "󰦮 ",
                    Null          = " ",
                    Number        = "󰎠 ",
                    Object        = " ",
                    Operator      = " ",
                    Package       = " ",
                    Property      = " ",
                    String        = " ",
                    Struct        = "󰆼 ",
                    TypeParameter = " ",
                    Variable      = "󰀫 ",
                },
            },

        }, -- for default options, refer to the configuration section for custom setup.
        cmd = "Trouble",
        keys = {
            {
                "<leader>td",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "[D]iagnostics (Trouble)",
            },
            {
                "<leader>tb",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "[B]uffer Diagnostics (Trouble)",
            },
            {
                "<leader>ts",
                "<cmd>Trouble symbols toggle focus=false<cr>",
                desc = "[S]ymbols (Trouble)",
            },
            {
                "<leader>tr",
                "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                desc = "LSP Definitions / [r]eferences / ... (Trouble)",
            },
            {
                "<leader>tl",
                "<cmd>Trouble loclist toggle<cr>",
                desc = "[L]ocation List (Trouble)",
            },
            {
                "<leader>tq",
                "<cmd>Trouble qflist toggle<cr>",
                desc = "[Q]uickfix List (Trouble)",
            },
        },
    },
}
