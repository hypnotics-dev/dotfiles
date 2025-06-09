-- https://github.com/nvim-treesitter/nvim-treesitter
-- https://github.com/nvim-treesitter/nvim-treesitter-context
-- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    {
      "nvim-treesitter/nvim-treesitter-context",
      opts = {
        enable = true,
        multiwindow = false,
        max_lines = 2,
        min_window_height = 30,
        line_numbers = true,
        multiline_threshold = 20,
        trim_scope = 'outer',
        mode = 'cursor',
        separator = nil,
        zindex = 20,
        on_attach = nil,
      },
    },
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  -- TODO: Create a refactor hydra keymap
  --
  -- Create moves, traversal and selections maps
  opts = {
    ensure_installed = { "all" },
    sync_install = false,
    auto_install = true,

    highlight = {
      enabled = true,
      additional_vim_regex_highlight = false,
      -- NOTE: Can use this to customise some colorscheme stuff
      --
      -- Highlight the @foo.bar capture group with the "Identifier" highlight group
      -- vim.api.nvim_set_hl(0, "@foo.bar", { link = "Identifier" })
    },
    incrimental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn",
        node_incrimental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm",
      },
    },
    indent = {
      enable = true,
    },
    textobjects = {
      select = {
        enable = true,

        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,

        keymaps = {
          -- TODO: Define more selections for things like loops, conds and comments
          ["af"] = { query = "@function.outer", desc = "Select Outer [F]untion" },
          ["if"] = { query = "@function.inner", desc = "Select [I]nner [F]unction" },
          ["ac"] = { query = "@class.outer", desc = "Select Outer [C]lass" },
          ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
          -- You can also use captures from other query groups like `locals.scm`
          ["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
        },
        selection_modes = {
          ['@parameter.outer'] = 'v',
          ['@function.outer'] = 'V',
          ['@function.inner'] = 'V',
          ['@class.outer'] = '<c-v>',
          ['@class.inner'] = '<c-v>',
          ['@local.scope'] = '<c-v>',
        },
        include_surrounding_whitespace = true,
      },
      swap = {
        -- TODO: Create more swaps, like functions, classes, scopes, loops and conds
        enable = true,
        swap_next = {
          ["<leader>tp"] = { query = "@parameter.inner", desc = "Swap [P]aramater Inner" },
        },
        swap_previous = {
          ["<leader>tP"] = { query = "@parameter.inner", desc = "Swap [P]aramater Outer" },
        },
      },
      move = {
        -- TODO: Create more jumps comments, functions, classes, scopes, loops and conds
        -- TODO: Fix existing jumps
        -- TODO: Make keybind to add all moves to QuickFix List
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
        border = 'none',
        floating_preview_opts = {},
        peek_definition_code = {
          ["<leader>cpf"] = "@function.outer",
          ["<leader>cpc"] = "@class.outer",
          ["<leader>cpb"] = "@block.outer",
        },
      },
    },
  },
}
