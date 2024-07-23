return {
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        dependencies = {
            -- Lsp automation helpers
            { "williamboman/mason.nvim", config = true },
            {
                "williamboman/mason-lspconfig.nvim",
            },
            "WhoIsSethDaniel/mason-tool-installer.nvim",

            {
                "windwp/nvim-autopairs",
                event = "InsertEnter",
                config = true,
                opts = {
                    {
                        -- Add more rules here when needed
                        disable_filetype = { "TelescopePrompt", "spectre_panel" },
                        enable_abbr = false, -- trigger abbreviation
                        break_undo = true,   -- switch for basic rule break undo sequence
                        check_ts = false,
                        map_c_h = false,     -- Map the <C-h> key to delete a pair
                        enable_check_bracket_line = true,
                    },
                },
            },

            -- Provides progress bar for lsp
            {
                "j-hui/fidget.nvim",
                opts = {
                    -- Options related to LSP progress subsystem
                    progress = {
                        suppress_on_insert = true,  -- Suppress new messages while in insert mode
                        ignore_done_already = true, -- Ignore new tasks that are already complete
                    },

                    -- Options related to notification subsystem
                    notification = {
                        poll_rate = 10,             -- How frequently to update and render notifications
                        history_size = 64,          -- Number of removed messages to retain in history
                        override_vim_notify = true, -- Automatically override vim.notify() with Fidget

                        -- Options related to how notifications are rendered as text
                        view = {
                            group_separator = "---", -- Separator between notification groups
                        },

                        -- Options related to the notification window and buffer
                        window = {
                            normal_hl = "Comment", -- Base highlight group in the notification window
                            winblend = 80,         -- Background color opacity in the notification window
                            zindex = 45,           -- Stacking priority of the notification window
                            max_width = 0,         -- Maximum width of the notification window
                            max_height = 0,        -- Maximum height of the notification window
                            x_padding = 1,         -- Padding from right edge of window boundary
                            y_padding = 0,         -- Padding from bottom edge of window boundary
                        },
                    },
                },
            },
            -- Lua lsp config for working on neovim
            { "folke/neodev.nvim",       opts = {} },
        },


        config = function()
            local n = "n"
            -- autocommand runs when lsp is attached
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("hypnotics-lsp-attach", { clear = true }),
                callback = function(event)
                    local map = function(mode, keys, func, desc)
                        vim.keymap.set(mode, keys, func,
                            { buffer = event.buf, desc = "LSP: " .. desc })
                    end

                    -- Lsp keymap set, C-t can be used to jump back to prev locations
                    map(n, "gd", require("telescope.builtin").lsp_definitions,
                        "[G]oto [D]efinition")
                    -- Provides a telescope menu with all references of word
                    map(n, "gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
                    map(n, "gI", require("telescope.builtin").lsp_implementations,
                        "[G]oto [I]mplementation")
                    -- Jump to type definition, not sure this will be usefull
                    map(n, "g<C-d>", require("telescope.builtin").lsp_type_definitions,
                        "Type [D]efinition")
                    -- Fuzzy find symbols over documents and projects
                    map(n, "<leader>sS", require("telescope.builtin").lsp_document_symbols,
                        "[S]earch Document [S]ymbols")
                    map(
                        n,
                        "<leader>ss",
                        require("telescope.builtin").lsp_dynamic_workspace_symbols,
                        "[S]earch Workspace [S]ymbols"
                    )

                    -- Rename a symbol
                    map(n, "<leader>cn", vim.lsp.buf.rename, "[C]ode [R]ename")
                    -- map(ni, "<C-x>rn", vim.lsp.buf.rename, "[R]e[n]ame")

                    -- Perform a code action
                    map(n, "<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
                    -- map(ni, "<C-x>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

                    -- Create a hover window with documentation
                    map("n", "K", vim.lsp.buf.hover, "Hover Documentation")

                    -- Goto a declaration, i.e goto header in C/C++
                    map("n", "gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

                    vim.lsp.buf.signature_help()

                    -- More lsp autocmds

                    -- The following two autocommands are used to highlight references of the
                    -- word under your cursor when your cursor rests there for a little while.
                    --    See `:help CursorHold` for information about when this is executed
                    --
                    -- When you move your cursor, the highlights will be cleared (the second autocommand).
                    local client = vim.lsp.get_client_by_id(event.data.client_id)

                    -- Provides a toggle for inlay hints
                    if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
                        local hint_on = function()
                            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
                        end
                        map(n, "<leader>ct", hint_on, "[T]oggle Inlay [H]ints")
                    end
                end,
            })

            -- no need to expand capabilities because coq does it for us I think, this
            -- might break so FIXME has been added
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = vim.tbl_deep_extend('force', capabilities,
                require('cmp_nvim_lsp').default_capabilities())
            local servers = {
                -- TODO: configure lsp servers

                clangd = {},

                lua_ls = {
                    settings = {
                        Lua = {
                            completion = {
                                callSnippet = "Replace",
                            },
                        },
                    },
                },

                bashls = {},

                jdtls = {},
            }

            -- Setup for server managment

            require("mason").setup()

            local ensure_installed = vim.tbl_keys(servers or {})
            require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

            require("mason-lspconfig").setup({
                handlers = {
                    function(server_name)
                        local server = servers[server_name] or {}
                        -- This handles overriding only values explicitly passed
                        -- by the server configuration above. Useful when disabling
                        -- certain features of an LSP (for example, turning off formatting for tsserver)
                        server.capabilities = vim.tbl_deep_extend("force", {}, capabilities,
                            server.capabilities or {})
                        require("lspconfig")[server_name].setup(server)
                    end,
                },
            })
        end,
    },
    {
        "stevearc/conform.nvim",
        lazy = false,
        keys = {
            {
                "<leader>ff",
                function()
                    require("conform").format({ async = true, lsp_fallback = true })
                end,
                mode = "",
                desc = "[F]ormat buffer",
            },
        },
        opts = {
            notify_on_error = false,
            format_on_save = function(bufnr)
                local disable_filetypes = {
                    c = true,
                    cpp = true,
                }
                return {
                    timeout_ms = 500,
                    lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
                }
            end,
            formatters_by_ft = {
                lua = { "luaformatter" },
                java = { "google-java-format" },
                bash = { "beautysh" },
                rust = { "rust_analyzer" },
            },
        },
    },
    { -- Autocompletion
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            -- Snippet Engine & its associated nvim-cmp source
            {
                'L3MON4D3/LuaSnip',
                build = (function()
                    -- Build Step is needed for regex support in snippets.
                    -- This step is not supported in many windows environments.
                    -- Remove the below condition to re-enable on windows.
                    if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
                        return
                    end
                    return 'make install_jsregexp'
                end)(),
                dependencies = {
                    -- `friendly-snippets` contains a variety of premade snippets.
                    --    See the README about individual language/framework/plugin snippets:
                    --    https://github.com/rafamadriz/friendly-snippets
                    -- {
                    --   'rafamadriz/friendly-snippets',
                    --   config = function()
                    --     require('luasnip.loaders.from_vscode').lazy_load()
                    --   end,
                    -- },
                },
            },
            'saadparwaiz1/cmp_luasnip',

            -- Adds other completion capabilities.
            --  nvim-cmp does not ship with all sources by default. They are split
            --  into multiple repos for maintenance purposes.
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',
            'ray-x/cmp-treesitter',
        },
        config = function()
            -- See `:help cmp`
            local cmp = require 'cmp'
            local luasnip = require 'luasnip'
            luasnip.config.setup {}

            cmp.setup {
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                completion = { completeopt = 'menu,menuone,noinsert' },

                -- For an understanding of why these mappings were
                -- chosen, you will need to read `:help ins-completion`
                --
                -- No, but seriously. Please read `:help ins-completion`, it is really good!
                mapping = cmp.mapping.preset.insert {
                    -- Select the [n]ext item
                    ['<C-j>'] = cmp.mapping.select_next_item(),
                    ['<Tab>'] = cmp.mapping.select_next_item(),
                    -- Select the [p]revious item
                    ['<C-k>'] = cmp.mapping.select_prev_item(),
                    ['<S-Tab>'] = cmp.mapping.select_prev_item(),

                    -- Scroll the documentation window [b]ack / [f]orward
                    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-d>'] = cmp.mapping.scroll_docs(4),

                    -- Accept ([y]es) the completion.
                    --  This will auto-import if your LSP supports it.
                    --  This will expand snippets if the LSP sent a snippet.
                    ['<C-f>'] = cmp.mapping.confirm { select = true },

                    -- Manually trigger a completion from nvim-cmp.
                    --  Generally you don't need this, because nvim-cmp will display
                    --  completions whenever it has completion options available.
                    ['<C-Space>'] = cmp.mapping.complete {},

                    -- Think of <c-l> as moving to the right of your snippet expansion.
                    --  So if you have a snippet that's like:
                    --  function $name($args)
                    --    $body
                    --  end
                    --
                    -- <c-l> will move you to the right of each of the expansion locations.
                    -- <c-h> is similar, except moving you backwards.
                    ['<C-l>'] = cmp.mapping(function()
                        if luasnip.expand_or_locally_jumpable() then
                            luasnip.expand_or_jump()
                        end
                    end, { 'i', 's' }),
                    ['<C-h>'] = cmp.mapping(function()
                        if luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        end
                    end, { 'i', 's' }),

                    -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
                    --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
                },
                sources = {
                    { name = 'treesiter' },
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'path' },
                    -- NOTE: not sure if this is just for lua, but buf completion over runs lsp completions
                    -- { name = 'fuzzy_buffer' },
                    -- { name = 'fuzzy_path' },
                },
            }
        end,
    },
}
