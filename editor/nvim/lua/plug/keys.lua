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
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
    },
  },
}
