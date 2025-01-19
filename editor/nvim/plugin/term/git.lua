local helpers = require("helpers.misc")
local map = helpers.map


-- TODO: does not try and reuese the existing term 
map("n", "<leader>gc", function ()
  -- TODO: Prevent execution if not in git buffer
  if (vim.t.term_job == nil)then
    helpers.make_small_term()
  end
  vim.fn.chansend(vim.t.term_job, "emacsclient -cte '(magit)'\r\n")

end, "[G]it [C]ommit")


