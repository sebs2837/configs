local config = function()
    local telescope = require 'telescope'
    local builtin = require('telescope.builtin')
    local utils = require('telescope.utils')
    local themes = require('telescope.themes')

    local map = vim.keymap.set

    telescope.load_extension "undo"
    telescope.load_extension "file_browser"

    telescope.setup({
        defaults = {
            -- Default configuration for telescope goes here:
            -- config_key = value,
            preview = false,
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
            },
            buffers = {
                theme = "dropdown",
            },
            grep_string = { theme = "dropdown" },
            life_grep = { theme = "dropdown" },
            lsp = { theme = "cursor" },
        },
        extensions = {
            file_browser = {
                theme = "dropdown",
                hijack_netrw = true,
                mappings = {
                    ["i"] = {},
                    ["n"] = {},
                }
            },
            undo = {
                use_delta = true,
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

    -- Key mappings
    map("n", "<C-p>", function()
            local git_dir = vim.fn.finddir('.git', vim.fn.getcwd() .. ";")
            if git_dir == "" then
                vim.notify(vim.fn.getcwd() .. " is not a git repo", vim.log.levels.ERROR)
                return
            end

            builtin.git_files()
        end,
        { noremap = true, silent = true, desc = 'telescope git files' })

    map("n", "<leader>ff", function()
            local opts = {
                cwd = utils.buffer_dir(),
                follow = true,
                hidden = true,
            }
            builtin.find_files(opts)
        end,
        { noremap = true, silent = true, desc = 'telescope find files' })

    map("n", "<leader>fc", function()
        local cwd = vim.fn.stdpath('config')
        local opt = themes.get_dropdown {
            cwd = cwd,
            prompt_title = "Find neovim config",
            preview = false,
            shorten_path = true,
            follow = true,
        }
        builtin.find_files(opt)
    end, OPTIONS:desc('open nvim config in telescope'))

    map("n", "<C-f>", builtin.help_tags,
        { noremap = true, silent = true, desc = 'telescope search help tags' })

    map("n", "<leader>fg", builtin.live_grep,
        { noremap = true, silent = true, desc = 'telescope live grep' })

    map("n", "<leader>fb", builtin.buffers,
        { noremap = true, silent = true, desc = 'telescope show buffers' })

    map("n", "<leader>fB", function()
        local opt = themes.get_dropdown {
            prompt_title = "File browser",
            preview = false,
            follow = true,
        }
        telescope.extensions.file_browser.file_browser(opt)
    end, { noremap = true, silent = true, desc = "open telescope file browers" })

    map("n", "<leader><tab>", builtin.commands,
        { noremap = true, silent = true, desc = 'telescope show commands' })

    map("n", "<leader>tu", "<cmd>Telescope undo<cr>", { noremap = true, silent = true, desc = 'telescope undo' })

    map("n", "<leader>tk", builtin.keymaps, { noremap = true, silent = true, desc = 'telescope keymaps' })

    map("n", "<leader>fWs", function()
        local word = vim.fn.expand("<cWORD>")
        builtin.grep_string({ search = word })
    end
    , { noremap = true, silent = true, desc = 'telescope grep string under cursor' })

    map("n", "<leader>fws", function()
        local word = vim.fn.expand("<cword>")
        builtin.grep_string({ search = word })
    end
    , { noremap = true, silent = true, desc = 'telescope grep string under cursor' })

    map("n", "<leader>fs", function()
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
            { "nvim-telescope/telescope-file-browser.nvim" },
        },
        config = config,
    }
}
