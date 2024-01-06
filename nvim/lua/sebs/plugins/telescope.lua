local config = function()
    local telescope = require 'telescope'
    --local map = vim.api.nvim_set_keymap

    local map = vim.keymap.set

    telescope.setup({
        defaults = {
            -- Default configuration for telescope goes here:
            -- config_key = value,
            layout_config = {
                vertical = { width = 0.5 }
            },
            mappings = {
                i = {
                    -- map actions.which_key to <C-h> (default: <C-/>)
                    -- actions.which_key shows the mappings for your picker,
                    -- e.g. git_{create, delete, ...}_branch for the git_branches picker
                    ["<C-b>"] = "which_key"
                }
            }
        },
        pickers = {
            find_files = {
                find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
                theme = "dropdown",
            },
            buffers = {
                theme = "dropdown"
            },
            -- Default configuration for builtin pickers goes here:
            -- picker_name = {
            --   picker_config_key = value,
            --   ...
            -- }
            -- Now the picker_config_key will be applied every time you call this
            -- builtin picker
        },
        extensions = {
            ["ui-select"] = {},
            -- Your extension configuration goes here:
            -- extension_name = {
            --   extension_config_key = value,
            -- }
            -- please take a look at the readme of the extension you want to configure
            undo = {
                ouse_delta = true,
                use_custom_command = nil, -- setting this implies `use_delta = false`. Accepted format is: { "bash", "-c", "echo '$DIFF' | delta" }
                side_by_side = false,
                diff_context_lines = vim.o.scrolloff,
                entry_format = "state #$ID, $STAT, $TIME",
                time_format = "",
                mappings = {
                    i = {
                        -- IMPORTANT: Note that telescope-undo must be available when telescope is configured if
                        -- you want to replicate these defaults and use the following actions. This means
                        -- installing as a dependency of telescope in it's `requirements` and loading this
                        -- extension from there instead of having the separate plugin definition as outlined
                        -- above.
                        ["<cr>"] = require("telescope-undo.actions").yank_additions,
                        ["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
                        ["<C-cr>"] = require("telescope-undo.actions").restore,
                    },
                },
            },
        }
    })
    telescope.load_extension "file_browser"
    telescope.load_extension "undo"

    -- Key mappings
    map("n", "<C-p>", "<cmd>Telescope find_files prompt_prefix=🔍<CR>",
        { noremap = true, silent = true, desc = 'telescope find files' })
    map("n", "<C-g>", "<cmd>Telescope git_files<CR>",
        { noremap = true, silent = true, desc = 'telescope search git added files' })
    map("n", "<C-f>", "<cmd>Telescope help_tags<CR>",
        { noremap = true, silent = true, desc = 'telescope search help tags' })
    map("n", "<leader>tg", "<cmd>Telescope live_grep<CR>",
        { noremap = true, silent = true, desc = 'telescope live grep' })
    map("n", "<leader>fb", "<cmd>Telescope file_browser<CR>",
        { noremap = true, silent = true, desc = 'telescope file browser' })
    map("n", "<leader>tb", "<cmd>Telescope buffers<CR>",
        { noremap = true, silent = true, desc = 'telescope show buffers' })
    map("n", "<leader><tab>", "<cmd>lua require('telescope.builtin').commands()<cr>",
        { noremap = true, silent = true, desc = 'telescope show commands' })
    map("n", "<leader>tu", "<cmd>Telescope undo<cr>", { noremap = true, silent = true, desc = 'telescope undo' })
    map("n", "<leader>tk", "<cmd>Telescope keymaps<cr>", { noremap = true, silent = true, desc = 'telescope keymaps' })
end

return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            { "nvim-lua/popup.nvim" },
            { "nvim-telescope/telescope-file-browser.nvim" },
            { "nvim-telescope/telescope-ui-select.nvim" },
            { "debugloop/telescope-undo.nvim" },
        },
        config = config,
    }
}
