return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "leoluz/nvim-dap-go",
    },
    config = function()
      require("configs.dap").setup()
    end
  },
  {
    "rcarriga/nvim-dap-ui",
    requires = { "mfussenegger/nvim-dap" },
  },
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = "mfussenegger/nvim-dap",
    config = function(_, opts)
      require("dap-go").setup(opts)
      vim.keymap.set("n", "<leader>dgt",
        function()
          require("dap-go").debug_test()
        end,
        { desc = "Debug go test" }
      )
      vim.keymap.set("n", "<leader>dgl",
        function()
          require("dap-go").debug_last()
        end,
        { desc = "Debug last go test" }
      )
    end
  }
}
