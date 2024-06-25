-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
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

local plugins = {
	-- -- default plugins
	-- "folke/which-key.nvim",
	-- "folke/neodev.nvim",
	-- "nvim-lualine/lualine.nvim",
	
	-- theme
	"folke/tokyonight.nvim",

	-- basic plugins
	"nvim-lua/plenary.nvim", -- dependency of many plugins
	"nvim-tree/nvim-web-devicons", -- dependency of many plugins

	-- the best quick nav menu
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	'nvim-telescope/telescope.nvim',

	-- navigate through files seamlessly
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},

	-- create a playground to test something out???
	"nvim-treesitter/playground",

	-- quick access certain files
	{
	    "ThePrimeagen/harpoon",
	    branch = "harpoon2",
	    dependencies = { "nvim-lua/plenary.nvim" }
	},

	-- visual undo tree
	"mbbill/undotree",

	-- git integration
	"tpope/vim-fugitive",

	-- easily install manage lsp/dap servers, linters, and formatters
	-- NOTE: keep mason, mason-lspconfig, and nvim-lspconfig in this order
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",

	-- lsp-zero to enable linting
	{'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
	{'neovim/nvim-lspconfig'}, -- keep lspconfig here
	{'hrsh7th/cmp-nvim-lsp'},
	{'hrsh7th/nvim-cmp'},
	{'L3MON4D3/LuaSnip'},

	-- greeter when you use nvim with no args
	{
	    'goolord/alpha-nvim',
	    config = function ()
		require'alpha'.setup(require'alpha.themes.dashboard'.config)
	    end
	};
}

local opts = {}

-- init lazy.nvim
require("lazy").setup(plugins, opts)
