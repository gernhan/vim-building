local M = {}

function M.map(mode, lhs, rhs, desc, bufnr)
  if desc then
    desc = desc
  end
  vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc, buffer = bufnr, noremap = true })
end

-- Function to add all elements from one table to another
function M.addAll(sourceTable, destinationTable)
  for _, value in ipairs(sourceTable) do
    table.insert(destinationTable, value)
  end
end

return M
