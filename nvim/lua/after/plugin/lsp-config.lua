local lspconfig = require("lspconfig")

-- Setup language servers.
lspconfig.awk_ls.setup({})
-- lspconfig.cssls.setup({})
lspconfig.eslint.setup({})
lspconfig.gopls.setup({})
-- lspconfig.grammarly.setup({})
lspconfig.sqlls.setup({})

-- lspconfig.tailwindcss.setup({})
lspconfig.pyright.setup({})
lspconfig.tsserver.setup({})
lspconfig.shfmt.setup({})
lspconfig.rust_analyzer.setup({

	-- Server-specific settings. See `:help lspconfig-setup`
	settings = {
		["rust-analyzer"] = {},
	},
})
