local lspconfig = require("lspconfig")
-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local map = require "m_utils/mapping".map

local function ts_organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(0) },
    title = ""
  }
  vim.lsp.buf.execute_command(params)
end

lspconfig.tsserver.setup({
  capabilities = capabilities,
  filetypes = { "javascript", "typescript", "typescriptreact", "typescript.tsx" },
  root_dir = function() return vim.loop.cwd() end,
  commands = {
    OrganizeImports = {
      ts_organize_imports,
      description = "Organize Imports"
    }
  },
  on_attach = function(_, bufnr)
    map("n", "<leader>go", ts_organize_imports, "Organize Imports", bufnr)
  end,
})
