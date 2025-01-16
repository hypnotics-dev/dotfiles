local M = {}

---Key mapper helper function
---@param map string|string[]
---@param key string|table
---@param func string|function
---@param opt string|table|nil
function M.map(map, key, func, opt)

  if (type(opt) == "string") then
    opt = {desc = opt, silent = true}
  elseif (opt == nil) then
    opt = {}
  end

  if (type(key) == "string") then
    vim.keymap.set(map,key,func,opt)
  else
    for _, _key in ipairs(key) do
      vim.keymap.set(map, _key, func, opt)
    end
  end
end

return M
