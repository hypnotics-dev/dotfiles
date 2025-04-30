local M = {}

--- TODO Concats t2 to t1
---@param t1 table
---@param t2 table
---@return table
function M.table_concat(t1,t2)
  for _, value in ipairs(t2) do
    table.insert(t1, value)
  end
  return t1
end

--- Gives all prog lanchers as a table
---@return table
function M.get_progs()
  local tbl = require "progs.mux"
  M.table_concat(tbl, require("progs.nvim"))
  M.table_concat(tbl, require("progs.data"))
  M.table_concat(tbl, require("progs.traverse"))
  return tbl
end

function M.merge(config,table)
  for k,v in pairs(table) do config[k] = v end
  return config
end

return M
