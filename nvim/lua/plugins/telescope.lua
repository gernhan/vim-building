-- plugins/telescope.lua:
return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    -- or                              , branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require("configs.telescope").setup()
    end
  },
  {
    'nvim-telescope/telescope-ui-select.nvim',
    config = function()
      require("configs.telescope.ui-select").setup()
    end
  },
  {
    'nvim-telescope/telescope-dap.nvim',
    requires = { "mfussenegger/nvim-dap" },
    config = function()
      require("configs.telescope.dap").setup()
    end
  }
}


-- Usages:
--
-- :Telescope dap commands
-- :Telescope dap configurations
-- :Telescope dap list_breakpoints
-- :Telescope dap variables
-- :Telescope dap frames
--
-- require'telescope'.extensions.dap.commands{}
-- require'telescope'.extensions.dap.configurations{}
-- require'telescope'.extensions.dap.list_breakpoints{}
-- require'telescope'.extensions.dap.variables{}
-- require'telescope'.extensions.dap.frames{}
