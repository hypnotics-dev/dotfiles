require("which-key").add({
  {"<leader>s"  , group = "[S]earch" },
  {"<leader>sg" , group = "[S]earch [G]it"},
  {"<leader>c"  , group = "[C]ode"},
  {"<leader>f"  , group = "[F]ile"},
  {"<leader>g"  , group = "[G]it"},
  {"<leader>t"  , group = "[T]reesitter"},
  {"<leader><leader>", group  = "Language Extensions"}
})
