local M = {}
-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = require('cmp_nvim_lsp').default_capabilities()

function M.set_up_nvim_navic(client, bufnr)
  if client.server_capabilities.documentSymbolProvider then
    require("nvim-navic").attach(client, bufnr)
    require("nvim-navbuddy").attach(client, bufnr)
  end
end

M.default = {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    vim.lsp.codelens.refresh()
    M.set_up_nvim_navic(client, bufnr)
  end
}
return M
