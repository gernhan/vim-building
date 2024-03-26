local lspconfig = require("lspconfig")
local opts      = require("configs.lsp.custom.general-opts").default
local m_utils   = require("m_utils")

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

-- lspconfig.tsserver.setup(opts)
lspconfig.tsserver.setup({
  on_attach = function(client, bufnr)
    vim.lsp.codelens.refresh()

    if client.server_capabilities.documentSymbolProvider then
      require("nvim-navic").attach(client, bufnr)
      require("nvim-navbuddy").attach(client, bufnr)
    end
    map("n", "<leader>go", ts_organize_imports, "Organize Imports", bufnr)

    vim.keymap.set("n", "<leader>run", function()
      local this_file = m_utils.copy_absolute_path()
      local command = string.format(
        [[execute 'term node %s']],
        this_file
      )
      vim.cmd(command)
    end)
  end,
})
