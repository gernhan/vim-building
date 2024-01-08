local lspconfig = require("lspconfig")
-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local opts = { capabilities = capabilities }

-- Setup language servers.
lspconfig.awk_ls.setup(opts)
lspconfig.lua_ls.setup(opts)

-- lspconfig.eslint.setup(opts)
-- lspconfig.grammarly.setup(opts)
lspconfig.sqlls.setup({
  capabilities = capabilities,
  cmd = { "sql-language-server", "up", "--method", "stdio" },
  filetypes = { "sql", "vw" }
})

-- lspconfig.tailwindcss.setup(opts)
lspconfig.pyright.setup(opts)
lspconfig.lemminx.setup(opts)
lspconfig.ltex.setup(opts)
lspconfig.rust_analyzer.setup({
  -- Server-specific settings. See `:help lspconfig-setup`
  settings = {
    ["rust-analyzer"] = {},
  },
  capabilities = capabilities
})
