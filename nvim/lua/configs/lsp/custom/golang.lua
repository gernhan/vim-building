local lspconfig    = require("lspconfig")
local util         = require "lspconfig/util"
local general_opts = require("configs.lsp.custom.general-opts")
local map          = require "m_utils/mapping".map

lspconfig.gopls.setup {
  capabilities = general_opts.capabilities,
  on_attach = function(client, bufnr)
    general_opts.on_attach(client, bufnr)

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

    local reload_command = 'command! GoReload execute "silent !pkill -USR1 ' ..
        vim.fn.expand("$HOME") ..
        '/.local/share/mvim/mason/packages/gopls/gopls" | echo "Go Language Server (gopls) reloaded."'
    vim.cmd(reload_command)

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
