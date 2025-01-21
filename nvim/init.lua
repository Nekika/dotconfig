local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = { flavour = "macchiato" },
    init = function()
      vim.cmd.colorscheme "catppuccin"
    end,
  },
  -- {
  --   name = "tulipe",
  --   dir = "~/Projects/tulipe/tulipe.nvim",
  --   dev = true,
  --   lazy = false,
  --   opts = {},
  -- },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
      { "ms-jpq/coq_nvim",      branch = "coq" },
      { "ms-jpq/coq.artifacts", branch = "artifacts" }
    },
    init = function()
      vim.g.coq_settings = {
        auto_start = "shut-up"
      }
    end
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
    opts = {
      options = {
        theme = "auto"
      }
    }
  },
  {
    "nvim-treesitter/nvim-treesitter",
    main = "nvim-treesitter.configs",
    opts = {
      sync_install = true,
      auto_install = true,
      highlight = {
        enable = true
      }
    }
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
    opts = {}
  },
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {},
  },
  {
    "tpope/vim-fugitive",
  }
})

require("nekika")
