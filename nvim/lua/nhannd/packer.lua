local fn = vim.fn

-- Auto install if missing
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP =
      fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
  print("Installing packer close and reopen Neovim...")
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
augroup packer_user_config
autocmd!
autocmd BufWritePost plugins.lua source <afile> | PackerSync
augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "single" })
    end,
  },
})
-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
-- vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function(use)
  -- Packer can manage itself
  use("wbthomason/packer.nvim")
  use({
    "nvim-telescope/telescope.nvim",
    tag = "0.1.1",
    -- or                            , branch = '0.1.x',
    requires = { { "nvim-lua/plenary.nvim" } },
  })
  use({ "rose-pine/neovim", as = "rose-pine" })
  use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })
  use("nvim-treesitter/playground")
  use("ThePrimeagen/harpoon")
  use({
    "alexghergh/nvim-tmux-navigation",
    config = function()
      local nvim_tmux_nav = require("nvim-tmux-navigation")

      nvim_tmux_nav.setup({
        disable_when_zoomed = true, -- defaults to false
      })

      vim.keymap.set("n", "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
      vim.keymap.set("n", "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
      vim.keymap.set("n", "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
      vim.keymap.set("n", "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
      vim.keymap.set("n", "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive)
      vim.keymap.set("n", "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext)
    end,
  })
  use("mbbill/undotree")
  use("tpope/vim-fugitive")
  use({
    "williamboman/mason.nvim",
    run = ":MasonUpdate", -- :MasonUpdate updates registry contents
  })
  use({
    "williamboman/mason-lspconfig.nvim"
  })
  use({
    "neovim/nvim-lspconfig"
  })
  use({
    "mfussenegger/nvim-jdtls",
  })
  use({
    "VonHeikemen/lsp-zero.nvim",
    branch = "v2.x",
    requires = {
      -- LSP Support
      { "neovim/nvim-lspconfig" }, -- Required

      -- Autocompletion
      { "hrsh7th/nvim-cmp" },     -- Required
      { "hrsh7th/cmp-nvim-lsp" }, -- Required
      { "L3MON4D3/LuaSnip" },     -- Required
    },
  })
  use({
    "nvim-tree/nvim-tree.lua",
    requires = {
      "nvim-tree/nvim-web-devicons", -- optional
    },
    config = function()
      require("nvim-tree").setup({
        sort_by = "case_sensitive",
        view = {
          width = 30,
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = true,
        },
        on_attach = require("after.plugin.nvim-tree"),
      })
    end,
  })
  use({
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  })
  use({
    "phaazon/hop.nvim",
    branch = "v2", -- optional but strongly recommended
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
    end,
  })
  use({
    "nvim-tree/nvim-web-devicons",
  })
  use({
    "akinsho/bufferline.nvim",
    tag = "*",
    config = function()
      vim.opt.termguicolors = true
      require("bufferline").setup({})
    end,
    requires = "nvim-tree/nvim-web-devicons",
  })
  use({
    "nvim-lualine/lualine.nvim",
    config = function()
      require("after.plugin.lualine").setup()
    end,
  })
  use({
    "folke/noice.nvim",
    config = function()
      require("noice").setup()
    end,
    requires = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  })
  use({
    "SmiteshP/nvim-navic",
    requires = "neovim/nvim-lspconfig",
  })
  -- WhichKey
  use({
    "folke/which-key.nvim",
    config = function()
      require("after.plugin.whichkey").setup()
    end,
  })
  use({
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      local settings = require("after.plugin.null-ls-config")
      local null_ls = require("null-ls")
      null_ls.setup(settings)
    end,
    requires = { "nvim-lua/plenary.nvim" },
  })
  -- use {'akinsho/bufferline.nvim', tag = "*", requires = 'nvim-tree/nvim-web-devicons', config = function ()
  --   require("bufferline").setup{}
  -- end}
  use({
    "smjonas/inc-rename.nvim",
    config = function()
      require("inc_rename").setup({
        cmd_name = "IncRename",     -- the name of the command
        hl_group = "Substitute",    -- the highlight group used for highlighting the identifier's new name
        preview_empty_name = false, -- whether an empty new name should be previewed; if false the command preview will be cancelled instead
        show_message = true,        -- whether to display a `Renamed m instances in n files` message after a rename operation
        input_buffer_type = nil,    -- the type of the external input buffer to use (the only supported value is currently "dressing")
        post_hook = nil,            -- callback to run after renaming, receives the result table (from LSP handler) as an argument
      })
    end,
  })
  use("m4xshen/autoclose.nvim")
  use({
    "kylechui/nvim-surround",
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end,
  })
  use({
    "lewis6991/gitsigns.nvim",
    config = function()
      require("config.gitsigns-config").setup()
    end,
  })
  use("famiu/bufdelete.nvim")
  use({
    "iamcco/markdown-preview.nvim",
    run = function()
      vim.fn["mkdp#util#install"]()
    end,
    setup = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  })
end)
