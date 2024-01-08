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
lspconfig.bashls.setup({
  cmd = { 'bash-language-server', 'start' },
  settings = {
    bashIde = {
      -- Glob pattern for finding and parsing shell script files in the workspace.
      -- Used by the background analysis features across files.

      -- Prevent recursive scanning which will cause issues when opening a file
      -- directly in the home directory (e.g. ~/foo.sh).
      --
      -- Default upstream pattern is "**/*@(.sh|.inc|.bash|.command)".
      globPattern = vim.env.GLOB_PATTERN or '*@(.sh|.inc|.bash|.command)',
    },
  },
  filetypes = { 'sh' },
  root_dir = util.find_git_ancestor,
  single_file_support = true,
  docs = {
    description = [[
    https://github.com/bash-lsp/bash-language-server

    `bash-language-server` can be installed via `npm`:
    ```sh
    npm i -g bash-language-server
    ```

    Language server for bash, written using tree sitter in typescript.
    ]],
    default_config = {
      root_dir = [[util.find_git_ancestor]],
    },
  },
})
