local config = function()
    local telescope = require 'telescope'
    local builtin = require('telescope.builtin')
    local utils = require('telescope.utils')


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
            grep_string = { theme = "dropdown" },
            life_grep = { theme = "dropdown" },
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
    telescope.load_extension "undo"

    -- Key mappings
    map("n", "<C-p>", builtin.git_files,
        { noremap = true, silent = true, desc = 'telescope git files' })
    map("n", "<leader>pf", function()
            local where = utils.buffer_dir()
            builtin.find_files({ cwd = where })
        end,
        { noremap = true, silent = true, desc = 'telescope find files' })

    map("n", "<C-f>", builtin.help_tags,
        { noremap = true, silent = true, desc = 'telescope search help tags' })

    map("n", "<leader>pg", builtin.live_grep,
        { noremap = true, silent = true, desc = 'telescope live grep' })
    map("n", "<leader>pb", builtin.buffers,
        { noremap = true, silent = true, desc = 'telescope show buffers' })
    map("n", "<leader><tab>", builtin.commands,
        { noremap = true, silent = true, desc = 'telescope show commands' })
    map("n", "<leader>pu", "<cmd>Telescope undo<cr>", { noremap = true, silent = true, desc = 'telescope undo' })
    map("n", "<leader>pk", builtin.keymaps, { noremap = true, silent = true, desc = 'telescope keymaps' })
    map("n", "<leader>pWs", function()
        local word = vim.fn.expand("<cWORD>")
        builtin.grep_string({ search = word })
    end
    , { noremap = true, silent = true, desc = 'telescope grep string under cursor' })

    map("n", "<leader>pws", function()
        local word = vim.fn.expand("<cword>")
        builtin.grep_string({ search = word })
    end
    , { noremap = true, silent = true, desc = 'telescope grep string under cursor' })

    map("n", "<leader>ps", function()
        builtin.grep_string({ search = vim.fn.input("Grep > ") })
    end
    , { noremap = true, silent = true, desc = 'telescope grep string under cursor' })
end

return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            { "nvim-lua/popup.nvim" },
            { "nvim-telescope/telescope-ui-select.nvim" },
            { "debugloop/telescope-undo.nvim" },
        },
        config = config,
    }
}
