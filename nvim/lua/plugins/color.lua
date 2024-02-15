return {
  {
    -- event = "VeryLazy",
    lazy = false,
    priority = 2000,
    "rebelot/kanagawa.nvim",
    config = function()
      require("configs.colors.kanagawa")

      -- setup must be called before loading
      vim.cmd("colorscheme kanagawa-dragon")
    end
  },
  {
    "catppuccin/nvim",
    event = "VeryLazy",
    name = "catppuccin",
    config = function()
      -- vim.cmd.colorscheme "catppuccin-macchiato"
    end
  },
  {
    {
      "rktjmp/lush.nvim",
      event = "VeryLazy",
    },
    {
      "briones-gabriel/darcula-solid.nvim",
      event = "VeryLazy",
      requires = "rktjmp/lush.nvim",
      config = function()
        -- vim.cmd 'colorscheme darcula-solid'
        -- vim.cmd 'colorscheme darcula-solid-custom'
        -- vim.cmd 'set termguicolors'
      end
    }
  },
  {
    'doums/darcula',
    event = "VeryLazy",
    config = function()
      -- vim.cmd [[
      --   " colorscheme darcula
      --   " let g:lightline = { 'colorscheme': 'darculaOriginal' }
      --   " set termguicolors
      -- ]]
    end
  },
  {
    "folke/tokyonight.nvim",
    -- priority = 2000,
    event = "VeryLazy",
    config = function()
      -- vim.cmd("colorscheme tokyonight-night")
    end
  },
  {
    "bluz71/vim-nightfly-colors",
    event = "VeryLazy",
    config = function()
      -- vim.cmd("colorscheme tokyonight")
    end
  },
  {
    "NLKNguyen/papercolor-theme",
    event = "VeryLazy",
    config = function()
      -- vim.cmd("colorscheme tokyonight")
    end
  },
  {
    "baliestri/aura-theme",
    event = "VeryLazy",
    config = function()
      -- config = function(plugin)
      -- vim.opt.rtp:append(plugin.dir .. "/packages/neovim")
      -- vim.cmd([[colorscheme aura-dark]])
    end
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    event = "VeryLazy",
    -- priority = 1000,
    config = function()
      require("configs.colors.rose-pine")
      -- vim.cmd.colorscheme("rose-pine")
    end,
  }
}
