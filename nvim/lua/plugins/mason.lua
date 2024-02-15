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
          "vimls",
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
    dependencies = {
      {
        "folke/neodev.nvim",
        "SmiteshP/nvim-navbuddy",
        "SmiteshP/nvim-navbuddy",
        dependencies = {
          "SmiteshP/nvim-navic",
          "MunifTanjim/nui.nvim"
        },
        opts = { lsp = { auto_attach = true } }
      }
    },
    config = function()
      require("configs.lsp.general")
      require("configs.lsp.custom")
    end
  },
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "VeryLazy",
  -- }
}
