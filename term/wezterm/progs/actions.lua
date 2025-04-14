local M = {}
local wez = require 'wezterm'
local sh = wez.run_child_process

M.update = {}

function M.update.git()
  local good, _, err = sh {
    label = "Updates each git repository inside dev/git",
    args = {
      'bash','-c \'for i in $(ls);do \
      cd "$i"; git pull ;cd ..;done\'',
    },
    cwd = "~/dev/git/"
  }

  if not good then
    wez.log_error('[FAILURE] failed to update git repositories\nmsg: ' .. err)
    print("Failed to update")
    return nil
  end
end

function M.edit_wezterm_location_file()
  local good, _, err = sh {
    label = "Opens selected wezterm location file in nvim",
    args = {
      'bash', '-c \'nv $(ls|fzf)\''
    },
    cwd = "~/.config/wezterm/conf/",
  }

  if not good then
    wez.log_error('[FAILURE] failed to open location file\nmsg: ' .. err)
    print("Failed to open file:\n" .. err)
    return nil
  end
end

function M.refresh_quicklist()
  local good,_,err = sh {
    label = "Adds or removes items from the quicklist",
    args = {
      'bash', '-c \'fd --type d|fzf -- \''
    }
  }
end

return M
