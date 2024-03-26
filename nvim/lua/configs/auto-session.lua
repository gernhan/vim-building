local M = {}

M.opts = {
  log_level = vim.log.levels.ERROR,
  auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
  auto_session_use_git_branch = false,

  auto_session_enable_last_session = false,

  -- ⚠️ This will only work if Telescope.nvim is installed
  -- The following are already the default values, no need to provide them if these are already the settings you want.
  session_lens = {
    -- If load_on_setup is set to false, one needs to eventually call `require("auto-session").setup_session_lens()` if they want to use session-lens.
    buftypes_to_ignore = {}, -- list of buffer types what should not be deleted from current session
    load_on_setup = true,
    theme_conf = { border = true },
    previewer = false,
  },
  pre_save_cmds = {
    function()
      vim.fn.execute('NvimTreeClose')
    end,
  },
}
function M.setup()
  require("auto-session").setup(M.opts)

  -- Set mapping for searching a session.
  -- ⚠️ This will only work if Telescope.nvim is installed
  vim.keymap.set("n", "<leader>xs", require("auto-session.session-lens").search_session, {
    noremap = true,
  })
  vim.keymap.set("n", "<leader>xd", "<cmd>Autosession delete<CR>", {
    noremap = true,
  })
  vim.keymap.set("n", "<leader>xS", "<cmd>SessionSave<CR>", {
    noremap = true,
  })
end

return M
