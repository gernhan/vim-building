local lspconfig = require("lspconfig")
local opts      = require("configs.lsp.custom.general-opts")

-- Setup language servers.
lspconfig.awk_ls.setup(opts)
lspconfig.jsonls.setup(opts)
lspconfig.yamlls.setup(opts)

-- lspconfig.eslint.setup(opts)
-- lspconfig.grammarly.setup(opts)
-- lspconfig.tailwindcss.setup(opts)
lspconfig.pyright.setup(opts)
lspconfig.lemminx.setup(opts)
lspconfig.ltex.setup(opts)
lspconfig.marksman.setup(opts)
lspconfig.vimls.setup(opts)
