-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local M = {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    vim.lsp.codelens.refresh()

    if client.server_capabilities.documentSymbolProvider then
      require("nvim-navic").attach(client, bufnr)
      require("nvim-navbuddy").attach(client, bufnr)
    end
  end
}
return M
