-- test
require("packer").startup(function (use)
  -- packer can manage itself
  use "wbthomason/packer.nvim"

  -- nice theme
  use {
    "catppuccin/nvim", as = "catppuccin"
  }

  -- status bar
  use "feline-nvim/feline.nvim"

  -- file tree
  use {
    "kyazdani42/nvim-tree.lua",
    requires = {
      "kyazdani42/nvim-web-devicons",
    }
  }

  -- automatically indent new line
  use "lukas-reineke/indent-blankline.nvim"

  -- snazzy buffer / tab top bar
  use "akinsho/bufferline.nvim"

  -- file searcher
  use {
    "nvim-telescope/telescope.nvim",
    requires = {
      { "nvim-lua/plenary.nvim" }
    },
}

  -- treesitter (syntax highlighting ?)
   use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate"
  }

  -- lsp client config
  use "neovim/nvim-lspconfig"

  -- toggle comment
  use "terrortylor/nvim-comment"

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
  use {"akinsho/toggleterm.nvim", tag = 'v1.*' }

  -- formatting (also with prettier)
  use "jose-elias-alvarez/null-ls.nvim"
  use "MunifTanjim/prettier.nvim"
end)

-- configs for each plugin
require("plugins/feline")
require("plugins/indent-blankline")
require("plugins/nvim-tree")
require("plugins/bufferline")
require("plugins/treesitter")
require("plugins/lspconfig")
require("plugins/nvim-comment")
require("plugins/nvim-cmp")
-- require("plugins/lsp-signature")
require("plugins/colorizer")
require("plugins/toggleterm")
require("plugins/telescope")
require("plugins/prettier")
