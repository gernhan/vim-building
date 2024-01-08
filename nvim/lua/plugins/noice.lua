return {
  "folke/noice.nvim",
  config = function()
    require("noice").setup()
  end,
  requires = {
    "MunifTanjim/nui.nvim",
    -- "rcarriga/nvim-notify",
  },
}
