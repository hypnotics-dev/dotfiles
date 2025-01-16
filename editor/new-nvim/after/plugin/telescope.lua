------------------------------------ Keymap ------------------------------------
local tl = require("telescope")
local tlb = require("telescope.builtin")
local helpers = require("custom.helpers")

helpers.map("n","<leader>sb", tlb.buffers, "[S]earch [B]uffers")
helpers.map("n","<leader>sc", tlb.commands, "[S]earch [C]ommands")
helpers.map("n","<leader>sC", function () vim.notify("TODO: implement cheatsheat", vim.log.levels.WARN) end, "[S]earch [C]eatsheat")
helpers.map("n","<leader>sd", tlb.diagnostics, "[S]earch [D]iagnostics")
helpers.map("n","<leader>sf", tlb.find_files, "[S]earch [F]iles")
helpers.map("n","<leader>sgb",tlb.git_branches, "[G]it [B]ranch")
helpers.map("n","<leader>sgc",tlb.git_commits, "[G]it [C]ommits")
helpers.map("n","<leader>sgt",tlb.git_bcommits, "[G]it Buffer Commi[t]s")
helpers.map("n","<leader>sgf",tlb.git_files, "[G]it [F]iles")
helpers.map("n","<leader>sgs",tlb.git_status, "[G]it [S]tatus")
helpers.map("n","<leader>sga",tlb.git_stash, "[G]it St[a]sh")
helpers.map("n","<leader>sh", tlb.help_tags,"[S]earch [H]elp Tags")
helpers.map("n","<leader>sk", tlb.keymaps, "[S]earch [K]eys")
helpers.map("n","<leader>sM", tlb.man_pages, "[S]earch [M]an Pages")
helpers.map("n","<leader>sm", tlb.marks,"[S]earch [M]arks")
helpers.map("n","<leader>sn", function () tlb.find_files {cwd = vim.fn.stdpath('config')} end, "[S]earch [N]eovim Files")
helpers.map("n","<leader>so", tlb.oldfiles, "[S]earch [O]ldfiles")
helpers.map("n","<leader>sq", tlb.quickfix, "[S]earch [Q]uickFix List")
helpers.map("n","<leader>s.", tlb.resume, "[S]earch [O]ld")
helpers.map("n","<leader>sR", tlb.registers, "[S]earch [R]egisters")
helpers.map("n","<leader>ss", tlb.live_grep, "[S]earch with grep")
helpers.map("n","<leader>sS", tlb.symbols, "[S]earch [S]ymbols")
helpers.map("n","<leader>st", function () vim.notify("TODO: implement todo search", vim.log.levels.WARN) end,"[S]earch [T]odo")
helpers.map("n","<leader>sT", tlb.treesitter,"[S]earch [T]reesitter")
-- TODO: In buffer fuzzy search


--------------------------------------------------------------------------------
