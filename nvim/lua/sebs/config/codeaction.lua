
local map = vim.api.nvim_set_keymap
local default_options = { noremap = true, silent = true }

vim.g.code_action_menu_show_details = false
vim.g.code_action_menu_show_diff = false

map("n", "ga", ":CodeActionMenu<CR>", default_options)
