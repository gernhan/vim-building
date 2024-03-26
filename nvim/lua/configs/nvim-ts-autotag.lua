local M = {}

local filetypes = {
  'html', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'svelte', 'vue', 'tsx', 'jsx', 'rescript',
  'xml', 'jrxml',
  'php',
  'markdown',
  'astro', 'glimmer', 'handlebars', 'hbs'
}

local skip_tags = {
  'area', 'base', 'br', 'col', 'command', 'embed', 'hr', 'img', 'slot',
  'input', 'keygen', 'link', 'meta', 'param', 'source', 'track', 'wbr', 'menuitem'
}

function M.setup()
  require('nvim-ts-autotag').setup(
    {
      autotag = {
        filetypes = filetypes,
        skip_tags = skip_tags,
        enable = true,
        enable_rename = true,
        enable_close = true,
        enable_close_on_slash = true,
      }
    })

  vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
      underline = true,
      virtual_text = {
        spacing = 5,
        severity_limit = 'Warning',
      },
      update_in_insert = true,
    }
  )
end

return M
