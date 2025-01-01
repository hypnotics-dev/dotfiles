return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      delay = 500,
      plugins = {
        presets = {
          operators = false,
          motions = false,
        },
      },
      disable = {
        bt = {},
        ft = {},
      },
    },
    -- require("which-key").add({
    --   { "<leader>c",  group = "[C]ode" },
    --   { "<leader>cp", group = "[C]ode [P]eek" },
    --   { "<leader>cc", group = "[C]ode [C]omments" },
    --   { "<leader>cs", group = "[C]ode [S]nippets" },
    --   { "<leader>s",  group = "[S]earch" },
    --   { "<leader>sk", group = "[S]earch [K]eymaps" },
    --   { "<leader>w",  group = "[W]orkspace" },
    --   { "<leader>wC", group = "[W]orkspace [C]olorscheme" },
    --   { "<leader>d",  group = "[D]ebug" },
    --   { "<leader>f",  group = "[F]ile" },
    --   { "<leader>t",  group = "[T]rouble" },
    --   { "<leader>g",  group = "[G]it" },
    --   { "<leader>gt", group = "[T]oggles" },
    --   { "<leader>gs", group = "[S]earch" },
    -- })
  },
  "anuvyklack/hydra.nvim",
}
