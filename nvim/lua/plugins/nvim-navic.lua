return {
  {
    "SmiteshP/nvim-navic",
    config = function()
      require("configs.nvim-navic").setup()
    end
  },
  {
    "SmiteshP/nvim-navbuddy",
    config = function()
      require("configs.nvim-navic-buddy").setup()
    end
  }
}
