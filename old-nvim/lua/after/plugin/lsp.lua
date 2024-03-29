local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
  'tsserver',
  'rust_analyzer',
})

-- Fix Undefined global 'vim'
lsp.nvim_workspace()


local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<S-Tab>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<Tab>'] = cmp.mapping.select_next_item(cmp_select),
  ['<CR>'] = cmp.mapping.confirm({ select = true }),
  ["<C-CR>"] = cmp.mapping.complete(),
})
--
-- cmp_mappings['<Tab>'] = nil
-- cmp_mappings['<S-Tab>'] = nil
--
lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

lsp.set_preferences({
  suggest_lsp_servers = false,
  sign_icons = {
    error = 'E',
    warn = 'W',
    hint = 'H',
    info = 'I'
  }
})

lsp.skip_server_setup({ 'jdtls' })

-- lspconfig.jdtls.setup(jdtls_config)

---@diagnostic disable-next-line: unused-local
lsp.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "<leader>gdsv", function()
    vim.cmd [[ vsplit ]]
    vim.lsp.buf.definition()
  end, opts)

  vim.keymap.set("n", "<leader>gdsh", function()
    vim.cmd [[ split ]]
    vim.lsp.buf.definition()
  end, opts)

  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>xx", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "me", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "mE", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "gd", ":Telescope lsp_definitions<cr>", opts)
  -- vim.keymap.set("n", "gr", ":Telescope lsp_references<cr>", opts)
  vim.keymap.set("n", "gr", function()
    require "telescope.builtin".lsp_references({
      include_declaration = false,
      trim_text = true,
    })
  end, opts)
  -- vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>rl", function() vim.lsp.buf.format() end, opts)
  -- vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
  vim.keymap.set("n", "gi", ":Telescope lsp_implementations<cr>", opts)
  -- vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("n", "<leader>rn", function()
    return ":IncRename " .. vim.fn.expand("<cword>")
  end, { expr = true })
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

lsp.setup()

vim.diagnostic.config({
  virtual_text = true
})
