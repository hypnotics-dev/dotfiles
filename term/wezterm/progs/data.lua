local M = {}
local wez = require 'wezterm'
local sh = wez.run_child_process

--- outputs stderr on failure, else outputs stdout
---@param good boolean
---@param out string
---@param err string
local function output(good,out,err)
  if good then
    print(out)
  else
    print(err)
  end
end

function M.downloads()
  local good,out,err = sh {
    label = "List files in ~/downloads/",
    args = {'ls', '-l', '~/downloads/'},
  }
  output(good, out, err)
end

function M.updates()
  local good, out, err = sh {
    label = "Shows number of updates, time since last update and important packages with updates",
    args = {'checkupdates|', 'wc -l'},
  }
  if good then
    print(out)
  else
    print("[FAILURE] " .. err)
    wez.log_error('[FAILURE] failed to check package updates\nmsg: ' .. err)
  end
end

return M
