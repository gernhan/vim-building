local lspconfig = require("lspconfig")
local util = require "lspconfig/util"

-- Setup language servers.
lspconfig.awk_ls.setup({})
-- lspconfig.cssls.setup({})
lspconfig.eslint.setup({})
local map = require "utils/mapping".map
lspconfig.gopls.setup {
  on_attach = function(_, bufnr)
    map("n", "mpm", 'k/^func.*(<cr>N$F)%b:nohlsearch<Bar><CR>',
      "Move to last function")
    map("n", "mnm", 'e?^func.*(<cr>Nf(b:nohlsearch<Bar><CR>',
      "Move to next function")

    map("n", "<leader>vb", 'va{', "Visualize whole block")
    map("n", "<leader>vf", '/^func.*(<cr>Nf(b/{<CR>v%', "Visualize whole function")

    map("n", "<leader>go", function()
      vim.lsp.buf.code_action({ context = { only = { 'source.organizeImports' } }, apply = true })
    end, "Organize Imports", bufnr)
    map({ "n", "v" }, "<leader>ref", function()
      vim.lsp.buf.code_action({ context = { only = { 'refactor.extract' } }, apply = true })
    end, "Extract Function", bufnr)
    map({ "n", "v" }, "<leader>gm", function()
      vim.lsp.buf.code_action({ context = { only = { 'refactor.extract' } }, apply = true })
    end, "Extract Function", bufnr)
  end,
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
      },
    },
  },
}
-- lspconfig.grammarly.setup({})
lspconfig.sqlls.setup({
  cmd = { "sql-language-server", "up", "--method", "stdio" },
  filetypes = { "sql", "vw" }
})

-- lspconfig.tailwindcss.setup({})
lspconfig.pyright.setup({})
lspconfig.tsserver.setup({})
lspconfig.lemminx.setup({})
lspconfig.ltex.setup({})
lspconfig.rust_analyzer.setup({
  -- Server-specific settings. See `:help lspconfig-setup`
  settings = {
    ["rust-analyzer"] = {},
  },
})
