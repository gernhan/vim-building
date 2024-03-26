return {
  "rmagatti/auto-session",
  dependencies = {
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    require("configs.auto-session").setup()
  end
}
