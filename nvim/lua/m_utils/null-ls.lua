local M = {}

local nls_sources = require "null-ls.sources"

function M.list_registered_providers_names(filetype)
  local available_sources = nls_sources.get_available(filetype)
  local registered = {}
  for _, source in ipairs(available_sources) do
    for method in pairs(source.methods) do
      registered[method] = registered[method] or {}
      table.insert(registered[method], source.name)
    end
  end
  return registered
end

function M.has_formatter(filetype, method)
  local available = nls_sources.get_available(filetype, method)
  return #available > 0
end

function M.list_registered(filetype, method)
  local registered_providers = M.list_registered_providers_names(filetype)
  return registered_providers[method] or {}
end

return M
