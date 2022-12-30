-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
local function get_config(name)
	return string.format("require(\"sebs/config/%s\")", name)
end

vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)
  -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use { 'EdenEast/nightfox.nvim', config = get_config('nightfox') }

    use {
        "nvim-lualine/lualine.nvim",
        event = "VimEnter",
        config = get_config('lualine'),
        requires = { "kyazdani42/nvim-web-devicons", opt = true }
    }
    -- Buffer and Status bar

    use {
        "akinsho/nvim-bufferline.lua",
        requires = "kyazdani42/nvim-web-devicons",
        config = get_config('bufferline'),
        event = "BufReadPre",
    }

    -- Utils
    use { "tpope/vim-fugitive" }
    use { "folke/which-key.nvim", config = get_config('whichkey') }

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

    use { 'onsails/lspkind.nvim', config = get_config('lsp-icons')}
    use "arkav/lualine-lsp-progress"
    use { 'tami5/lspsaga.nvim', config = get_config('lsp-saga') }
--'VonHeikemen/lsp-zero.nvim',
    use { "VonHeikemen/lsp-zero.nvim",
        requires = {
            {"neovim/nvim-lspconfig"},
            { "williamboman/mason.nvim", config = get_config('mason')},
            {'williamboman/mason-lspconfig.nvim'},
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
            { "hrsh7th/vim-vsnip" },
            {'L3MON4D3/LuaSnip'},
            {'rafamadriz/friendly-snippets'}
        },
        config = get_config('lsp')
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
    use {"nvim-treesitter/nvim-treesitter-textobjects", after = 'nvim-treesitter'}

    use { "folke/zen-mode.nvim", event = "BufRead", cmd = "ZenMode", config = get_config("zen-mode") }

    use {
        "lewis6991/spellsitter.nvim",
        config = get_config("spellsitter")
    }
    use('mbbill/undotree')

end)
