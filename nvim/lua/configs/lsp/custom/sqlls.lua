local lspconfig = require("lspconfig")
local opts      = require("configs.lsp.custom.general-opts")

local other_opts = {
  cmd = { "sql-language-server", "up", "--method", "stdio" },
  filetypes = { "sql", "vw" },
}

require("m_utils").mergeTable(other_opts, opts)
lspconfig.sqlls.setup(opts)

