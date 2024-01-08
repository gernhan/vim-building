return {
  "nvim-lualine/lualine.nvim",
  config = function()
    require("configs.lualine-config").setup()
  end,
}
