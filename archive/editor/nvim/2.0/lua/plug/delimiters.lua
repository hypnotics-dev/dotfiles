return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
    opts = {
      {
        -- Add more rules here when needed
        disable_filetype = { "TelescopePrompt", "spectre_panel" },
        enable_abbr = false,
        break_undo = true,
        check_ts = false,
        map_c_h = true,
        enable_check_bracket_line = true,
      },
    },
  },
  {
    "echasnovski/mini.surround",
    version = false,
    event = "VeryLazy",
    opts = {
      custom_surroundings = nil,
      mappings = {
        add = 'gsa',            -- Add surrounding in Normal and Visual modes
        delete = 'gsd',         -- Delete surrounding
        find = 'gsf',           -- Find surrounding (to the right)
        find_left = 'gsF',      -- Find surrounding (to the left)
        highlight = 'gsh',      -- Highlight surrounding
        replace = 'gsr',        -- Replace surrounding
        update_n_lines = 'gsn', -- Update `n_lines`

        -- suffix_last = 'l',      -- Suffix to search with "prev" method
        -- suffix_next = 'n',      -- Suffix to search with "next" method
      },

      n_lines = 20,
      respect_selection_type = true, -- TODO: Inspect later
      search_method = 'cover',
      silent = true,
    },
  },
}
