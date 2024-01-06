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
function _G.bind_key(mode, key, cmd, opts)
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

local function toggle_special_chars()
    local toggle = vim.opt.list:get()
    if toggle then
        vim.opt.list = false
    else
        vim.opt.list = true
    end
end

--map("n", "<Space>", "<NOP>", DEFAULT_OPTIONS)
vim.g.mapleader = " "

bind_key("n", "<leader>bf", vim.cmd.Lexplore, DEFAULT_OPTIONS)
bind_key("v", "<", "<gv", DEFAULT_OPTIONS) -- select line again after indent
bind_key("v", ">", ">gv", DEFAULT_OPTIONS) -- select line again after indent

bind_key("n", "n", "nzzzv", DEFAULT_OPTIONS) -- keep search forward results centered
bind_key("n", "N", "Nzzzv", DEFAULT_OPTIONS) -- keep search backward results centered
bind_key("n", "J", "mzJ`z", DEFAULT_OPTIONS) -- TODO find out what it means

bind_key("i", "jk", "<Esc>", DEFAULT_OPTIONS) -- using jk instead of esc
bind_key("v", "jk", "<Esc>", DEFAULT_OPTIONS) -- using jk instead of esc

bind_key("n", "<Right>", ":bnext<CR>", DEFAULT_OPTIONS) -- move to next buffer using arrow keys
bind_key("n", "<Left>", ":bprevious<CR>", DEFAULT_OPTIONS) -- move to previous buffer using arrow keys

bind_key("v", "<C-h>", ":nohlsearch<CR>", DEFAULT_OPTIONS) -- cancel search highligting
bind_key("n", "<C-h>", ":nohlsearch<CR>", DEFAULT_OPTIONS) -- cancel search highligting

bind_key("c", "%s", "%sm/", DEFAULT_OPTIONS) -- only search in current buffer

bind_key("n", "H", "^", DEFAULT_OPTIONS) -- H will go to begining of a line
bind_key("n", "L", "$", DEFAULT_OPTIONS) -- H will go to begining of a line

bind_key("n", "<c-d>", "<c-d>zz", DEFAULT_OPTIONS)
bind_key("n", "<c-b>", "<c-b>zz", DEFAULT_OPTIONS)

bind_key("n", "gf", ":edit <cfile><CR>", DEFAULT_OPTIONS) -- create a new file if it does not exist

bind_key("n", "<Leader>-", ":split<CR>", DEFAULT_OPTIONS) --simpler split
bind_key("n", "<Leader>|", ":vsplit<CR>", DEFAULT_OPTIONS)

bind_key("n", "q?", "<NOP>",DEFAULT_OPTIONS) --no command-line ex ? search

bind_key("n", "<leader>c?", toggle_special_chars ,DEFAULT_OPTIONS) -- toogle display spaces and other special characters
bind_key("n", "<leader>dg", "<cmd>diffget<cr>", DEFAULT_OPTIONS)
bind_key("n", "<leader>dp", "<cmd>diffput<cr>", DEFAULT_OPTIONS)
bind_key("t", "<ESC>", "<C-\\><C-n>", DEFAULT_OPTIONS)
