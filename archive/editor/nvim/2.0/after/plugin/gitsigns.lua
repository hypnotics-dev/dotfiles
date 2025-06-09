local helpers = require("helpers.misc")
local map = helpers.map

local gitsigns = require("gitsigns")

map('n', {']c', "<leader>gn"}, function()
  if vim.wo.diff then
    vim.cmd.normal({ ']h', bang = true })
  else
    gitsigns.nav_hunk('next')
  end
end, "[G]it [N]ext Hunk")

map('n', {'[c', "<leader>gp"}, function()
  if vim.wo.diff then
    vim.cmd.normal({ '[h', bang = true })
  else
    gitsigns.nav_hunk('prev')
  end
end, "[G]it [P]rev Hunk")

map('n', '<leader>gs', gitsigns.stage_hunk, { desc = "[S]tage Hunk" })
map('n', '<leader>gr', gitsigns.reset_hunk, { desc = "[R]eset Hunk" })
map('n', '<leader>gu', gitsigns.undo_stage_hunk, { desc = "[U]ndo Stage Hunk" })
map('n', '<leader>gv', gitsigns.preview_hunk, { desc = "[P]review Hunk" })
map('n', '<leader>gb', function() gitsigns.blame_line { full = true } end, { desc = "[B]lame Line" })
map('n', '<leader>gB', gitsigns.toggle_current_line_blame, { desc = "[B]lame Current Line" })
map('n', '<leader>gdd', gitsigns.diffthis, { desc = "[D]iff This" })
map('n', '<leader>gdd', gitsigns.toggle_deleted, { desc = "[D]eleted" })
map('n', '<leader>gh', '<cmd>Gitsigns toggle_linehl<CR>', { desc = "[H]ighlts Lines" })
map('n', '<leader>g%', gitsigns.reset_buffer, { desc = "[R]eset Buffer" })

map('v', 'ggs', function() gitsigns.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
  { desc = "[S]tage Hunk" })
map('v', 'ggr', function() gitsigns.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
  { desc = "[R]eset Hunk" })
map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
