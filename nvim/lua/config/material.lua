vim.g.material_style = 'palenight'

require('material').setup({
        lualine_style = 'stealth',
	contrast = {
		sidebars = true,
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

	custom_highlights = {}, -- Overwrite highlights with your own

	plugins = { -- Here, you can disable(set to false) plugins that you don't use or don't want to apply the theme to
		trouble = true,
		nvim_cmp = true,
		neogit = true,
		gitsigns = true,
		git_gutter = true,
		telescope = true,
		nvim_tree = true,
		sidebar_nvim = true,
		lsp_saga = true,
		nvim_dap = true,
		nvim_navic = true,
		which_key = true,
		sneak = true,
		hop = true,
		indent_blankline = true,
		nvim_illuminate = true,
		mini = true,
	},
})

-- Enable style toggling
map('n', '<leader>ms', ':lua require("material.functions").toggle_style()<CR>',DEFAULT_OPTIONS)

-- Enable the colorscheme
vim.cmd [[colorscheme material]]
