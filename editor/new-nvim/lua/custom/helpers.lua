local M = {}

---Key mapper helper function
---@param map string|string[]
---@param key string
---@param func string|function
---@param opt string|table|nil
function M.map(map, key, func, opt)

  if (type(opt) == "string") then
    opt = {desc = opt, silent = true}
  elseif (opt == nil) then
    opt = {}
  end

  vim.keymap.set(map,key,func,opt)
end
