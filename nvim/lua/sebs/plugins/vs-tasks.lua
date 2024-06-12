return {
    "EthanJWright/vs-tasks.nvim",
    dependencies = {
        "nvim-lua/popup.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
        {
            'akinsho/toggleterm.nvim', version = "*", config = true
        },
    },
    config = function()
        local vstask = require("vstask")
        vstask.setup({
            cache_json_conf = true,    -- don't read the json conf every time a task is ran
            cache_strategy = "last",   -- can be "most" or "last" (most used / last used)
            terminal = 'toggleterm',
            term_opts = {
                current = {
                    direction = "float"
                }
            },
        })
        vim.keymap.set("n", "<leader>ta", function()
            require("telescope").extensions.vstask.tasks()
        end, { silent = true, noremap = true, desc = "run vs code tasks in telescope" })
    end
}
