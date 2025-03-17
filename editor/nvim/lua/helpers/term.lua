local M = {}

local function data()
  return {
    job_id = vim.bo.channel,
    bufnr = vim.api.nvim_get_current_buf()
  }
end

--- Creates a small terminal at the bottom of the screen
---@return table
function M.make_small_term()
  vim.cmd.split()
  vim.cmd.term()
  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, 15)
  vim.cmd.startinsert()
  return data()
end

--- Creates a terminal in the next tab 
--- TODO try to place term in tab #3 first
--- TODO add option to ignore 3rd tab rule
--- @param silent boolean
--- @param tab integer?
--- @return table
function M.make_tabterm(silent,tab)
  vim.cmd.tabnew()
  vim.cmd.term()
  vim.cmd.startinsert()
  local tmp=data()
  if silent then
    vim.cmd.tabprevious()
  end
  return tmp
end

return M
