return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use "williamboman/mason.nvim"
  use "williamboman/mason-lspconfig.nvim"
  use "onsails/lspkind.nvim"
  use "jose-elias-alvarez/null-ls.nvim"
  use "nvim-lua/plenary.nvim"
	use "kyazdani42/nvim-web-devicons"
  use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP
  use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'hrsh7th/nvim-cmp'

  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
  use "rafamadriz/friendly-snippets"

   use "nvim-treesitter/nvim-treesitter"
	use 'nvim-treesitter/nvim-treesitter-textobjects'

	use {
  		'nvim-telescope/telescope.nvim', branch = '0.1.x',
	}
	
	use {
  	"nvim-neo-tree/neo-tree.nvim",
    	branch = "v2.x",
    	requires = { 
      		"nvim-lua/plenary.nvim",
      		"kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
      		"MunifTanjim/nui.nvim",
    	}
  	}

	use {
		"windwp/nvim-autopairs",
    	config = function() require("nvim-autopairs").setup {} end
	}
	use "tpope/vim-surround"
	use 'tpope/vim-commentary' -- For Commenting gcc & gc
	
	use {
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    ft = "markdown",
  }
	use "mfussenegger/nvim-jdtls"
	
	use 'mhinz/vim-startify'
	use "lewis6991/gitsigns.nvim"
  use "f-person/git-blame.nvim"
  use "ruifm/gitlinker.nvim"
  use "mattn/vim-gist"
  use "pwntester/octo.nvim"

  use {
	  "B4mbus/todo-comments.nvim",
	  requires = "nvim-lua/plenary.nvim",
	  config = function()
		 require("todo-comments").setup {
    }
	  end
  }
  use {
	  'phaazon/hop.nvim',
	  branch = 'v2', -- optional but strongly recommended
	  config = function()
		 -- you can configure Hop the way you like here; see :h hop-config
		 require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
	  end
	}

  use "folke/which-key.nvim"

end)
