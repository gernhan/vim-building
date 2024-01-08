return {
  "tpope/vim-fugitive",
  config = function()
    vim.keymap.set("n", "<leader>ggit", vim.cmd.Git)
    vim.keymap.set("n", "<leader>gg", vim.cmd.Git)
    vim.keymap.set("n", "<leader>an", function()
      vim.cmd [[ Git blame ]]
    end)
  end
}
