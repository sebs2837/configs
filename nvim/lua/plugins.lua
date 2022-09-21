local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

--[[ returns the require for use in `config` parameter of packer's use
 expects the name of the config file --]]
local function get_config(name)
	return string.format("require(\"config/%s\")", name)
end

-- bootstrap packer if not installed
if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({
		"git", "clone", "https://github.com/wbthomason/packer.nvim",
		install_path
	})
	execute "packadd packer.nvim"
end

-- initialize and configure packer
local packer = require("packer")
local util = require("packer.util")
local use = packer.use

packer.init {
	enable = true, -- enable profiling via :PackerCompile profile=true
	threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
	display = {
		open_fn = util.float,
	}
}
packer.reset()

-- actual plugins list
use "wbthomason/packer.nvim"
use { 'aklt/plantuml-syntax' } -- Plant uml syntax

-- Themes
use { 'marko-cerovac/material.nvim', config = get_config("material") }

-- Buffer and Status bar
use {
	"nvim-lualine/lualine.nvim",
	config = get_config("lualine"),
	event = "VimEnter",
	requires = { "kyazdani42/nvim-web-devicons", opt = true }
}

use {
	"akinsho/nvim-bufferline.lua",
	requires = "kyazdani42/nvim-web-devicons",
	event = "BufReadPre",
	config = get_config("bufferline")
}

-- Utils
use { "tpope/vim-fugitive" }
use { "folke/which-key.nvim", config = get_config("whichkey") }


-- Fuzzy finders
use {
	"nvim-telescope/telescope.nvim",
	requires = {
	  { "nvim-lua/popup.nvim" },
	  { "nvim-lua/plenary.nvim" },
          {"nvim-telescope/telescope-file-browser.nvim"},
	  { "nvim-telescope/telescope-ui-select.nvim" }
	},
	config = get_config("telescope")
}


-- LSP 

use { 'onsails/lspkind.nvim', config = get_config('lsp-icons') }
use "arkav/lualine-lsp-progress"
use { 'tami5/lspsaga.nvim', config = get_config('lsp-saga') }

use { "neovim/nvim-lspconfig",
	requires = {
	 { "folke/lsp-colors.nvim" },
         { "simrat39/rust-tools.nvim" },
	 { "hrsh7th/cmp-nvim-lsp" },
         { "hrsh7th/cmp-buffer" },
         { "hrsh7th/cmp-path" },
	 { "hrsh7th/cmp-cmdline" },
         { "hrsh7th/cmp-vsnip" },
         { "hrsh7th/nvim-cmp" },
	 { "f3fora/cmp-spell" },
         { "hrsh7th/cmp-calc" },
         { "hrsh7th/cmp-emoji" },
	 { "hrsh7th/vim-vsnip" }
        },
	config = get_config("lsp")
}

use {
	'lewis6991/gitsigns.nvim',
	requires = 'nvim-lua/plenary.nvim',
	config = get_config('gitsigns')
}
use "p00f/nvim-ts-rainbow"

use {
	"nvim-treesitter/nvim-treesitter",
	config = get_config("treesitter"),
	run = ":TSUpdate"
}
use "nvim-treesitter/nvim-treesitter-textobjects"

use { "folke/zen-mode.nvim", event = "BufRead", cmd = "ZenMode", config = get_config("zen-mode") }

use {
	"lewis6991/spellsitter.nvim",
	config = get_config("spellsitter")
}

use 'rust-lang/rust.vim'

