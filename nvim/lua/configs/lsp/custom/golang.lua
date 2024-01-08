local lspconfig = require("lspconfig")
local util = require "lspconfig/util"

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local map = require "m_utils/mapping".map
lspconfig.gopls.setup {
  capabilities = capabilities,
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
