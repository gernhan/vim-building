local lspconfig = require("lspconfig")
local opts      = require("configs.lsp.custom.general-opts")

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local map       = require "m_utils/mapping".map

local function ts_organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(0) },
    title = ""
  }
  vim.lsp.buf.execute_command(params)
end

local other_opts = {
  filetypes = { "javascript", "typescript", "typescriptreact", "typescript.tsx" },
  root_dir = function() return vim.loop.cwd() end,
  commands = {
    OrganizeImports = {
      ts_organize_imports,
      description = "Organize Imports"
    }
  },
  on_attach = function(client, bufnr)
    vim.lsp.codelens.refresh()

    if client.server_capabilities.documentSymbolProvider then
      require("nvim-navic").attach(client, bufnr)
      require("nvim-navbuddy").attach(client, bufnr)
    end
    map("n", "<leader>go", ts_organize_imports, "Organize Imports", bufnr)
  end,
}

require("m_utils").mergeTable(other_opts, opts)

lspconfig.tsserver.setup({
})
