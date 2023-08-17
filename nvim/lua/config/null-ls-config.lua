local M = {}

local nls = require "null-ls"
local b = nls.builtins

local with_diagnostics_code = function(builtin)
  return builtin.with {
    diagnostics_format = "#{m} [#{c}]",
  }
end

local with_root_file = function(builtin, file)
  return builtin.with {
    condition = function(utils)
      return utils.root_has_file(file)
    end,
  }
end

local xml_lang_server_url = vim.fn.stdpath "config" .. "/lang-servers/google_checks.xml"

local sources = {
  nls.builtins.diagnostics.checkstyle.with({
    extra_args = { "-c", xml_lang_server_url }, -- or "/sun_checks.xml" or path to self written rules
  }),
  -- formatting
  b.formatting.prettierd,
  b.formatting.shfmt,
  b.formatting.fixjson,
  b.formatting.black.with { extra_args = { "--fast" } },
  b.formatting.isort,
  with_root_file(b.formatting.stylua, "stylua.toml"),

  -- diagnostics
  b.diagnostics.write_good,
  b.diagnostics.markdownlint,
  b.diagnostics.eslint_d,
  b.diagnostics.flake8,
  b.diagnostics.tsc,
  with_root_file(b.diagnostics.selene, "selene.toml"),
  with_diagnostics_code(b.diagnostics.shellcheck),

  -- code actions
  b.code_actions.gitsigns,
  b.code_actions.gitrebase,

  -- hover
  b.hover.dictionary,
}

function M.setup(opts)
  nls.setup {
    -- debug = true,
    save_after_format = true,
    sources = sources,
    on_attach = opts.on_attach,
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
    on_init = nil,
    on_exit = nil,
    root_dir = require("null-ls.utils").root_pattern(".null-ls-root", "Makefile", ".git"),
    should_attach = nil,
    temp_dir = nil,
    update_in_insert = false,
  }
end

return M
