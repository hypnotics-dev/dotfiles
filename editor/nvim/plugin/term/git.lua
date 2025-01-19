local helpers = require("helpers.misc")
local term = require("helpers.term")
local map = helpers.map


-- TODO: does not try and reuese the existing term 
map("n", "<leader>gc", function ()
  -- TODO: Prevent execution if not in git buffer
  if (term.data.job_id == 0 or term.data.bufnr == 0)then
    term.make_small_term()
  end
  vim.fn.chansend(term.data.job_id, "emacsclient -cte '(magit)'\r\n")

end, "[G]it [C]ommit")


