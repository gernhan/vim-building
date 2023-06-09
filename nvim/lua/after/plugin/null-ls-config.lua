local null_ls = require("null-ls")

local defaults = {
  sources = {
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.diagnostics.eslint,
    null_ls.builtins.completion.spell,
  },
  border = nil,
  cmd = { "nvim" },
  debounce = 250,
  debug = true,
  default_timeout = 5000,
  diagnostic_config = {},
  diagnostics_format = "[#{c}] #{m} (#{s})",
  fallback_severity = vim.diagnostic.severity.ERROR,
  log_level = "warn",
  notify_format = "[null-ls] %s",
  on_attach = nil,
  on_init = nil,
  on_exit = nil,
  root_dir = require("null-ls.utils").root_pattern(".null-ls-root", "Makefile", ".git"),
  should_attach = nil,
  temp_dir = nil,
  update_in_insert = false,
}
return defaults
