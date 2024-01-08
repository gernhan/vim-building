local M = {}

function M.createSet(a_list)
  local set = {}
  for _, value in pairs(a_list) do
    set[value] = 1
  end
  return set
end

-- Function to add all elements from one table to another
function M.addAll(sourceTable, destinationTable)
  for _, value in ipairs(sourceTable) do
    table.insert(destinationTable, value)
  end
end

return M
