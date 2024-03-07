local config = function()
    require('fidget').setup({})
    local mason     = require('mason')
    local mason_lsp = require('mason-lspconfig')
    mason.setup({
        ui = {
            icons = {
                package_installed = "󰗠 ",
                package_pending = "󰺕 ",
                package_uninstalled = "󰅙 "
            }
        }
    })
    mason_lsp.setup({
        ensure_installed = { "lua_ls", "rust_analyzer" },
        handlers = {
            function(server_name)
                require('lspconfig')[server_name].setup({})
            end
        }
    })
    local lsp = require('lspconfig')

    require("lsp-colors").setup({
        Error = "#db4b4b",
        Warning = "#D8DD4F",
        Information = "#0db9d7",
        Hint = "#6CA4BE"
    })

    lsp.hls.setup({
        filetypes = { 'haskell', 'lhaskell', 'cabal' },
    })
    lsp.clangd.setup({})
    lsp.bashls.setup({})
    lsp.lua_ls.setup({
        settings = {
            Lua = {
                runtime = {
                    version = 'Lua 5.4',
                    path = {
                        '?.lua',
                        '?/init.lua',
                        vim.fn.expand '~/.luarocks',
                        vim.fn.expand '~/.luarocks/share/lua/5.4/?.lua',
                        vim.fn.expand '~/.luarocks/share/lua/5.4/?/init.lua',
                    }
                },
                workspace = {
                    library = {
                        '/opt/homebrew/opt/lua',
                        '/opt/homebrew/opt/luarocks',
                        vim.env.VIMRUNTIME,
                    }
                },
                hint = {
                    enable = true,
                },
            }
        }

    })

    lsp.pylsp.setup({
        settings = {
            pylsp = {
                plugins = {
                    pylint = {
                        enabled = true,
                        args = { "--disable=C0116,W1203,C0114" },
                        executable = "pylint"
                    },
                    pyflakes = { enabled = false },
                    pycodestyles = { enabled = false },
                    jedi_completion = { enabled = true },
                    jedi_hover = { enabled = true },
                    jedi_references = { enabled = true },
                    jedi_signature_help = { enabled = true },
                    jedi_symbols = { enabled = true, all_scopes = true },
                    pyls_isort = { enabled = true, profile = "black" },
                    pylsp_mypy = { enabled = true },
                    pylsp_black = {
                        enable = true,
                        line_length = 120
                    },
                },
            },
        },
        flags = {
            debounce_text_changes = 200,
        },
    })

    vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('SebsLspConfig', {}),
        callback = function(ev)
            local builtin = require('telescope.builtin')
            local map = vim.keymap.set
            local bufnr = ev.buf

            local lsp_clients = vim.lsp.get_active_clients({ bufnr = ev.buf })
            vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
            local client = lsp_clients[1]

            if client.name == 'rust_analyzer' then
                map("n", "<leader>k", require('rust-tools').hover_actions.hover_actions,
                    { noremap = true, silent = true, buffer = bufnr, desc = 'rust hover actions' })
            end

            -- Mappings.
            -- See `:help vim.lsp.*` for documentation on any of the below functions
            map('n', 'gD', vim.lsp.buf.declaration,
                { noremap = true, silent = true, buffer = bufnr, desc = 'go to declaration' })
            map('n', 'gd', vim.lsp.buf.definition,
                { noremap = true, silent = true, buffer = bufnr, desc = 'go to definition' })
            map('n', 'K', vim.lsp.buf.hover, { noremap = true, silent = true, desc = 'show hover info' })
            map('n', 'gi', vim.lsp.buf.implementation,
                { noremap = true, silent = true, buffer = bufnr, desc = 'go to implementation' })
            map('n', '<leader>df', vim.diagnostic.open_float,
                { noremap = true, silent = true, buffer = bufnr, desc = 'open diagnostics in floating window' })
            map('n', '<leader>vd', function()
                    builtin.diagnostics({ bufnr = 0 })
                end,
                { noremap = true, silent = true, buffer = bufnr, desc = 'show diagnostics for current buffer' })
            map('n', '<leader>vD', function()
                    builtin.diagnostics({})
                end,
                { noremap = true, silent = true, buffer = bufnr, desc = 'show diagnostics for current buffer' })
            map('n', ']d', vim.diagnostic.goto_next,
                { noremap = true, silent = true, buffer = bufnr, desc = 'go to next diagnostic message' })
            map('n', '[d', vim.diagnostic.goto_prev,
                { noremap = true, silent = true, buffer = bufnr, desc = 'got to previous diagnostic message' })
            map('n', '<C-h>', vim.lsp.buf.signature_help,
                { noremap = true, silent = true, buffer = bufnr, desc = 'show signature help' })
            map('n', '<leader>wa', vim.lsp.buf.add_workspace_folder,
                { noremap = true, silent = true, buffer = bufnr, desc = 'add folder to workspace' })
            map('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder,
                { noremap = true, silent = true, buffer = bufnr, desc = 'remove folder from workspace' })
            map('n', '<leader>wl', function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, { noremap = true, silent = true, buffer = bufnr, desc = 'list all workspace folders' })
            map('n', '<leader>D', function()
                    builtin.lsp_type_definitions()
                end,
                { noremap = true, silent = true, buffer = bufnr, desc = 'show type definition' })
            map('n', '<leader>vrn', vim.lsp.buf.rename,
                { noremap = true, silent = true, buffer = bufnr, desc = 'rename under cursor' })
            map('n', '<leader>vca', vim.lsp.buf.code_action,
                { noremap = true, silent = true, buffer = bufnr, desc = 'code action' })
            map('n', '<leader>vrr', function()
                    builtin.lsp_references()
                end,
                { noremap = true, silent = true, buffer = bufnr, desc = 'show all references' })
            map('n', '<leader>vf', vim.lsp.buf.format,
                { noremap = true, silent = true, buffer = bufnr, desc = 'format buffer' })
        end,
    })

    local opts = {
        tools = { -- rust-tools options
            autoSetHints = true,
            inlay_hints = {

                -- Only show inlay hints for the current line
                only_current_line = false,

                -- Event which triggers a refersh of the inlay hints.
                -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
                -- not that this may cause  higher CPU usage.
                -- This option is only respected when only_current_line and
                -- autoSetHints both are true.
                only_current_line_autocmd = "CursorHold",

                -- wheter to show parameter hints with the inlay hints or not
                show_parameter_hints = true,

                -- prefix for parameter hints
                parameter_hints_prefix = "<- ",

                -- prefix for all the other hints (type, chaining)
                other_hints_prefix = "=> ",

                -- whether to align to the length of the longest line in the file
                max_len_align = false,

                -- padding from the left if max_len_align is true
                max_len_align_padding = 1,

                -- whether to align to the extreme right or not
                right_align = false,

                -- padding from the right if right_align is true
                right_align_padding = 7,

                -- The color of the hints
                highlight = "SpecialComment",
            },
            hover_actions = {

                -- the border that is used for the hover window
                -- see vim.api.nvim_open_win()
                border = {
                    { "╭", "FloatBorder" },
                    { "─", "FloatBorder" },
                    { "╮", "FloatBorder" },
                    { "│", "FloatBorder" },
                    { "╯", "FloatBorder" },
                    { "─", "FloatBorder" },
                    { "╰", "FloatBorder" },
                    { "│", "FloatBorder" },
                },

                -- Maximal width of the hover window. Nil means no max.
                max_width = nil,

                -- Maximal height of the hover window. Nil means no max.
                max_height = nil,

                -- whether the hover action window gets automatically focused
                -- default: false
                auto_focus = false,
            },
        },

        -- all the opts to send to nvim-lspconfig
        -- these override the defaults set by rust-tools.nvim
        -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
        server = {
            -- on_attach is a callback called when the language server attachs to the buffer
            --	on_attach = function ()
            -- Hover actions
            --	  vim.keymap.set("n", "<C-leader>", require('rust-tools').hover_actions.hover_actions, { buffer = bufnr })
            -- Code action groups
            --	  vim.keymap.set("n", "<Leader>a", require('rust-tools').code_action_group.code_action_group, { buffer = bufnr })
            settings = {
                -- to enable rust-analyzer settings visit:
                -- https://github.com/rust-aalyzer/rust-analyzero blob/master/docs/user/generated_config.adoc
                ["rust-analyzer"] = {
                    -- enable clippy on save
                    checkOnSave = {
                        command = "clippy"
                    },
                }
            }
        },
    }


    require('rust-tools').setup(opts)

    -- Setup Completion
    -- See https://github.com/hrsh7th/nvim-cmp#basic-configuration
    local lspkind = require('lspkind')
    local cmp = require 'cmp'
    cmp.setup({
        -- Enable LSP snippets
        snippet = {
            expand = function(args)
                vim.fn["vsnip#anonymous"](args.body)
            end,
        },
        mapping = {
            ['<C-p>'] = cmp.mapping.select_prev_item(),
            ['<C-n>'] = cmp.mapping.select_next_item(),
            -- Add tab support
            ['<S-Tab>'] = cmp.mapping.select_prev_item(),
            ['<Tab>'] = cmp.mapping.select_next_item(),
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-leader>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.close(),
            ['<CR>'] = cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Insert,
                select = true,
            })
        },

        -- format actions to get icons
        formatting = {
            format = lspkind.cmp_format({
                mode = 'symbol',       -- show only symbol annotations
                maxwidth = 50,         -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

                -- The function below will be called before any actual modifications from lspkind
                -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
                before = function(entry, vim_item)
                    return vim_item
                end
            })
        },

        -- Installed sources
        sources = {
            { name = 'nvim_lsp' },
            { name = 'vsnip' },
            { name = 'path' },
            { name = 'buffer' },
            { name = 'crates' },
        },
    })
end

return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "nvim-telescope/telescope.nvim" },
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },
            { "folke/lsp-colors.nvim" },
            { "f3fora/cmp-spell" },
            { "simrat39/rust-tools.nvim" },
            { "onsails/lspkind.nvim" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "hrsh7th/cmp-cmdline" },
            { "hrsh7th/cmp-vsnip" },
            { "hrsh7th/nvim-cmp" },
            { "hrsh7th/cmp-calc" },
            { "hrsh7th/cmp-emoji" },
            { "hrsh7th/vim-vsnip" },
            {
                "L3MON4D3/LuaSnip",
                version = "v2.1.1"
            },
            { "rafamadriz/friendly-snippets" },
            { "j-hui/fidget.nvim" }
        },
        config = config
    }
}
