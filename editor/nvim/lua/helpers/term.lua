local M = {}

M.data = {
  job_id = nil,
  bufnr = nil,
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
  M.data.bufnr = nil
  M.data.job_id = nil
end

return M
