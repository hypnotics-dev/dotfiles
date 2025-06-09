local helpers = require("helpers.misc")
local term = require("helpers.term")
local map = helpers.map


-- TODO: does not try and reuese the existing term 
-- TODO: Refactor to not use term.data
-- map("n", "<leader>gc", function ()
--   -- TODO: Prevent execution if not in git buffer
--   if (term.data.job_id == nil or term.data.bufnr == nil)then
--     term.make_small_term()
--   end
--   vim.fn.chansend(term.data.job_id, "emacsclient -cte '(magit)'\r\n")
--
-- end, "[G]it [C]ommit")


