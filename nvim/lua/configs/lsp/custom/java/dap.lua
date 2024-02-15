local M          = {}
local java_utils = require("configs.lsp.custom.java.utils")
local map        = java_utils.map

function M.attach_to_debug()
  local dap = require('dap')
  dap.configurations.java = {
    {
      type = 'java',
      request = 'attach',
      name = "Attach to the process",
      hostName = 'localhost',
      port = '5005',
    },
  }
  dap.continue()
end

-- view informations in debug
function M.show_dap_centered_scopes()
  local widgets = require 'dap.ui.widgets'
  widgets.centered_float(widgets.scopes)
end

function M.keymap_setup()
  map(
    { "n", "v" },
    "<leader>da",
    function()
      M.attach_to_debug()
    end,
    "Attach to debug"
  )

  -- setup debug
  map('n', '<leader>B', function()
    require "dap".set_breakpoint(vim.fn.input("Condition: "))
  end, "Set breakpoint with condition")

  map('n', '<leader>bc', function()
    require "dap".set_breakpoint(vim.fn.input("Condition: "))
  end, "Set breakpoint with condition")

  map('n', '<leader>bl', function()
    require "dap".set_breakpoint(nil, nil, vim.fn.input("Log: "))
  end, "Set breakpoint with log")

  map('n', '<leader>dr', function()
    require "dap".repl.open()
  end, "Set breakpoint with log")

  map('n', '<leader>ds', function()
    M.show_dap_centered_scopes()
  end, "Show dap")
end

return M
