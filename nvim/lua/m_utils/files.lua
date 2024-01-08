-- Function to list all Lua files in a folder
local M = {}

function M.listLuaFiles(folder, ignored_files)
  local files = vim.fn.readdir(folder)
  local lua_files = {}

  for _, file in ipairs(files) do
    if file:match("%.lua$") then
      if not ignored_files[file] then
        table.insert(lua_files, file)
      end
    end
  end

  return lua_files
end

return M
