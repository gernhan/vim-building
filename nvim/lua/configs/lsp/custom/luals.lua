local lspconfig = require("lspconfig")
local opts      = require("configs.lsp.custom.general-opts")

require("neodev").setup({})

opts.settings = {
  Lua = {
    completion = {
      callSnippet = "Replace"
    }
  }
}

lspconfig.lua_ls.setup(opts)
