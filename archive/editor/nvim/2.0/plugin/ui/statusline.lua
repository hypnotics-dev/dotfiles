vim.o.laststatus = 3
--[[
-- Vision:
-- [Git Info]
-- [LSP Info]
-- [SPACER]
-- [File name 80char max or shortened|green if not changed, red if change (or make some highlight group)]
-- [SPACER]
-- [buffer type]
-- [mode]
-- [Line|Coulmn|File Percentage]
-- [Size of file in human readable]
-- [Language Icon]
--]]

-- local git = require("gitsigns")
local function spacer()
end
local function info()
  local gs = vim.b.gitsigns_status_dict
  -- Not git or lsp attached
  if gs == nil and vim.lsp.get_clients() == nil then
    return nil
  end
end

local function file_name()
end

local function buffer_type()
end

local function file_loc()
end

local function size()
end

local function lang_icon()
end

function Hyp_Set_Statusline()
  -- Get width of nvim (not of current window)
  local width = vim.cmd("echo winwidth(0)")
  local info = info()

end

-- Uncoment to set statusline
-- vim.o.statusline = "%{%v:lua.Status_Line()%}"
