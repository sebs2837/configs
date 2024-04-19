return {
    {
        "folke/noice.nvim",
        events = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        config = function()
            require("noice").setup({
                views = {
                    cmdline_popup = {
                        position = {
                            row = "30%",
                            col = "50%",
                        },
                        size = {
                            width = 60,
                            height = "auto",
                        }
                    }
                },
                cmdline = {
                    enable = false,
                    opts = {},
                    format = {
                        cmdline = { pattern = "^:", icon = "", lang = "vim" },
                        search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
                        search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
                        filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
                        lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
                        help = { pattern = "^:%s*he?l?p?%s+", icon = "󰋗" },
                        input = {}, -- Used by input()
                    },
                },
                messages = {
                    view_search = "virtualtext",
                    view = "mini",
                    enabled = false,
                },
                lsp = {
                    progress = {
                        enabled = true,
                        -- Lsp Progress is formatted using the builtins for lsp_progress. See config.format.builtin
                        -- See the section on formatting for more details on how to customize.
                        --- @type NoiceFormat|string
                        format = "lsp_progress",
                        --- @type NoiceFormat|string
                        format_done = "lsp_progress_done",
                        throttle = 1000 / 30, -- frequency to update lsp progress message
                        view = "mini",
                    },
                    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
                    },

                },
                -- you can enable a preset for easier configuration
                presets = {
                    bottom_search = false,         -- use a classic bottom cmdline for search
                    command_palette = false,      -- position the cmdline and popupmenu together
                    long_message_to_split = true, -- long messages will be sent to a split
                    inc_rename = false,           -- enables an input dialog for inc-rename.nvim
                    lsp_doc_border = false,       -- add a border to hover docs and signature help
                },
            })
        end
    }
}
