DEFAULT_OPTIONS = { noremap = true, silent = true }
EXPR_OPTIONS = { noremap = true, expr = true, silent = true }
SILENT_OPTION = { silent = true }

---@version 5.1
---
--- key mapping function just thin wrapper ofer neovims default api
---
---@param mode string 
---@param key string
---@param cmd string|function
---@param opts table
function _G.map(mode, key, cmd, opts)
	mode = mode or 'n'
	opts = opts or DEFAULT_OPTIONS

	vim.keymap.set(mode, key, cmd, opts)
end

function _G.ReloadConfig()
	for name, _ in pairs(package.loaded) do
		if name:match('^cnull') then
			package.loaded[name] = nil
		end
	end

	dofile(vim.env.MYVIMRC)
end

--map("n", "<Space>", "<NOP>", DEFAULT_OPTIONS)
vim.g.mapleader = " "

map("n", "<leader>bf", vim.cmd.Ex, DEFAULT_OPTIONS)
map("v", "<", "<gv", DEFAULT_OPTIONS) -- select line again after indent
map("v", ">", ">gv", DEFAULT_OPTIONS) -- select line again after indent

map("n", "n", "nzzzv", DEFAULT_OPTIONS) -- keep search forward results centered
map("n", "N", "Nzzzv", DEFAULT_OPTIONS) -- keep search backward results centered
map("n", "J", "mzJ`z", DEFAULT_OPTIONS) -- TODO find out what it means

map("i", "jk", "<Esc>", DEFAULT_OPTIONS) -- using jk instead of esc
map("v", "jk", "<Esc>", DEFAULT_OPTIONS) -- using jk instead of esc

map("n", "<Right>", ":bnext<CR>", DEFAULT_OPTIONS) -- move to next buffer using arrow keys
map("n", "<Left>", ":bprevious<CR>", DEFAULT_OPTIONS) -- move to previous buffer using arrow keys

map("v", "<C-h>", ":nohlsearch<CR>", DEFAULT_OPTIONS) -- cancel search highligting
map("n", "<C-h>", ":nohlsearch<CR>", DEFAULT_OPTIONS) -- cancel search highligting

map("c", "%s", "%sm/", DEFAULT_OPTIONS) -- only search in current buffer

map("n", "H", "^", DEFAULT_OPTIONS) -- H will go to begining of a line
map("n", "L", "$", DEFAULT_OPTIONS) -- H will go to begining of a line

map("n", "<c-d>", "<c-d>zz", DEFAULT_OPTIONS)
map("n", "<c-b>", "<c-b>zz", DEFAULT_OPTIONS)

map("n", "gf", ":edit <cfile><CR>", DEFAULT_OPTIONS) -- create a new file if it does not exist

map("n", "<Leader>-", ":split<CR>", DEFAULT_OPTIONS) --simpler split
map("n", "<Leader>|", ":vsplit<CR>", DEFAULT_OPTIONS)

