local M = {}

function M.getAll(folder_path, ignored_files)
  local plugins = {}
  -- Iterate through Lua files and perform actions
  local lua_files = require("m_utils.files").listLuaFiles(folder_path, ignored_files)

  for _, file in pairs(lua_files) do
    local full_path = folder_path .. '/' .. file
    local success, module = pcall(require, full_path:gsub("%.lua$", ""))

    if success then
      table.insert(plugins, module)
    else
      print("Error loading module from file:", full_path)
      print("Error message:", module)
    end
  end
  return plugins
end

return M
