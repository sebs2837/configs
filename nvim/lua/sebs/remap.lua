OPTIONS = {
    default = function(self)
        return {
            noremap = true,
            silent = true,
        }
    end,
    expr = function(self)
        local exp = self.default()
    end,
    desc = function(self, description)
        return { noremap = self.noremap, silent = self.silent, desc = description }
    end
}

local explore_open = false

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
    opts = opts or OPTIONS:default()
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

--map("n", "<Space>", "<NOP>", OPTIONS:default())
vim.g.mapleader = " "

vim.keymap.set("n", "<leader>bf", function()
        if explore_open then
            vim.cmd { cmd = 'Lexplore', bang = true }
            explore_open = false
        else
            local file_type = vim.bo.filetype
            if file_type == "netrw" then
                vim.cmd { cmd = 'Lexplore', bang = true }
            else
                local cwd = vim.fn.expand("%:h")
                if cwd == '' then cwd = '~' end
                vim.cmd { cmd = 'Lexplore', args = { cwd }, bang = true }
            end
            explore_open = true
        end
    end,
    OPTIONS:default())

-- vim.keymap.set("n", "<leader>bF", vim.cmd({ cmd = 'Lexplore' }), OPTIONS:default())

vim.keymap.set("v", "<", "<gv", OPTIONS:default())                                         -- select line again after indent
vim.keymap.set("v", ">", ">gv", OPTIONS:default())                                         -- select line again after indent

vim.keymap.set("n", "n", "nzzzv", OPTIONS:default())                                       -- keep search forward results centered
vim.keymap.set("n", "N", "Nzzzv", OPTIONS:default())                                       -- keep search backward results centered
vim.keymap.set("n", "J", "mzJ`z", OPTIONS:default())                                       -- move contents one line up and join current line

vim.keymap.set("i", "jk", "<Esc>", OPTIONS:default())                                      -- using jk instead of esc
vim.keymap.set("v", "jk", "<Esc>", OPTIONS:default())                                      -- using jk instead of esc

vim.keymap.set("n", "<Right>", ":bnext<CR>", OPTIONS:default())                            -- move to next buffer using arrow keys
vim.keymap.set("n", "<Left>", ":bprevious<CR>", OPTIONS:default())                         -- move to previous buffer using arrow keys

vim.keymap.set("v", "<C-h>", ":nohlsearch<CR>", OPTIONS:default())                         -- cancel search highligting
vim.keymap.set("n", "<C-h>", ":nohlsearch<CR>", OPTIONS:default())                         -- cancel search highligting

vim.keymap.set("c", "%s", "%sm/", OPTIONS:default())                                       -- only search in current buffer
vim.keymap.set("n", "<leader>sm", [[:%sm/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]) -- search in current buffer input under cursor

vim.keymap.set("n", "H", "^", OPTIONS:default())                                           -- H will go to begining of a line
vim.keymap.set("n", "L", "$", OPTIONS:default())                                           -- H will go to begining of a line

vim.keymap.set("n", "<c-d>", "<c-d>zz", OPTIONS:default())
vim.keymap.set("n", "<c-b>", "<c-b>zz", OPTIONS:default())

vim.keymap.set("n", "gf", ":edit <cfile><CR>", OPTIONS:default()) -- create a new file if it does not exist

vim.keymap.set("n", "<Leader>-", ":split<CR>", OPTIONS:default()) --simpler split
vim.keymap.set("n", "<Leader>|", ":vsplit<CR>", OPTIONS:default())

vim.keymap.set("n", "q?", "<NOP>", OPTIONS:default())                      --no command-line ex ? search

vim.keymap.set("n", "<leader>c?", toggle_special_chars, OPTIONS:default()) -- toogle display spaces and other special characters

vim.keymap.set("t", "<ESC>", "<C-\\><C-n>", OPTIONS:default())

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv") --move lines up
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv") --move lines down

vim.keymap.set("n", "<leader>nc", function()
        local cfg = vim.fn.stdpath('config')
        vim.cmd { cmd = 'Lexplore', args = { cfg }, bang = true }
    end,
    OPTIONS:desc("open nvim user config")
)

vim.keymap.set("n", "<leader><leader>", function() -- reload with double leader
    vim.cmd("so")
end)

vim.keymap.set("n", "dg", function()
        vim.cmd.diffget { args = { "//2" } }
    end,
    OPTIONS:desc("diffget left (LOCAL)"))

vim.keymap.set("n", "dh", function()
        vim.cmd.diffget { args = { "//3" } }
    end,
    OPTIONS:desc("diffget right (REMOTE)"))
