vim.keymap.set("n", "<leader>ggit", vim.cmd.Git)
vim.keymap.set("n", "<leader>a", function ()
  vim.cmd [[ Git blame ]]
end)
