return {
  {
    "williamboman/mason.nvim",
    run = ":MasonUpdate", -- :MasonUpdate updates registry contents
    config = function()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          -- lsp-servers,
          "lua_ls",
          "rust_analyzer",
          "bashls",
          "gopls",
          "html",
          "jdtls",
          "jsonls",
          "lemminx",
          "ltex",
          "marksman",
          "pyright",
          "sqlls",
          "tsserver",
        },
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("configs.lsp.general")
      require("configs.lsp.custom")
    end
  }
}
