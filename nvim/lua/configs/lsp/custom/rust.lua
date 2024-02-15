local lspconfig  = require("lspconfig")
local opts       = require("configs.lsp.custom.general-opts")

local other_opts = {
  -- Server-specific settings. See `:help lspconfig-setup`
  settings = {
    ["rust-analyzer"] = {},
  },
}

require("m_utils").mergeTable(other_opts, opts)
lspconfig.rust_analyzer.setup(opts)
