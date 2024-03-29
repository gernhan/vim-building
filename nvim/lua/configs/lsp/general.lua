local utils = require("m_utils")

vim.keymap.set("n", "gd", function()
  utils.goToDefinition()
end, {})

vim.keymap.set("n", "gt", function()
  utils.goToTypeDefinition()
end, {})

vim.keymap.set("n", "<leader>gdsv", function()
  vim.cmd([[ vsplit ]])
  vim.lsp.buf.definition()
end, {})

vim.keymap.set("n", "<leader>gdsh", function()
  vim.cmd([[ split ]])
  vim.lsp.buf.definition()
end, {})

vim.keymap.set("n", "K", function()
  vim.lsp.buf.hover()
end, {})
vim.keymap.set("n", "<leader>vws", function()
  vim.lsp.buf.workspace_symbol()
end, {})

vim.keymap.set("n", "<leader>X", function()
  utils.diagnostics()
  -- vim.diagnostic.open_float()
end, {})
vim.keymap.set("n", "<leader>xx", function()
  -- utils.diagnostics()
  vim.diagnostic.open_float()
end, {})
vim.keymap.set("n", "me", function()
  vim.diagnostic.goto_next()
end, {})
vim.keymap.set("n", "mE", function()
  vim.diagnostic.goto_prev()
end, {})
vim.keymap.set("n", "<leader>ca", function()
  vim.lsp.buf.code_action()
  utils.callEsc()
end, {})
vim.keymap.set("n", "gr", function()
  utils.goToReferences()
end, {})

-- vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, {})
vim.keymap.set("n", "<leader>rl", function()
  vim.lsp.buf.format({ timeout_ms = 10000 })
  utils.save_this_buffer()
end, {})
vim.keymap.set("n", "gi", function()
  require("telescope.builtin").lsp_implementations()
  utils.callEsc()
end, {})
-- vim.keymap.set("n", "gi", ":Telescope lsp_implementations<cr>", {})
vim.keymap.set("n", "<leader>rn", function()
  vim.lsp.buf.rename()
  utils.save_this_buffer()
end, {})
-- vim.keymap.set("n", "<leader>rn", function()
--   return ":IncRename " .. vim.fn.expand("<cword>")
-- end, { expr = true })
vim.keymap.set("i", "<C-k>", function()
  vim.lsp.buf.signature_help()
end, {})
