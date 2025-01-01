return {
  {
    'mfussenegger/nvim-dap',
    event = "VeryLazy",
    dependencies = {
      -- Creates a beautiful debugger UI
      {
        'rcarriga/nvim-dap-ui',
        opts = {
          element_mappings = {},
          expand_lines = true,
          floating = {
            border = "single",
            mappings = {
              close = { "q", "<Esc>" }
            }
          },
          force_buffers = true,
          icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
          controls = {
            element = "repl",
            enabled = true,
            icons = {
              pause = '⏸',
              play = '▶',
              step_into = '⏎',
              step_over = '⏭',
              step_out = '⏮',
              step_back = 'b',
              run_last = '▶▶',
              terminate = '⏹',
              disconnect = '⏏',
            },
          },
          layouts = { {
            elements = { {
              id = "scopes",
              size = 0.25
            }, {
              id = "breakpoints",
              size = 0.25
            }, {
              id = "stacks",
              size = 0.25
            }, {
              id = "watches",
              size = 0.25
            } },
            position = "left",
            size = 40
          }, {
            elements = { {
              id = "repl",
              size = 0.5
            }, {
              id = "console",
              size = 0.5
            } },
            position = "bottom",
            size = 10
          } },
          mappings = {
            edit = "e",
            expand = { "<CR>", "<2-LeftMouse>" },
            open = "o",
            remove = "d",
            repl = "r",
            toggle = "t"
          },
          render = {
            indent = 1,
            max_value_lines = 100
          }
        },
      },

      -- Required dependency for nvim-dap-ui
      'nvim-neotest/nvim-nio',

      -- {
      --   'theHamsta/nvim-dap-virtual-text',
      --   opts = {
      --     enabled = true,                               -- enable this plugin (the default)
      --     enabled_commands = true,                      -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
      --     highlight_changed_variables = true,           -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
      --     highlight_new_as_changed = false,             -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
      --     show_stop_reason = true,                      -- show stop reason when stopped for exceptions
      --     commented = false,                            -- prefix virtual text with comment string
      --     only_first_definition = true,                 -- only show virtual text at first definition (if there are multiple)
      --     all_references = false,                       -- show virtual text on all all references of the variable (not only definitions)
      --     clear_on_continue = false,                    -- clear virtual text on "continue" (might cause flickering when stepping)
      --     -- position of virtual text, see `:h nvim_buf_set_extmark()`, default tries to inline the virtual text. Use 'eol' to set to end of line
      --     virt_text_pos = vim.fn.has 'nvim-0.10' == 1 and 'inline' or 'eol',
      --   }
      -- },

    },
    config = function()
      local dap = require 'dap'
      local dapui = require 'dapui'

      -- Put in a key map somewhere
      -- -- Basic debugging keymaps, feel free to change to your liking!
      -- vim.keymap.set('n', '<leader>dc', dap.continue, { desc = '[D]ebug: Start/[C]ontinue' })
      -- vim.keymap.set('n', '<leader>di', dap.step_into, { desc = '[D]ebug: Step [I]nto' })
      -- vim.keymap.set('n', '<leader>do', dap.step_over, { desc = '[D]ebug: Step [O]ver' })
      -- vim.keymap.set('n', '<leader>dt', dap.step_out, { desc = '[D]ebug: Step Ou[t]' })
      -- vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint,
      --   { desc = '[D]ebug: Toggle [B]reakpoint' })
      -- vim.keymap.set('n', '<leader>dB', function()
      --   dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      -- end, { desc = '[D]ebug: Set [B]reakpoint' })
      --
      -- -- Dap UI setup
      -- -- For more information, see |:help nvim-dap-ui|
      -- -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
      -- vim.keymap.set('n', '<leader>du', dapui.toggle, { desc = '[D]ebug: See last session result.' })
      --
      dap.listeners.after.event_initialized['dapui_config'] = dapui.open
      dap.listeners.before.event_terminated['dapui_config'] = dapui.close
      dap.listeners.before.event_exited['dapui_config'] = dapui.close
    end,
  },
}
