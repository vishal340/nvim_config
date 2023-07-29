return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use "williamboman/mason.nvim"
  use "williamboman/mason-lspconfig.nvim"
  use "onsails/lspkind.nvim"
  use "mfussenegger/nvim-lint"
  use "nvim-lua/plenary.nvim"
	use "kyazdani42/nvim-web-devicons"
  use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP
  use({
	  "https://git.sr.ht/~whynothugo/lsp_lines.nvim",  -- better error messages
	  config = function()
		  require("lsp_lines").setup()
	  end,
  })
  use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'hrsh7th/nvim-cmp'

	use 'mfussenegger/nvim-dap'
	use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }
	use 'folke/neodev.nvim'

	use {
  		'nvim-lualine/lualine.nvim',
  		requires = { 'kyazdani42/nvim-web-devicons', opt = true }
	}

  use {'L3MON4D3/LuaSnip', run = "make install_jsregexp"}
  use 'saadparwaiz1/cmp_luasnip'
  use "rafamadriz/friendly-snippets"
  use { 'michaelb/sniprun', run = 'bash ./install.sh 1'}

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
    		require"surround".setup {
				mappings_style = "surround",
		}
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
	use {
    'ruifm/gitlinker.nvim',
    requires = 'nvim-lua/plenary.nvim',
	}
	use {
  'pwntester/octo.nvim',
  requires = {
	  'nvim-lua/plenary.nvim',
     'nvim-telescope/telescope.nvim',
     'nvim-tree/nvim-web-devicons',
   },
  	config = function ()
   	require"octo".setup()
  	end
	}
	use {
  	"rawnly/gist.nvim",
  	config = function() require("gist").setup() end,
  	-- `GistsList` opens the selected gif in a terminal buffer,
  	-- this plugin uses neovim remote rpc functionality to open the gist in an actual buffer and not have buffer inception
  	requires = { "samjwill/nvim-unception", setup = function() vim.g.unception_block_while_host_edits = true end }
	}
  use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
  use({"petertriho/cmp-git", requires = "nvim-lua/plenary.nvim"})

	use {
		"Fildo7525/pretty_hover",
		config = function()
		require("pretty_hover").setup(options)
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
	  requires = { "nvim-telescope/telescope.nvim" },
	})
	use {'nvim-orgmode/orgmode', config = function()
        require('orgmode').setup{}
	end
	}
	use {
  "folke/which-key.nvim",
  config = function()
    require("which-key").setup {}
  end
	}

	use {
    "smoka7/multicursors.nvim",
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'smoka7/hydra.nvim',
    },
    opts = function()
        local N = require 'multicursors.normal_mode'
        local I = require 'multicursors.insert_mode'
        return {
            normal_keys = {
                -- to change default lhs of key mapping change the key
                [','] = {
                    -- assigning nil to method exits from multi cursor mode
                    method = N.clear_others,
                    -- you can pass :map-arguments here
                    opts = { desc = 'Clear others' },
                },
            },
            insert_keys = {
                -- to change default lhs of key mapping change the key
                ['<CR>'] = {
                    -- assigning nil to method exits from multi cursor mode
                    method = I.CR_method(),
                    -- you can pass :map-arguments here
                    opts = { desc = 'New line' },
                },
            },
        }
    end,
	}

	use 'nvim-pack/nvim-spectre'
	use 'nosduco/remote-sshfs.nvim'
	use "Pocco81/HighStr.nvim"
	use "tpope/vim-dadbod"
end)
