local M = {}
function M.map(mode, lhs, rhs, desc, bufnr)
  if desc then
    desc = desc
  end
  vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc, buffer = bufnr, noremap = true })
end
return M
