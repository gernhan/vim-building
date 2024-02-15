local M = {}

local function get_env_command()
  local java_configurations = require("configs.lsp.custom.java.configuration")
  local env_command = java_configurations.get_env_command() or ''
  return env_command ~= '' and env_command .. ' && ' or ''
end

function M.get_test_runner(test_name, debug)
  if debug then
    return 'mvn test -Dmaven.surefire.debug -Dtest="' .. test_name .. '"'
  end
  return 'mvn test -Dtest="' .. test_name .. '"'
end

function M.run_java_test_method(debug)
  debug = debug or false
  local utils = require 'configs.lsp.custom.java.treesitters'
  local method_name = utils.get_current_full_method_name("\\#")
  local runner = M.get_test_runner(method_name, debug)

  local command = string.format(
    [[execute 'term %s']],
    'echo ' .. runner .. ' && ' .. runner
  )
  print(command)
  vim.cmd(command)
end

function M.run_java_test_class(debug)
  debug = debug or false
  local utils = require 'configs.lsp.custom.java.treesitters'
  local class_name = utils.get_current_full_class_name()
  local runner = M.get_test_runner(class_name, debug)
  print(runner)

  local command = string.format(
    [[execute 'term %s']],
    get_env_command() .. 'echo ' .. runner .. ' && ' .. runner
  )
  print(command)
  vim.cmd(command)
end

function M.map_functions()
  local java_utils = require("configs.lsp.custom.java.utils")

  local map = function(mode, lhs, rhs, desc)
    java_utils.map(mode, lhs, rhs, desc, 0)
  end

  map("n", "<leader>tm", function() M.run_java_test_method() end, "Test this method")
  map("n", "<leader>tM", function() M.run_java_test_method(true) end, "Test this method in debug mode")
  map("n", "<leader>tc", function() M.run_java_test_class() end, "Test this class")
  map("n", "<leader>tC", function() M.run_java_test_class(true) end, "Test this class in debug mode")
end

return M
