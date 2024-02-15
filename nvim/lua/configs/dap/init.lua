local M = {}

local function start_ui()
  require("dapui").setup()
  local dap, dapui = require("dap"), require("dapui")

  dap.listeners.before.attach.dapui_config = function()
    dapui.open()
  end
  dap.listeners.before.launch.dapui_config = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
  end
  dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
  end
end

local function start_mapping_keys()
  local dap = require("dap")
  local dapui = require("dapui")

  vim.keymap.set("n", "<leader>br", function()
      dap.toggle_breakpoint()
    end,
    { desc = "Toggle breakpoint at line" })

  vim.keymap.set("n", "<leader>dc", function()
      dap.continue()
    end,
    { desc = "Continue" })

  vim.keymap.set("n", "<leader>dn", function()
      dap.step_over()
    end,
    { desc = "Step Over" })

  vim.keymap.set("n", "<leader>dt", function()
      dap.terminate()
    end,
    { desc = "Terminate Debug Session" })

  vim.keymap.set("n", "<leader>di", function()
      dap.step_into()
    end,
    { desc = "Step Into" })

  vim.keymap.set("n", "<leader>de", function()
      dap.continue()
    end,
    { desc = "Continue" })

  vim.keymap.set("n", "<F9>", function()
      dap.continue()
    end,
    { desc = "Continue" })

  vim.keymap.set("n", "<leader>do", function()
      dapui.open()
    end,
    { desc = "Continue" })

  vim.keymap.set("n", "<leader>dt", function()
      dapui.close()
    end,
    { desc = "Continue" })

  vim.keymap.set("n", "<leader>dus",
    function()
      local widgets = require("dap.ui.widgets")
      local sidebar = widgets.sidebar(widgets.scopes)
      sidebar.open()
    end,
    { desc = "Open debugging sidebar" }
  )
end

function M.setup()
  start_ui()
  start_mapping_keys()
end

return M
