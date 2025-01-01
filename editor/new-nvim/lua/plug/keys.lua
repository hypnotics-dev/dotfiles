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
  },
  "anuvyklack/hydra.nvim",
}
