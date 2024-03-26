local lspconfig = require("lspconfig")
local opts = require("configs.lsp.custom.general-opts").default
local custom_opts = require("configs.lsp.custom.general-opts")

-- Setup language servers.
lspconfig.awk_ls.setup({ on_attach = opts.on_attach })
lspconfig.jsonls.setup({ on_attach = opts.on_attach })
lspconfig.yamlls.setup({ on_attach = opts.on_attach })

-- lspconfig.eslint.setup(opts)
-- lspconfig.grammarly.setup(opts)
-- lspconfig.tailwindcss.setup(opts)
-- lspconfig.pyright.setup(opts)
lspconfig.lemminx.setup({ on_attach = opts.on_attach })
lspconfig.ltex.setup({ on_attach = opts.on_attach })
lspconfig.marksman.setup({
	on_attach = function(client, bufnr)
		custom_opts.set_up_nvim_navic(client, bufnr)
	end,
})
lspconfig.vimls.setup({ on_attach = opts.on_attach })
