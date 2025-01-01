return {
  { -- Might Remove
    "folke/todo-comments.nvim",
    event = "BufEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      keywords = {
        FIX = {
          icon = " ", -- icon used for the sign, and in search results
          color = "error", -- can be a hex color, or a named color (see below)
          alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
        },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      },
      gui_style = {
        fg = "NONE",         -- The gui style to use for the fg highlight group.
        bg = "BOLD",         -- The gui style to use for the bg highlight group.
      },
      merge_keywords = true, -- when true, custom keywords will be merged with the defaults
      -- highlighting of the line containing the todo comment
      -- * before: highlights before the keyword (typically comment characters)
      -- * keyword: highlights of the keyword
      -- * after: highlights after the keyword (todo text)
      highlight = {
        multiline = false,    -- enable multine todo comments
        keyword = "wide",     -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
        after = "fg",         -- "fg" or "bg" or empty
        comments_only = true, -- uses treesitter to match keywords in comments only
        max_line_len = 80,    -- ignore lines longer than this
        exclude = {},         -- list of file types to exclude highlighting
      },
      colors = {
        error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
        warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
        info = { "DiagnosticInfo", "#2563EB" },
        hint = { "DiagnosticHint", "#10B981" },
        default = { "Identifier", "#7C3AED" },
        test = { "Identifier", "#FF00FF" }
      },
      search = {
        command = "rg",
        args = {
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
        },
        pattern = [[\b(KEYWORDS):]],
      },
      signs = false,
    },
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
        signcolumn                   = true,
        numhl                        = true,
        linehl                       = false,
        word_diff                    = false,
        watch_gitdir                 = {
          follow_files = true
        },
        auto_attach                  = true,
        attach_to_untracked          = false,
        current_line_blame           = false,
        current_line_blame_opts      = {
          virt_text = true,
          virt_text_pos = 'overlay', -- 'eol' | 'overlay' | 'right_align'
          delay = 500,
          ignore_whitespace = false,
          virt_text_priority = 100,
        },
        current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
        sign_priority                = 6,
        update_debounce              = 100,
        status_formatter             = nil,   -- Use default
        max_file_length              = 40000, -- Disable if file is longer than this (in lines)
        preview_config               = {
          border = 'single',
          style = 'minimal',
          relative = 'cursor',
          row = 0,
          col = 1
        },
        -- TODO: Move these to a keymap file somewhere
        --
        -- map('n', ']c', function()
        --   if vim.wo.diff then
        --     vim.cmd.normal({ ']h', bang = true })
        --   else
        --     gitsigns.nav_hunk('next')
        --   end
        -- end)
        --
        -- map('n', '[c', function()
        --   if vim.wo.diff then
        --     vim.cmd.normal({ '[h', bang = true })
        --   else
        --     gitsigns.nav_hunk('prev')
        --   end
        -- end)
        --
        -- map('n', '<leader>gS', gitsigns.stage_hunk, { desc = "[S]tage Hunk" })
        -- map('n', '<leader>gr', gitsigns.reset_hunk, { desc = "[R]eset Hunk" })
        -- map('v', 'gs', function() gitsigns.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
        --   { desc = "[S]tage Hunk" })
        -- map('v', 'gr', function() gitsigns.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
        --   { desc = "[R]eset Hunk" })
        -- map('n', '<leader>gu', gitsigns.undo_stage_hunk, { desc = "[U]ndo Stage Hunk" })
        -- map('n', '<leader>gR', gitsigns.reset_buffer, { desc = "[R]eset Buffer" })
        -- map('n', '<leader>gp', gitsigns.preview_hunk, { desc = "[P]review Hunk" })
        -- map('n', '<leader>gb', function() gitsigns.blame_line { full = true } end, { desc = "[B]lame Line" })
        -- map('n', '<leader>gtb', gitsigns.toggle_current_line_blame, { desc = "[B]lame Current Line" })
        -- map('n', '<leader>gd', gitsigns.diffthis, { desc = "[D]iff This" })
        -- map('n', '<leader>gtd', gitsigns.toggle_deleted, { desc = "[D]eleted" })
        -- map('n', '<leader>gth', '<cmd>Gitsigns toggle_linehl<CR>', { desc = "[H]ighlts Lines" })
        -- map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
        --
        -- vim.keymap.set("n", "]t", function()
        --   require("todo-comments").jump_next()
        -- end, { desc = "Next todo comment" })
        --
        -- vim.keymap.set("n", "[t", function()
        --   require("todo-comments").jump_prev()
        -- end, { desc = "Previous todo comment" })
      }
    end
  },
}
