local M = {}

function M.load(folder_full_path, ignored_files)
  -- Iterate through Lua files and perform actions
  local lua_files = require("m_utils.files").listLuaFiles(folder_full_path, ignored_files)

  for _, file in pairs(lua_files) do
    local full_path = folder_full_path .. '/' .. file
    local success, module = pcall(require, full_path:gsub("%.lua$", ""))

    if not success then
      print("Error loading module from file:", full_path)
      print("Error message:", module)
    end
  end
end

return M
