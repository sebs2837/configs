local config = function()

    local harpoon = require('harpoon')

    local map = vim.keymap.set

    map('n', '<leader>hh', function () harpoon.ui:toggle_quick_menu(harpoon:list()) end, { silent = true, desc = 'harpoon toggle quick menu' })
    map('n', '<leader>ha', function () harpoon:list():append() end, { silent = true, desc = 'harpoon add file' })

    harpoon:setup({
        settings = {
             border_chars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        }
    })
end

return {
    {
        'ThePrimeagen/harpoon',
        branch = 'harpoon2',
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
        config = config,
    }
}
