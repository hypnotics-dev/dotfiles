local hydra = require("hydra")
local nv = { "n", "v" }

-- Side Scroller
hydra({
  name = "Side scroll",
  

  -- Vim mode
  mode = nv,

  -- Key to activte hydra
  body = "z", -- will enter hydra on z + {head key}

  -- Heads a.k.a keymap
  heads = {
    { "h", "5zh" },
    { "l", "5zl", { desc = "←/→" } },
    { "H", "zH" },
    { "L", "zL", { desc = "half screen ←/→" },
    } },
})

-- Window Switcher

hydra({
  hint = [[
			_l_: focus right      _k_: focus up          _j_: focus down        _h_: focus left
			_L_: move right       _K_: move up           _J_: move down         _H_: move left
			_a_: increase width   _s_: decrease height   _d_: increase height   _f_: decrease width
			^^                    _-_: split horizontal  _|_: split vertical    ^^
			^^                    _<Enter>_: quit        _q_: quit              ^^
			]],
  config = {
    invoke_on_body = true,
    hint = {
      position = 'bottom',
      border = 'rounded',
      type = "window",
    },
  },
  name = "Window Switcher",
  mode = 'n',
  body = '<C-w>t',
  heads = {
    { "l",       "<C-w>l" },
    { "k",       "<C-w>k" },
    { "j",       "<C-w>j" },
    { "h",       "<C-w>h" },
    { "L",       "<C-w>L" },
    { "K",       "<C-w>K" },
    { "J",       "<C-w>J" },
    { "H",       "<C-w>H" },
    { "a",       "<C-w>>" },
    { "s",       "<C-w>-" },
    { "d",       "<C-w>+" },
    { "f",       "<C-w><" },
    { "-",       "<C-w>s" },
    { "|",       "<C-w>v" },
    { "<Enter>", nil,     { exit = true } },
    { "q",       nil,     { exit = true } },
  }
})

-- Treesitter Navigator

hydra({
  name = "[T]reesitter",
  hint = [[
					_j_ _k_      : function
					_l_ _h_      : class
					_f_ _b_      : conditional
					_d_ _u_      : loop
					_z_ _Z_      : fold
					_/_ _?_      : comment
					_w_ _s_      : return
					_n_ _p_      : assignment
					_q_ _<Enter>_: quit
					]],
  config = {
    invoke_on_body = true,
    foreign_keys = "warn",
    hint = {
      position = "middle-right",
      type = "window",
      border = "shadow",

    },
  },
  body = "<leader>tn",
  heads = {
    { "j",       "]m" },
    { "l",       "]]" },
    { "f",       "]c" },
    { "d",       "]o" },
    { "z",       "]z" },
    { "/",       "]/" },
    { "w",       "]r" },
    { "n",       "]=" },

    { "k",       "[m" },
    { "h",       "[[" },
    { "b",       "[c" },
    { "u",       "[o" },
    { "Z",       "[z" },
    { "?",       "[/" },
    { "s",       "[r" },
    { "p",       "]=" },

    { "q",       nil, { exit = true } },
    { "<Enter>", nil, { exit = true } },
  }
})
