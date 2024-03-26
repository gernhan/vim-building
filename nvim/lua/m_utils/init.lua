local M = {}

function M.t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function M.exists(list, val)
  local set = {}
  for _, l in ipairs(list) do
    set[l] = true
  end
  return set[val]
end

function M.log(msg, hl, name)
  name = name or "Neovim"
  hl = hl or "Todo"
  vim.api.nvim_echo({ { name .. ": ", hl }, { msg } }, true, {})
end

function M.warn(msg, name)
  vim.notify(msg, vim.log.levels.WARN, { title = name })
end

function M.error(msg, name)
  vim.notify(msg, vim.log.levels.ERROR, { title = name })
end

function M.info(msg, name)
  vim.notify(msg, vim.log.levels.INFO, { title = name })
end

function M.is_empty(s)
  return s == nil or s == ""
end

function M.get_buf_option(opt)
  local status_ok, buf_option = pcall(vim.api.nvim_buf_get_option, 0, opt)
  if not status_ok then
    return nil
  else
    return buf_option
  end
end

function M.quit()
  local bufnr = vim.api.nvim_get_current_buf()
  local modified = vim.api.nvim_buf_get_option(bufnr, "modified")
  if modified then
    vim.ui.input({
      prompt = "You have unsaved changes. Quit anyway? (y/n) ",
    }, function(input)
      if input == "y" then
        vim.cmd("q!")
      end
    end)
  else
    vim.cmd("q!")
  end
end

function M.get_repo_name()
  if
      #vim.api.nvim_list_tabpages() > 1
      and vim.fn.trim(vim.fn.system("git rev-parse --is-inside-work-tree")) == "true"
  then
    return vim.fn.trim(vim.fn.system("basename `git rev-parse --show-toplevel`"))
  end
  return ""
end

function M.get_visual_selection()
  vim.cmd([[noau normal! "vy"]])
  local text = vim.fn.getreg("v")
  vim.fn.setreg("v", {})

  text = string.gsub(text, "\n", "")
  if #text > 0 then
    return text
  else
    return ""
  end
end

function M.goToDefOrRefs()
  local current_pos = vim.fn.getcurpos()
  vim.lsp.buf.definition()

  vim.defer_fn(function()
    -- Check if cursor position changed after the definition action
    local new_pos = vim.fn.getcurpos()
    if current_pos[2] == new_pos[2] and current_pos[3] == new_pos[3] then
      print("Already at declaration")
      M.goToReferences()
    end
  end, 100)
end

function M.save_this_buffer()
  -- Get the current buffer number
  local current_bufnr = vim.fn.bufnr("%")

  -- Save the current buffer
  vim.api.nvim_buf_call(current_bufnr, function()
    vim.cmd("w")
  end)
end

function M.callEsc(delay)
  delay = delay or 100
  -- Delayed execution to ensure ui has time to render
  vim.defer_fn(function()
    vim.cmd([[call feedkeys("\<Esc>", 'n')]])
  end, delay)
end

function M.goToReferences()
  require("telescope.builtin").lsp_references({
    include_declaration = false,
    trim_text = true,
  })
  M.callEsc()
end

function M.goToDefinition()
  require("telescope.builtin").lsp_definitions()
  M.callEsc()
end

function M.goToTypeDefinition()
  require("telescope.builtin").lsp_type_definitions()
  M.callEsc()
end

function M.diagnostics()
  require("telescope.builtin").diagnostics()
  M.callEsc()
end

function M.mergeTable(source, destination)
  -- Merge source into destination
  for k, v in pairs(source) do
    destination[k] = v
  end
end

function M.copy_absolute_path()
  local file_path = vim.fn.expand('%:p')
  vim.fn.setreg('+', file_path)
  return file_path
end

return M
