local augroup = vim.api.nvim_create_augroup("LspFormatingV1", {})
return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    local b = null_ls.builtins
    null_ls.setup({
      sources = {
        -- formaters
        -- b.formatting.google_java_format,
        b.formatting.stylua,
        b.formatting.beautysh,
        b.formatting.yamlfmt,
        b.formatting.prettier,
        b.formatting.mdformat,
        b.formatting.fixjson,
        b.formatting.black,
        b.formatting.isort,
        b.formatting.jq,
        b.formatting.gofumpt,
        b.formatting.goimports_reviser,
        b.formatting.golines,
        b.formatting.sqlfluff.with({
          command = "sqlfluff",
          args = {
            "format",
            "--disable-progress-bar",
            "-",
          },
          extra_args = { "--dialect", "postgres" },
        }),
        -- linters
        b.diagnostics.eslint,
        b.diagnostics.jsonlint,
        b.diagnostics.yamllint,
        b.diagnostics.write_good,
        b.diagnostics.markdownlint,
        b.diagnostics.shellcheck,

        -- code actions
        b.code_actions.cspell,
        b.code_actions.eslint,
        b.code_actions.gitsigns,
        b.code_actions.gitrebase,
        b.code_actions.gomodifytags,
        b.code_actions.impl,
        b.code_actions.proselint,
        b.code_actions.refactoring,
        b.code_actions.shellcheck,
        -- b.code_actions.ts_node_action,
        -- cspell.lua
        -- eslint.lua
        -- eslint_d.lua
        -- gitrebase.lua
        -- gitsigns.lua
        -- gomodifytags.lua
        -- impl.lua
        -- ltrs.lua
        -- proselint.lua
        -- refactoring.lua
        -- regal.lua
        -- shellcheck.lua
        -- statix.lua
        -- ts_node_action.lua
        -- xo.lua

        -- hover
        b.hover.dictionary,
        b.hover.printenv,
      },
      save_after_format = true,
      diagnostics_format = "[#{c}] #{m} (#{s})",
      notify_format = "[null-ls] %s",
      on_attach = function(client, bufnr)
        -- if client.supports_method("textDocument/formatting") then
        --   vim.api.nvim_clear_autocmds({
        --     group = augroup,
        --     buffer = bufnr
        --   })
        --   vim.api.nvim_create_autocmd("BufWritePre", {
        --     group = augroup,
        --     buffer = bufnr,
        --     callback = function()
        --       vim.lsp.buf.format({ bufnr = bufnr })
        --     end
        --   })
        -- end
      end,
    })
  end,
}
