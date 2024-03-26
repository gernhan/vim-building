local lspconfig  = require("lspconfig")
local opts       = require("configs.lsp.custom.general-opts")

local other_opts = {
  cmd = { "sql-language-server", "up", "--method", "stdio" },
  filetypes = { "sql", "vw" },
  on_attach = function(client, bufnr)
    opts.set_up_nvim_navic(client, bufnr)
  end
}

lspconfig.sqlls.setup(other_opts)
