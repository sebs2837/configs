-- Set the theme style
vim.g.material_style = 'darker'

require('material').setup({
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
	}
})

-- Enable style toggling
vim.api.nvim_set_keymap('n', '<leader>ms', ':lua require("material.functions").toggle_style()<CR>', { noremap = true, silent = true })

-- Enable the colorscheme
vim.cmd 'colorscheme material'

