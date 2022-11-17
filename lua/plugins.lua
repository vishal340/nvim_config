return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use "williamboman/mason.nvim"
  use "williamboman/mason-lspconfig.nvim"
  use "onsails/lspkind.nvim"
  use "jose-elias-alvarez/null-ls.nvim"
  use "mfussenegger/nvim-lint"
  use "nvim-lua/plenary.nvim"
	use "kyazdani42/nvim-web-devicons"
  use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP
  use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'hrsh7th/nvim-cmp'

	use({
    "glepnir/lspsaga.nvim",
    branch = "main",
    config = function()
        local saga = require("lspsaga")

        saga.init_lsp_saga({
            saga_winblend = 60,
				max_preview_lines = 20,
        })
    end,
	})

	use 'mfussenegger/nvim-dap'

	use {
  		'nvim-lualine/lualine.nvim',
  		requires = { 'kyazdani42/nvim-web-devicons', opt = true }
	}

  use {'L3MON4D3/LuaSnip', run = "make install_jsregexp"}
  use 'saadparwaiz1/cmp_luasnip'
  use "rafamadriz/friendly-snippets"
  use { 'michaelb/sniprun', run = 'bash ./install.sh'}

   use {
        'nvim-treesitter/nvim-treesitter',
        run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
    }
	use 'nvim-treesitter/nvim-treesitter-textobjects'

	use {
  		'nvim-telescope/telescope.nvim', branch = '0.1.x',
		requires = { {'nvim-lua/plenary.nvim'} }
	}

	use {
	  'kyazdani42/nvim-tree.lua',
	  requires = {
		 'kyazdani42/nvim-web-devicons', -- optional, for file icons
	  },
	  tag = 'nightly' -- optional, updated every week. (see issue #1193)
	}

	use {
		"windwp/nvim-autopairs",
    	config = function() require("nvim-autopairs").setup {} end
	}
	use "tpope/vim-repeat"
	
	use {
  		"ur4ltz/surround.nvim",
		config = function()
    		require"surround".setup {mappings_style = "surround"}
  		end
	}
	
	use {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
	}

	use {
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    ft = "markdown",
  }
	use "mfussenegger/nvim-jdtls"
	
	use 'mhinz/vim-startify'
	
	use {
  		'lewis6991/gitsigns.nvim',
	  	config = function()
   		require('gitsigns').setup()
  	end
	}
	use "tpope/vim-fugitive"
  use "ruifm/gitlinker.nvim"
  use "mattn/vim-gist"
  use "pwntester/octo.nvim"
  use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
  use({"petertriho/cmp-git", requires = "nvim-lua/plenary.nvim"})

  use {
	  "folke/todo-comments.nvim",
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
	use({
	  "lalitmee/browse.nvim",
	})
	
	use {'nvim-orgmode/orgmode', config = function()
        require('orgmode').setup{}
	end
	}
	use "ziontee113/neo-minimap"
end)
