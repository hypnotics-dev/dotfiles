local M = {}
local wez = require 'wezterm'
local sh = wez.run_child_process

-- TODO: Rewrite all of these, fzf does not work with run_child_proc
-- We need to use send_text or something like that to send the command to the shell
-- Or we can try and do it all with the wezterm picker?

function M.uni()
  local good, _, err = sh {
    label = "Goto an active university directory",
    args = {
      'cd $(', 'cat', '~/.config/wezterm/conf/uni.txt|fzf)'
    },
    cwd = "~/uni/"
  }
  if not good then
    wez.log_error("[ERROR] Failed to get to uni a dir\nmsg: " .. err)
    return nil
  end
end

function M.projects()
  local good, _, err = sh {
    label = "Goto a project or assignment",
    args = {
      'cd $(for i in $(cat', '~/.config/wezterm/conf/active.txt;ls', '-d',
      '*/);do', 'echo', '$i;done|fzf)',
    },
    cwd = "~/dev/proj/",
  }

  if not good then
    wez.log_error("[ERROR] Failed to goto a project or an assignment\nmsg: " .. err)
    print("Failed to goto dir\n" .. err)
    return nil
  end
end

function M.quicklist()
  local good, _, err = sh {
    label = "Goto to common or very nested directories predefined directories",
    args = {
      'bash', '-c \'cd $(cat quicklist.txt|fzf)\''
    },
    cwd = "~/.config/wezterm/conf/"
  }

  if not good then
    wez.log_error("[ERROR] failed to goto a quick dir\nmsg " .. err)
    print("Failed to goto dir:\n" .. err)
    return nil
  end
end

return M
