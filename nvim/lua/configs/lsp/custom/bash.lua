local lspconfig    = require("lspconfig")
local util         = require "lspconfig/util"
-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local m_utils      = require('m_utils')

lspconfig.bashls.setup({
  capabilities = capabilities,
  -- cmd = { 'bash-language-server', 'start' },
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
  on_attach = function(client, bufnr)
    if client.server_capabilities.documentSymbolProvider then
      require("nvim-navic").attach(client, bufnr)
      require("nvim-navbuddy").attach(client, bufnr)
    end

    vim.keymap.set("n", "<leader>run", function()
      local this_file = m_utils.copy_absolute_path()
      local command = string.format(
        [[execute 'term chmod +x %s && sh %s']],
        this_file,
        this_file
      )
      vim.cmd(command)
    end)
  end
})
