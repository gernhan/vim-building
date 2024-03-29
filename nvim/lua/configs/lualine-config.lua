local M = {}

local icons = require("configs.icons")

-- Color table for highlights
local colors = {
  bg = "#202328",
  fg = "#bbc2cf",
  yellow = "#ECBE7B",
  cyan = "#008080",
  darkblue = "#081633",
  green = "#98be65",
  orange = "#FF8800",
  violet = "#a9a1e1",
  magenta = "#c678dd",
  blue = "#51afef",
  red = "#ec5f67",
}

local function separator()
  return "%="
end

local function tab_stop()
  return icons.ui.Tab .. " " .. vim.bo.shiftwidth
end

-- local function loclist_open()
--   local wininfo = vim.fn.getwininfo(vim.api.nvim_get_current_win())
--   return wininfo[1].loclist == 1
-- end

local function show_macro_recording()
  local rec_reg = vim.fn.reg_recording()
  if rec_reg == "" then
    return ""
  else
    return "recording @" .. rec_reg
  end
end

local function lsp_client(msg)
  msg = msg or ""
  local buf_clients = vim.lsp.get_active_clients({ bufnr = 0 })

  if next(buf_clients) == nil then
    if type(msg) == "boolean" or #msg == 0 then
      return ""
    end
    return msg
  end

  local buf_ft = vim.bo.filetype
  local buf_client_names = {}

  -- add client other than 'null-ls'
  for _, client in pairs(buf_clients) do
    if client.name ~= "null-ls" then
      table.insert(buf_client_names, client.name)
    end
  end

  local null_ls_utils = require("m_utils.null-ls")
  -- add formatter
  local supported_formatters = null_ls_utils.list_registered(buf_ft, require("null-ls").methods.FORMATTING)
  vim.list_extend(buf_client_names, supported_formatters)
  -- add linter
  local supported_linters = null_ls_utils.list_registered(buf_ft, require("null-ls").methods.DIAGNOSTICS)
  vim.list_extend(buf_client_names, supported_linters)
  -- add hover
  local supported_hovers = null_ls_utils.list_registered(buf_ft, require("null-ls").methods.HOVER)
  vim.list_extend(buf_client_names, supported_hovers)
  -- add code action
  local supported_code_actions = null_ls_utils.list_registered(buf_ft, require("null-ls").methods.CODE_ACTION)
  vim.list_extend(buf_client_names, supported_code_actions)

  local hash = {}
  local client_names = {}
  for _, v in ipairs(buf_client_names) do
    if not hash[v] then
      client_names[#client_names + 1] = v
      hash[v] = true
    end
  end
  table.sort(client_names)
  return "[" .. table.concat(client_names, ", ") .. "]"
end

local configs = {
  options = {
    icons_enabled = true,
    -- theme = require("config.lualine-theme"),
    theme = "auto",
    -- component_separators = { left = '', right = ''},
    -- section_separators = { left = '', right = ''},
    -- section_separators = { left = '', right = '' },
    section_separators = { left = "", right = "" },
    -- component_separators = { left = "", right = "" },
    component_separators = { left = " ", right = "" },
    disabled_filetypes = {
      statusline = {},
      winbar = {
        "help",
        "startify",
        "dashboard",
        "packer",
        "neogitstatus",
        "NvimTree",
        "Trouble",
        "alpha",
        "lir",
        "Outline",
        "spectre_panel",
        "toggleterm",
        "dap-repl",
        "dapui_console",
        "dapui_watches",
        "dapui_stacks",
        "dapui_breakpoints",
        "dapui_scopes",
      },
    },
    always_divide_middle = true,
    globalstatus = true,
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = {
      { separator },
      {
        require("noice").api.status.message.get_hl,
        cond = require("noice").api.status.message.has,
        color = { fg = "#ff9e64", bg = "none" },
      },
      {
        require("noice").api.status.command.get,
        cond = require("noice").api.status.command.has,
        color = { fg = "#ff9e64", bg = "none" },
      },
      {
        require("noice").api.status.mode.get,
        cond = require("noice").api.status.mode.has,
        color = { fg = "#ff9e64", bg = "none" },
      },
      {
        require("noice").api.status.search.get,
        cond = require("noice").api.status.search.has,
        color = { fg = "#ff9e64", bg = "none" },
      },
      {
        "macro-recording",
        fmt = show_macro_recording,
      },
    },
    lualine_x = {
      -- { separator },
      {
        -- lsp_client,
        function(msg)
          return lsp_client(msg) or "No Lsp Client"
        end,
        icon = icons.ui.Gear,
        color = { fg = colors.violet, gui = "bold" },
        on_click = function()
          vim.cmd([[LspInfo]])
        end,
      },
      { tab_stop }, "encoding", "fileformat", "filetype", "progress" },
    lualine_y = {},
    lualine_z = { "location" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
}

function M.setup()
  require("lualine").setup(configs)
end

return M
