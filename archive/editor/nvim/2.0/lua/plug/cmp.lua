-- https://github.com/Saghen/blink.cmp
-- https://github.com/rafamadriz/friendly-snippets
-- https://github.com/L3MON4D3/LuaSnip
return {
  {
    "Saghen/blink.cmp",
    enabled = false, -- Reanable when plugin becomes more stable
    version = '1.*',
      dependencies = {
        -- NOTE: may have to lazy load these
        "rafamadriz/friendly-snippets",
      },

    opts = {
      -- snippet = {
      --   expand = function(snippet) require('luasnip').lsp_expand(snippet) end,
      --   active = function(filter)
      --     if filter and filter.direction then
      --       return require('luasnip').jumpable(filter.direction)
      --     end
      --     return require('luasnip').in_snippet()
      --   end,
      --   jump = function(direction) require('luasnip').jump(direction) end,
      -- },
      sources = {
        default = { 'lsp', 'snippets','path', 'buffer' },
        per_filetype = {
          -- NOTE: We can configure per FT sources here

          -- lua = { 'lsp', 'path' },
        },
        cmdline = function()
          local type = vim.fn.getcmdtype()
          -- Search forward and backward
          if type == '/' or type == '?' then return { 'buffer' } end
          -- Commands
          if type == ':' then return { 'cmdline' } end
          return {}
        end,

        -- Function to use when transforming the items before they're returned for all providers
        -- The default will lower the score for snippets to sort them lower in the list
        transform_items = function(_, items)
          for _, item in ipairs(items) do
            if item.kind == require('blink.cmp.types').CompletionItemKind.Snippet then
              item.score_offset = item.score_offset - 3
            end
          end
          return items
        end,
        -- Minimum number of characters in the keyword to trigger all providers
        -- May also be `function(ctx: blink.cmp.Context): number`
        min_keyword_length = 0,
        -- Example for setting a minimum keyword length for markdown files
        -- min_keyword_length = function()
          --   return vim.bo.filetype == 'markdown' and 2 or 0
          -- end,
          -- Please see https://github.com/Saghen/blink.compat for using `nvim-cmp` sources

        providers = { -- TODO: Figure out a way to filter on providers
          lsp = {
            name = 'LSP',
            module = 'blink.cmp.sources.lsp',
            -- Filter out text items from the LSP provider, since we have the buffer provider for that
            transform_items = function(_, items)
              return vim.tbl_filter(
                function(item) return item.kind ~= require('blink.cmp.types').CompletionItemKind.Text end,
                items
              )
            end,
            --- *All* providers have the following options available
            --- NOTE: All of these options may be functions to get dynamic behavior
            --- See the type definitions for more information.
            enabled = true,           -- Whether or not to enable the provider
            async = false,            -- Whether we should wait for the provider to return before showing the completions
            timeout_ms = 2000,        -- How long to wait for the provider to return before showing completions and treating it as asynchronous
            should_show_items = true, -- Whether or not to show the items
            max_items = 100,          -- Maximum number of items to display in the menu
            min_keyword_length = 1,   -- Minimum number of characters in the keyword to trigger the provider
            fallbacks = { 'buffer' },
            score_offset = 0,         -- Boost/penalize the score of the items
            override = nil,           -- Override the source's functions
          },

          path = {
            name = 'Path',
            module = 'blink.cmp.sources.path',
            score_offset = 3,
            min_keyword_length = 1,
            fallbacks = { 'buffer' },
            opts = {
              trailing_slash = false,
              label_trailing_slash = true,
              get_cwd = function(context) return vim.fn.expand(('#%d:p:h'):format(context.bufnr)) end,
              show_hidden_files_by_default = true, -- TODO: Figure out how to make these show up last
            }
          },

          snippets = {
            preset = "default",
            },

          buffer = {
            name = 'Buffer',
            module = 'blink.cmp.sources.buffer',
            min_keyword_length = 1,
            opts = {
              -- default to all visible buffers
              get_bufnrs = function()
                return vim
                .iter(vim.api.nvim_list_wins())
                :map(function(win) return vim.api.nvim_win_get_buf(win) end)
                :filter(function(buf) return vim.bo[buf].buftype ~= 'nofile' end)
                :totable()
              end,
            },
          },
        },
      },

      completion = {
        -- TODO: Fine tune this to look just right, currently mimicking nvim-cmp, per the README
        menu = {
          draw = {
            columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
          },
        },

        keyword = {
          -- TODO: Can fine tune completions fuzzy matching here
          --
          -- 'prefix' will fuzzy match on the text before the cursor
          -- 'full' will fuzzy match on the text before *and* after the cursor
          -- example: 'foo_|_bar' will match 'foo_' for 'prefix' and 'foo__bar' for 'full'
          range = 'prefix',
          -- Regex used to get the text when fuzzy matching
          -- regex = '[-_]\\|\\k',
          -- After matching with regex, any characters matching this regex at the prefix will be excluded
          -- exclude_from_prefix_regex = '[\\-]',
        },

        trigger = {
          -- When true, will prefetch the completion items when entering insert mode
          -- WARN: buggy, not recommended unless you'd like to help develop prefetching
          prefetch_on_insert = false,
          -- When false, will not show the completion window automatically when in a snippet
          show_in_snippet = true,
          -- When true, will show the completion window after typing a character that matches the `keyword.regex`
          show_on_keyword = true,
          -- When true, will show the completion window after typing a trigger character
          show_on_trigger_character = true,
          -- NOTE: Not sure if any of my LSP servers require blocking but leaving this here just in case.
          --
          -- LSPs can indicate when to show the completion window via trigger characters
          -- however, some LSPs (i.e. tsserver) return characters that would essentially
          -- always show the window. We block these by default.
          show_on_blocked_trigger_characters = function()
            if vim.api.nvim_get_mode().mode == 'c' then return {} end
            -- you can also block per filetype, for example:
            -- if vim.bo.filetype == 'markdown' then
            --   return { ' ', '\n', '\t', '.', '/', '(', '[' }
            -- end
            return { ' ', '\n', '\t' }
          end,
          -- When both this and show_on_trigger_character are true, will show the completion window
          -- when the cursor comes after a trigger character after accepting an item
          show_on_accept_on_trigger_character = true,
          -- When both this and show_on_trigger_character are true, will show the completion window
          -- when the cursor comes after a trigger character when entering insert mode
          show_on_insert_on_trigger_character = true,
          -- List of trigger characters (on top of `show_on_blocked_trigger_characters`) that won't trigger
          -- the completion window when the cursor comes after a trigger character when
          -- entering insert mode/accepting an item
          show_on_x_blocked_trigger_characters = {
            "'", '"', '(', '{'
          }, -- BUG: This char gets matched with the { in the string so % is not jumping to the proper location
        },

        list = {
          max_items = 50,
          selection = 'preselect',
          cycle = {
            from_bottom = true,
            from_top = true,
          },
        },

        accept = {
          -- Create an undo point when accepting a completion item
          create_undo_point = true,
          auto_brackets = {
            enabled = true,
            default_brackets = { '(', ')' },
            override_brackets_for_filetypes = {},
            -- Synchronously use the kind of the item to determine if brackets should be added
            kind_resolution = {
              enabled = true,
              blocked_filetypes = { 'typescriptreact', 'javascriptreact', 'vue' },
            },
            semantic_token_resolution = {
              enabled = true,
              blocked_filetypes = {},
              -- How long to wait for semantic tokens to return before assuming no brackets should be added
              timeout_ms = 300,
            },
          },
        },

        documentation = {
          -- Controls whether the documentation window will automatically show when selecting a completion item
          auto_show = false,
          auto_show_delay_ms = 500,
          update_delay_ms = 50,
          -- Whether to use treesitter highlighting, disable if you run into performance issues
          treesitter_highlighting = true,

          window = {
            min_width = 10,
            max_width = 60,
            max_height = 20,
            border = 'padded',
            winblend = 0,
            winhighlight =
            'Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None',
            -- Note that the gutter will be disabled when border ~= 'none'
            scrollbar = false,
            -- Which directions to show the documentation window,
            -- for each of the possible menu window directions,
            -- falling back to the next direction when there's not enough space
            direction_priority = {
              menu_north = { 'e', 'w', 'n', 's' },
              menu_south = { 'e', 'w', 's', 'n' },
            },
          },
        },

        -- Displays a preview of the selected item on the current line
        ghost_text = {
          enabled = true, -- NOTE: May remove this in the future
        },
      },

      keymap = {
        ['<A-1>'] = { function(cmp) cmp.accept({ index = 1 }) end, 'fallback' },
        ['<A-2>'] = { function(cmp) cmp.accept({ index = 2 }) end, 'fallback' },
        ['<A-3>'] = { function(cmp) cmp.accept({ index = 3 }) end, 'fallback' },
        ['<A-4>'] = { function(cmp) cmp.accept({ index = 4 }) end, 'fallback' },
        ['<A-5>'] = { function(cmp) cmp.accept({ index = 5 }) end, 'fallback' },
        ['<A-6>'] = { function(cmp) cmp.accept({ index = 6 }) end, 'fallback' },
        ['<A-7>'] = { function(cmp) cmp.accept({ index = 7 }) end, 'fallback' },
        ['<A-8>'] = { function(cmp) cmp.accept({ index = 8 }) end, 'fallback' },
        ['<A-9>'] = { function(cmp) cmp.accept({ index = 9 }) end, 'fallback' },
        -- NOTE: To get to other keymap use 'fallback'
        ['<C-j>'] = { 'select_next' },
        ['<C-k>'] = { 'select_prev' },
        ['<C-f>'] = { 'select_and_accept' },
        ['<C-e>'] = { 'hide' },
        ['<C-g>'] = { 'cancel' },
        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
      },

      -- Example for blocking multiple filetypes
      enabled = function()
        return not vim.tbl_contains({ "markdown" }, vim.bo.filetype)
        and vim.bo.buftype ~= "prompt"
        and vim.b.completion ~= false
      end,

      fuzzy = {
        -- when enabled, allows for a number of typos relative to the length of the query
        -- disabling this matches the behavior of fzf
        use_typo_resistance = true, -- NOTE: Sure if this is needed
        use_frecency = true,
        -- proximity bonus boosts the score of items matching nearby words
        use_proximity = true,
        max_items = 100,
        -- controls which sorts to use and in which order, falling back to the next sort if the first one returns nil
        -- you may pass a function instead of a string to customize the sorting
        sorts = { 'score', 'sort_text' },
      },

      appearance = {
        highlight_ns = vim.api.nvim_create_namespace('blink_cmp'),
        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono',
        kind_icons = {
          Text = '󰉿',
          Method = '󰊕',
          Function = '󰊕',
          Constructor = '󰒓',
          Field = '󰜢',
          Variable = '󰆦',
          Property = '󰖷',
          Class = '󱡠',
          Interface = '󱡠',
          Struct = '󱡠',
          Module = '󰅩',
          Unit = '󰪚',
          Value = '󰦨',
          Enum = '󰦨',
          EnumMember = '󰦨',
          Keyword = '󰻾',
          Constant = '󰏿',
          Snippet = '󱄽',
          Color = '󰏘',
          File = '󰈔',
          Reference = '󰬲',
          Folder = '󰉋',
          Event = '󱐋',
          Operator = '󰪚',
          TypeParameter = '󰬛',
        },
      },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        build = (function()
            if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
                return
            end
            return 'make install_jsregexp'
        end)(),
        dependencies = {
            -- `friendly-snippets` contains a variety of premade snippets.
            --    See the README about individual language/framework/plugin snippets:
            --    https://github.com/rafamadriz/friendly-snippets
            {
              'rafamadriz/friendly-snippets',
              config = function()
                require('luasnip.loaders.from_vscode').lazy_load()
              end,
            },
        },
      },
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'ray-x/cmp-treesitter',
    },
    config = function()
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

        mapping = cmp.mapping.preset.insert {
          ['<C-j>'] = cmp.mapping.select_next_item(),
          ['<C-k>'] = cmp.mapping.select_prev_item(),
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),

          ['<C-f>'] = cmp.mapping.confirm { select = true, behavior = cmp.ConfirmBehavior.Replace},
          ['<C-Space>'] = cmp.mapping.complete {},

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
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip'  },
          { name = 'treesiter' },
          { name = 'path'     },
        },
      }
    end,
  }
}
