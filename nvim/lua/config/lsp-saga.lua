local lspsaga = require 'lspsaga'

lspsaga.setup { -- defaults ...
	debug = false,
	use_saga_diagnostic_sign = true,
	-- diagnostic sign
	error_sign = "",
	warn_sign = "",
	hint_sign = "",
	infor_sign = "",
	diagnostic_header_icon = "   ",
	-- code action title icon
	code_action_icon = " ",
	code_action_prompt = {
		enable = true,
		sign = true,
		sign_priority = 40,
		virtual_text = true,
	},
	finder_definition_icon = "  ",
	finder_reference_icon = "  ",
	max_preview_lines = 10,
	finder_action_keys = {
		open = "o",
		vsplit = "s",
		split = "i",
		quit = "q",
		scroll_down = "<C-f>",
		scroll_up = "<C-b>",
	},
	code_action_keys = {
		quit = "q",
		exec = "<CR>",
	},
	rename_action_keys = {
		quit = "<C-c>",
		exec = "<CR>",
	},
	definition_preview_icon = "  ",
	border_style = "single",
	rename_prompt_prefix = "➤",
	server_filetype_map = {},
	diagnostic_prefix_format = "%d. ",
}

map("n", "<leader>sh", "<cmd> Lspsaga lsp_finder<CR>", DEFAULT_OPTIONS) -- search all symbols
map({"n","v"}, "<leader>sc", "<cmd> Lspsaga code_action<CR>", DEFAULT_OPTIONS) -- perform code action
map("n", "<leader>sr", "<cmd> Lspsaga rename<CR>", DEFAULT_OPTIONS) -- rename
--map("n", "<leader>sd", "<cmd> Lspsaga peek_definition<CR>", DEFAULT_OPTIONS) -- definition needs floatterm


-- Show line diagnostics
map("n", "<leader>sld", "<cmd>Lspsaga show_line_diagnostics<CR>", DEFAULT_OPTIONS)

-- Show cursor diagnostic
map("n", "<leader>scd", "<cmd>Lspsaga show_cursor_diagnostics<CR>", DEFAULT_OPTIONS)

-- Diagnsotic jump can use `<c-o>` to jump back
map("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", DEFAULT_OPTIONS)
map("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", DEFAULT_OPTIONS)

-- Only jump to error
map("n", "[E", function()
  require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, DEFAULT_OPTIONS)
map("n", "]E", function()
  require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
end, DEFAULT_OPTIONS)

-- Outline
map("n","<leader>so", "<cmd>LSoutlineToggle<CR>",DEFAULT_OPTIONS)

-- Hover Doc
map("n", "<leader>sk", "<cmd>Lspsaga hover_doc<CR>", DEFAULT_OPTIONS)
