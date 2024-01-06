vim.g.material_style = 'palenight'

require('material').setup({

        lualine_style = 'stealth',

	contrast = {
		sidebars = true,
		line_nubmers = true,
		floating_windows = true,
	},

	italics = {
		keywords = true,
		functions = true,
	},

	contrast_filetypes = {
		"terminal",
		"packer",
		"qf",
	},

	disable = {
		borders = true,
		eob_lines = true
	},

       	async_loading = true, -- Load parts of the theme asyncronously for faster startup (turned on by default)

        custom_highlights = { -- Overwrite highlights with your own
	    LineNr = { fg = '#C3E88D', bold=true },
	},

	plugins = { -- Here, you can disable(set to false) plugins that you don't use or don't want to apply the theme to
		trouble = false,
		nvim_cmp = true,
		neogit = false,
		gitsigns = true,
		git_gutter = false,
		telescope = true,
		nvim_tree = false,
		sidebar_nvim = false,
		lsp_saga = true,
		nvim_dap = false,
		nvim_navic = false,
		which_key = true,
		sneak = false,
		hop = false,
		indent_blankline = false,
		nvim_illuminate = false,
		mini = false,
	},
})

-- Enable style toggling
map('n', '<leader>ms', ':lua require("material.functions").toggle_style()<CR>',DEFAULT_OPTIONS)

-- Enable the colorscheme
--vim.cmd 'colorscheme material'
