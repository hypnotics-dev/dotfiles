local M = {}

function M.map(map, key, func, opt)

  if (type(opt) == "string") then
    opt = {desc = opt, silent = true}
  elseif (opt == nil) then
    opt = {}
  end

  vim.keymap.set(map,key,func,opt)
end
