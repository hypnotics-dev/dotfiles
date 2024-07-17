return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			require("which-key").setup({
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
				modes = {
					defer = {
						v = true,
					}
				},
			})
			require("which-key").add({
				{ "<leader>c", group = "[C]ode" },
				{ "<leader>s", group = "[S]earch" },
				{ "<leader>w", group = "[W]orkspace" },
				{ "<leader>t", group = "[T]oggle" },
				{ "<leader>d", group = "[D]ebug" },
				{ "<leader>f", group = "[F]ile" },
				{ "<leader>o", group = "Tr[o]uble" },
				{ "<leader>a", group = "[A]round" },
			})
		end,
	},
	{
		"anuvyklack/hydra.nvim",
		-- TODO: hydra ideas
		-- Dap mode keymap
		config = function()
			local hydra = require("hydra")
			local nv = { "n", "v" }
			-- create hydras in here
			-- For help with hydra use ':h hydra'
			hydra({
				-- Name of the hydra
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
			hydra({
				hint = [[
			_l_    : focus right     _k_    : focus up         _j_    : focus down       _h_    : focus left
			_<S-l>_: move right      _<S-k>_: move up          _<S-j>_: move down        _<S-h>_: move left
			_a_    : increase width  _s_    : decrease height  _d_    : increase height  _f_    : decrease width
			^^                       _-_    : split horizontal _|_    : split vertical   ^^
			^^                       _<Enter>_: quit           _q_    : quit
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
					{ "<S-l>",   "<C-w><S-l>" },
					{ "<S-k>",   "<C-w><S-k>" },
					{ "<S-j>",   "<C-w><S-j>" },
					{ "<S-h>",   "<C-w><S-h>" },
					{ "a",       "<C-w>>" },
					{ "s",       "<C-w>-" },
					{ "d",       "<C-w>+" },
					{ "f",       "<C-w><" },
					{ "-",       "<C-w>s" },
					{ "|",       "<C-w>v" },
					{ "<Enter>", nil,         { exit = true } },
					{ "q",       nil,         { exit = true } },
				}

			})
			hydra({
				name = "[T]reesitter Navigation",
				hint = [[
					_j_ _k_      : function
					_l_ _h_      : class
					_f_ _b_      : conditional
					_d_ _u_      : loop
					_z_ _<S-z>_  : fold
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
				body = "<leader>wt",
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
					{ "<S-z>",   "[z" },
					{ "?",       "[/" },
					{ "s",       "[r" },
					{ "p",       "]=" },

					{ "q",       nil, { exit = true } },
					{ "<Enter>", nil, { exit = true } },
				}
			})
		end,
	},
	--TODO: add nvim-spider plugin
}
