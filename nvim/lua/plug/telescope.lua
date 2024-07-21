return {
        {
                'nvim-telescope/telescope.nvim',
                event = 'VimEnter', -- loads when vim has finished opening all core utils
                branch = '0.1.x',
                dependencies = {
                        'nvim-lua/plenary.nvim',
                        { 'nvim-telescope/telescope-ui-select.nvim' },
                        -- 'folke/trouble.nvim',

                        -- Useful for getting pretty icons, but requires a Nerd Font.
                        { 'nvim-tree/nvim-web-devicons',            enabled = vim.g.have_nerd_font },
                        'debugloop/telescope-undo.nvim',

                        {
                                'aznhe21/actions-preview.nvim',
                                opts = {
                                        diff = {
                                                cxtlen = 5, -- docs found @ vim.diff
                                        },

                                        backend = { 'telescope' },

                                        telescope = {
                                                sorting_strategy = "ascending",
                                                layout_strategy = "vertical",
                                                layout_config = {
                                                        width = 0.8,
                                                        height = 0.9,
                                                        prompt_position = "top",
                                                        preview_cutoff = 20,
                                                        preview_height = function(_, _, max_lines)
                                                                return max_lines - 15
                                                        end,
                                                },
                                        },
                                },
                        },
                },
                config = function()
                        require('telescope').setup({
                                -- view :h telescope.setup()
                                defaults = {
                                        mappings = {
                                                i = {
                                                        ['<c-enter>'] = 'to_fuzzy_refine',
                                                        ['<C-j>'] = 'move_selection_next',
                                                        ['<C-k>'] = 'move_selection_previous',
                                                        ['<C-u>'] = 'preview_scrolling_up',
                                                        ['<C-d>'] = 'preview_scrolling_down',
                                                        ['<enter>'] = 'select_default',
                                                        ['<c-t>'] = require("trouble.sources.telescope").open,
                                                        ['<c-x>'] = 'delete_buffer',
                                                },
                                                n = {
                                                        ['j'] = 'move_selection_next',
                                                        ['k'] = 'move_selection_previous',
                                                        ['<C-j>'] = 'move_selection_next',
                                                        ['<C-k>'] = 'move_selection_previous',
                                                        ['G'] = 'move_to_bottom',
                                                        ['gg'] = 'move_to_bottom',
                                                        ['u'] = 'results_scrolling_up',
                                                        ['d'] = 'results_scrolling_down',
                                                        ['enter'] = 'select_default',
                                                        ['<c-t>'] = require("trouble.sources.telescope").open,
                                                        ['<c-x>'] = 'delete_buffer',
                                                }
                                        },
                                },
                                -- TODO: not sure what this does
                                --[[ pickers = {}, ]]

                                extensions = { -- configs go here
                                        ['ui-select'] = {
                                                require('telescope.themes').get_dropdown(),
                                        },
                                        undo = {
                                                side_by_side = true,
                                                layout_strategy = 'vertical', -- Might change
                                                layout_config = {
                                                        preview_height = 0.8,
                                                },
                                                mappings = {
                                                        i = {
                                                                ['<cr>'] = require('telescope-undo.actions').restore,
                                                                ['<C-a'] = require('telescope-undo.actions')
                                                                    .yank_additions,
                                                                ['<C-d'] = require('telescope-undo.actions')
                                                                    .yank_deletions,
                                                        },
                                                        n = {
                                                                ["a"] = require("telescope-undo.actions").yank_additions,
                                                                ["d"] = require("telescope-undo.actions").yank_deletions,
                                                                ["<cr>"] = require("telescope-undo.actions").restore,
                                                        }
                                                }
                                        },
                                },
                        })
                        -- Load telescope extensions here
                        pcall(require('telescope').load_extension 'ui-select')
                        pcall(require('telescope').load_extension 'undo')

                        local blt = require 'telescope.builtin'
                        vim.keymap.set('n', '<leader>sh', blt.help_tags, { desc = '[S]earch [H]elp' })
                        vim.keymap.set('n', '<leader>sk', blt.keymaps, { desc = '[S]earch [K]eymaps' })
                        vim.keymap.set('n', '<leader>sf', blt.find_files, { desc = '[S]earch [F]iles' })
                        vim.keymap.set('n', '<leader>so', blt.builtin, { desc = '[S]earch [S]elect Telescope' })
                        vim.keymap.set('n', '<leader>sw', blt.grep_string, { desc = '[S]earch current [W]ord' })
                        vim.keymap.set('n', '<leader>sg', blt.live_grep, { desc = '[S]earch by [G]rep' })
                        vim.keymap.set('n', '<leader>sd', blt.diagnostics, { desc = '[S]earch [D]iagnostics' })
                        vim.keymap.set('n', '<leader>sr', blt.resume, { desc = '[S]earch [R]esume' })
                        vim.keymap.set('n', '<leader>sb', blt.buffers, { desc = '[S]earch existing [B]uffers' })
                        vim.keymap.set('n', '<leader>s.', blt.oldfiles,
                                { desc = '[S]earch Recent Files ("." for repeat)' })
                        vim.keymap.set('n', '<leader>fu', ":Telescope undo<CR>", { desc = 'Open [U]ndo' })
                        vim.keymap.set({ 'n', 'i' }, '<C-x>b', blt.buffers, { desc = 'Search existing [B]uffers' })

                        -- Complex telescope behaviour
                        vim.keymap.set('n', '<leader>/', function()
                                -- You can pass additional configuration to Telescope to change
                                -- the theme, layout, etc.
                                blt.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                                        winblend = 10,
                                        previewer = false,
                                })
                        end, { desc = '[/] Fuzzily search in current buffer' })

                        vim.keymap.set('n', '<leader>s/', function()
                                blt.live_grep {
                                        grep_open_files = true,
                                        prompt_title = 'Live Grep in Open Files',
                                }
                        end, { desc = '[S]earch [/] in Open Files' })

                        -- Shortcut for searching your Neovim configuration files
                        vim.keymap.set('n', '<leader>sn', function()
                                blt.find_files { cwd = vim.fn.stdpath 'config' }
                        end, { desc = '[S]earch [N]eovim files' })

                        vim.keymap.set({ 'n', 'i' }, '<C-x>/', function()
                                -- You can pass additional configuration to Telescope to change
                                -- the theme, layout, etc.
                                blt.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                                        winblend = 10,
                                        previewer = false,
                                })
                        end, { desc = '[/] Fuzzily search in current buffer' })

                        vim.keymap.set({ 'n', 'i' }, '<C-x>s/', function()
                                blt.live_grep {
                                        grep_open_files = true,
                                        prompt_title = 'Live Grep in Open Files',
                                }
                        end, { desc = '[S]earch [/] in Open Files' })

                        -- Shortcut for searching your Neovim configuration files
                        vim.keymap.set({ 'n', 'i' }, '<C-x>sn', function()
                                blt.find_files { cwd = vim.fn.stdpath 'config' }
                        end, { desc = '[S]earch [N]eovim files' })
                end,
        },
        {
                "ThePrimeagen/harpoon",
                branch = "harpoon2",
                event = "VimEnter",
                config = function()
                        local harpoon = require('harpoon')
                        harpoon:setup({})
                        local conf = require("telescope.config").values
                        local function toggle_telescope(harpoon_files)
                                local file_paths = {}
                                for _, item in ipairs(harpoon_files.items) do
                                        table.insert(file_paths, item.value)
                                end

                                require("telescope.pickers").new({}, {
                                        prompt_title = "Harpoon",
                                        finder = require("telescope.finders").new_table({
                                                results = file_paths,
                                        }),
                                        previewer = conf.file_previewer({}),
                                        sorter = conf.generic_sorter({}),
                                }):find()
                        end
                        harpoon:setup()
                        vim.keymap.set("n", "<leader>wh", function() toggle_telescope(harpoon:list()) end,
                                { desc = "Open [H]arpoon window" })
                end
        },
}
