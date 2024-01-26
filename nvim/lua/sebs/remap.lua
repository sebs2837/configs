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

vim.keymap.set("n", "<leader>bf", vim.cmd.Lexplore, DEFAULT_OPTIONS)
vim.keymap.set("v", "<", "<gv", DEFAULT_OPTIONS) -- select line again after indent
vim.keymap.set("v", ">", ">gv", DEFAULT_OPTIONS) -- select line again after indent

vim.keymap.set("n", "n", "nzzzv", DEFAULT_OPTIONS) -- keep search forward results centered
vim.keymap.set("n", "N", "Nzzzv", DEFAULT_OPTIONS) -- keep search backward results centered
vim.keymap.set("n", "J", "mzJ`z", DEFAULT_OPTIONS) -- move contents one line up and join current line

vim.keymap.set("i", "jk", "<Esc>", DEFAULT_OPTIONS) -- using jk instead of esc
vim.keymap.set("v", "jk", "<Esc>", DEFAULT_OPTIONS) -- using jk instead of esc

vim.keymap.set("n", "<Right>", ":bnext<CR>", DEFAULT_OPTIONS) -- move to next buffer using arrow keys
vim.keymap.set("n", "<Left>", ":bprevious<CR>", DEFAULT_OPTIONS) -- move to previous buffer using arrow keys

vim.keymap.set("v", "<C-h>", ":nohlsearch<CR>", DEFAULT_OPTIONS) -- cancel search highligting
vim.keymap.set("n", "<C-h>", ":nohlsearch<CR>", DEFAULT_OPTIONS) -- cancel search highligting

vim.keymap.set("c", "%s", "%sm/", DEFAULT_OPTIONS) -- only search in current buffer
vim.keymap.set("n", "<leader>sm", [[:%sm/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]) -- search in current buffer input under cursor

vim.keymap.set("n", "H", "^", DEFAULT_OPTIONS) -- H will go to begining of a line
vim.keymap.set("n", "L", "$", DEFAULT_OPTIONS) -- H will go to begining of a line

vim.keymap.set("n", "<c-d>", "<c-d>zz", DEFAULT_OPTIONS)
vim.keymap.set("n", "<c-b>", "<c-b>zz", DEFAULT_OPTIONS)

vim.keymap.set("n", "gf", ":edit <cfile><CR>", DEFAULT_OPTIONS) -- create a new file if it does not exist

vim.keymap.set("n", "<Leader>-", ":split<CR>", DEFAULT_OPTIONS) --simpler split
vim.keymap.set("n", "<Leader>|", ":vsplit<CR>", DEFAULT_OPTIONS)

vim.keymap.set("n", "q?", "<NOP>",DEFAULT_OPTIONS) --no command-line ex ? search

vim.keymap.set("n", "<leader>c?", toggle_special_chars ,DEFAULT_OPTIONS) -- toogle display spaces and other special characters

vim.keymap.set("n", "<leader>dg", "<cmd>diffget<cr>", DEFAULT_OPTIONS)
vim.keymap.set("n", "<leader>dp", "<cmd>diffput<cr>", DEFAULT_OPTIONS)
vim.keymap.set("t", "<ESC>", "<C-\\><C-n>", DEFAULT_OPTIONS)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv") --move lines up 
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv") --move lines down


vim.keymap.set("n", "<leader><leader>", function() -- reload with double leader
    vim.cmd("so")
end)

