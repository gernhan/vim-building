return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    local b = null_ls.builtins
    null_ls.setup({
      sources = {
        -- formaters
        b.formatting.stylua,
        b.formatting.shfmt,
        b.formatting.yamlfmt,
        b.formatting.prettier,
        b.formatting.mdformat,
        b.formatting.fixjson,
        b.formatting.black,
        b.formatting.isort,
        b.formatting.jq,
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
        b.diagnostics.write_good,
        b.diagnostics.markdownlint,

        -- code actions
        b.code_actions.gitsigns,
        b.code_actions.gitrebase,

        -- hover
        b.hover.dictionary,
      },
      save_after_format = true,
      diagnostics_format = "[#{c}] #{m} (#{s})",
      notify_format = "[null-ls] %s",
    })
  end
}
