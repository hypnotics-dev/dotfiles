local M = {}

M.data = {
  job_id = 0,
  bufnr = 0,
}

function M.make_small_term()
  vim.cmd.split()
  vim.cmd.term()
  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, 15)
  vim.cmd.startinsert()
  M.data.job_id = vim.bo.channel
  M.data.bufnr = vim.api.nvim_get_current_buf()
end

function M.deconstructor()
  M.data.bufnr = 0
  M.data.job_id = 0
end

return M
