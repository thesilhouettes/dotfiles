local fn = vim.fn
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
local packer_bootstrap
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
end

require("packer").startup(function(use)
  -- packer can manage itself
  use "wbthomason/packer.nvim"

  -- nice theme
  use {
    "catppuccin/nvim",
    as = "catppuccin",
  }

  use {
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
  }
  -- file tree
  use {
    "kyazdani42/nvim-tree.lua",
    requires = {
      "kyazdani42/nvim-web-devicons",
    },
  }

  -- automatically indent new line
  use "lukas-reineke/indent-blankline.nvim"

  -- snazzy buffer / tab top bar
  use "akinsho/bufferline.nvim"

  -- file searcher
  use {
    "nvim-telescope/telescope.nvim",
    requires = {
      {
        "nvim-lua/plenary.nvim",
      },
    },
  }

  -- treesitter (syntax highlighting ?)
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }

  -- lsp client config
  use "neovim/nvim-lspconfig"

  -- toggle comment
  use "terrortylor/nvim-comment"

  -- some vscode like snippets
  use "rafamadriz/friendly-snippets"

  -- snippet source
  use "L3MON4D3/LuaSnip"

  -- auto completion
  use "hrsh7th/nvim-cmp"

  -- lsp source for nvim-cmp
  use "hrsh7th/cmp-nvim-lsp"

  -- configs for cmp and luasnip
  use "saadparwaiz1/cmp_luasnip"

  -- show function signature when typing
  use "ray-x/lsp_signature.nvim"

  -- colour rgb strings
  use "norcalli/nvim-colorizer.lua"

  -- integrated terminal like vscode
  use {
    "akinsho/toggleterm.nvim",
    tag = "v1.*",
  }

  -- formatting (also with prettier)
  use "jose-elias-alvarez/null-ls.nvim"

  -- note files (not a lua plugin)
  use "vimwiki/vimwiki"

  -- typescript smart actions
  use "jose-elias-alvarez/nvim-lsp-ts-utils"

  -- git signs
  use {
    "lewis6991/gitsigns.nvim",
  }

  if packer_bootstrap then
    require("packer").sync()
  end
end)

-- configs for each plugin
require "plugins/lualine"
require "plugins/indent-blankline"
require "plugins/nvim-tree"
require "plugins/bufferline"
require "plugins/treesitter"
require "plugins/nvim-comment"
require "plugins/null-ls"
require "plugins/lspconfig"
require "plugins/nvim-cmp"
-- require("plugins/lsp-signature")
require "plugins/colorizer"
require "plugins/toggleterm"
require "plugins/telescope"
require "plugins/gitsigns"
