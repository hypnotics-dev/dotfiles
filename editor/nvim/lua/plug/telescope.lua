return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-ui-select.nvim" },
    "debugloop/telescope-undo.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  opts = {
    defaults = {
      mappings = {
        i = {
          ["<c-enter>"] = "to_fuzzy_refine",
          ["<C-j>"] = "move_selection_next",
          ["<C-k>"] = "move_selection_previous",
          ["<C-u>"] = "preview_scrolling_up",
          ["<C-d>"] = "preview_scrolling_down",
          ["<enter>"] = "select_default",
          ["<c-x>"] = "delete_buffer",
          ["<c-g>"] = "close"
        },
        n = {
          ["j"] = "move_selection_next",
          ["k"] = "move_selection_previous",
          ["<C-j>"] = "move_selection_next",
          ["<C-k>"] = "move_selection_previous",
          ["G"] = "move_to_bottom",
          ["gg"] = "move_to_bottom",
          ["u"] = "results_scrolling_up",
          ["d"] = "results_scrolling_down",
          ["enter"] = "select_default",
          ["<c-x>"] = "delete_buffer",
          ["<c-g>"] = "close"
        },
      },
    },
    extensions = {
      ["ui-select"] = {
        require("telescope.themes").get_dropdown(),
      },
      undo = { 
        side_by_side = true,
        layout_strategy = "vertical", -- TODO: Might change
        layout_config = {
          preview_height = 0.8,
        },-- Broken, why? 
        -- mappings = {
        --   i = {
        --     ['<cr>'] = require('telescope-undo.actions').restore,
        --     ['<C-a'] = require('telescope-undo.actions').yank_additions,
        --     ['<C-d'] = require('telescope-undo.actions').yank_deletions,
        --   },
        --   n = {
        --     ["a"] = require("telescope-undo.actions").yank_additions,
        --     ["d"] = require("telescope-undo.actions").yank_deletions,
        --     ["<cr>"] = require("telescope-undo.actions").restore,
        --   }
        -- }
      },
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
    },
  },
  config = function(_,opts)
    require("telescope").setup(opts)

    pcall(require("telescope").load_extension("ui-select"))
    pcall(require("telescope").load_extension("undo"))
    pcall(require("telescope").load_extension("fzf"))
  end,
}
