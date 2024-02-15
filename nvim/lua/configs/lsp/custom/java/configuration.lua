local M = {}

local java_utils = require("configs.lsp.custom.java.utils")
local map = java_utils.map

function M.get_configuration_directory()
  local treesitter_utils = require 'configs.lsp.custom.java.treesitters'
  local utils = require 'configs.lsp.custom.java.utils'
  local class_name = treesitter_utils.get_current_full_class_name()

  local workspace = utils.get_workspace()
  return workspace .. "/" .. class_name:gsub("%.", "/")
end

function M.get_env_path()
  return M.get_configuration_directory() .. "/env.sh"
end

function M.get_env_command()
  local file_utils = require("m_utils.io")
  local env_file = M.get_env_path()
  if file_utils.file_exists(env_file) then
    print("Exist file ", env_file)
    return 'source ' .. env_file
  end
  return ''
end

function M.edit_configuration()
  local directory = M.get_configuration_directory()
  -- Create directory if it doesn't exist
  vim.fn.mkdir(directory, "p")

  local command = string.format(
    [[e %s]],
    directory .. "/env.sh"
  )
  vim.cmd(command)
end

function M.map_functions()
  map(
    { "n", "v" },
    "<leader>irc",
    M.edit_configuration,
    "Edit java runner configurations"
  )
end

return M
