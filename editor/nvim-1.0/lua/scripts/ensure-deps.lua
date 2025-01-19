-- bootstrapping lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

local var = require("config.vars")

if vim.fn.findfile(var.sys.confPath .. "lua/config/hardware.lua") == nil then
    error("Missing hardware.lua file in " .. var.sys.confPath .. "lua/config")
end

local deps = function(args)
    local tbl = {
        ["Arch Linux"] = {
            deps = var.sys.deps.arch,
            query = "pacman -Qqi",
            sync = "sudo pacman -S",
        },
        -- TODO: add support for Void Linux
        ["Void Linux"] = {
            deps = var.sys.deps.void,
            query = "",
            sync = "",
        },
    }

    local os = tbl[var.hw.os]
    local missing = " "
    for _, v in ipairs(os.deps) do
        vim.fn.system(os.query .. " " .. v)
        if vim.v.shell_error ~= 0 then
            vim.notify("Missing package " .. v, vim.log.levels.WARN)
            vim.fn.system("echo " .. v .. ">> " .. var.sys.confPath .. "missing.log")
            missing = missing .. v .. "\n"
        end
    end
    if args.bang == true then return end
    if string.len(missing) > 1 then
        print("To install missing package run:" .. os.sync .. " $( cat " .. var.sys.confPath .. ") ")
    else
        vim.notify("All packages installed", vim.log.levels.INFO)
    end
end

-- deps iterator

vim.api.nvim_create_user_command(
    "DepsCheck",
    deps,
    {
        nargs = "?",
        desc = "Checks if all dependencies have been installed on the system",
        bang = true,
    })
