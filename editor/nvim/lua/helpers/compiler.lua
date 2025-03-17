local M = {}
local term = require("helpers.term")

function M.dune_cont_builder ()
  local term_info = term.make_tabterm(true)
  vim.fn.chansend(term_info.job_id, {"dune build -w \r\n"})
end

return M
