local config = function()
    local mason     = require('mason')
    local mason_lsp = require('mason-lspconfig')
    local lspconfig = require('lspconfig')

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
            -- default handler
            function(server_name)
                lspconfig[server_name].setup({})
            end,
            rust_analyzer = function()
                lspconfig.rust_analyzer.setup {
                    settings = {
                        ['rust_analyzer'] = {
                            diagnostic = {
                                enable = false,
                            },
                            imports = {
                                granularity = {
                                    group = "module",
                                },
                                prefix = "self",
                            },
                            cargo = {
                                buildScripts = {
                                    enable = true,
                                }
                            },
                            procMacro = {
                                enable = true,
                            }
                        }
                    }
                }
            end,
            texlab = function()
                lspconfig.texlab.setup({
                    texlab = {
                        auxDirectory = "./out",
                        bibtexFormatter = "texlab",
                        build = {
                            args = { "-interaction=nonstopmode", "-synctex=1", "%f" },
                            executable = "tex",
                            forwardSearchAfter = false,
                            onSave = false
                        },
                        chktex = {
                            onEdit = false,
                            onOpenAndSave = false
                        },
                        diagnosticsDelay = 300,
                        formatterLineLength = 80,
                        forwardSearch = {
                            args = {}
                        },
                        latexFormatter = "latexindent",
                        latexindent = {
                            modifyLineBreaks = false
                        }
                    }
                })
            end,
            ts_ls = function()
                lspconfig.ts_ls.setup({
                    init_options = { hostInfo = 'neovim' },
                    filetypes = { 'javascript', 'typescript' },
                    root_dir = function()
                        local pattern = { 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' }
                        local root_dir = vim.fs.dirname(vim.fs.find(pattern, { upward = true })[1])
                        return root_dir
                    end,
                })
            end,
            zls = function()
                lspconfig.zls.setup({
                    filetypes = { 'zig' }
                })
                vim.g.zig_fmt_autosave = 0
            end,
            hls = function()
                lspconfig.hls.setup({
                    filetypes = { 'haskell', 'lhaskell', 'cabal' },
                })
            end,
            lua_ls = function()
                lspconfig.lua_ls.setup({
                    settings = {
                        Lua = {
                            runtime = {
                                version = 'LuaJIT',
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
            end,
            clangd = function()
                lspconfig.clangd.setup({})
            end,
            pylsp = function()
                lspconfig.pylsp.setup({
                    settings = {
                        pylsp = {
                            plugins = {
                                pylint = {
                                    enabled = false,
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
            end,
            julials = function()
                lspconfig.julials.setup({})
            end,
        }
    })

    require("lsp-colors").setup({
        Error = "#db4b4b",
        Warning = "#D8DD4F",
        Information = "#0db9d7",
        Hint = "#6CA4BE"
    })

    vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('SebsLspConfig', {}),
        callback = function(ev)
            local builtin = require('telescope.builtin')
            local map = vim.keymap.set
            local bufnr = ev.buf

            local lsp_clients = vim.lsp.get_clients({ bufnr = ev.buf })

            vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
            local client = lsp_clients[1]

            if client.server_capabilities.inlayHintProvider then
                --vim.lsp.inlay_hint.enable(false)
            end
            vim.diagnostic.config({
                virtual_text =  false ,
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = '',
                        [vim.diagnostic.severity.WARN] = '',
                        [vim.diagnostic.severity.INFO] = '',
                        [vim.diagnostic.severity.HINT] = '●',
                    }
                }
            })



            map("n", "<leader>vti", function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}), {})
            end, { noremap = true, silent = true, buffer = bufnr, desc = 'toggle inlay hint' })

            map("n", "<leader>k", vim.lsp.buf.hover,
                { noremap = true, silent = true, buffer = bufnr, desc = 'hover action' })

            -- Mappings.
            -- See `:help vim.lsp.*` for documentation on any of the below functions
            map('n', 'gD', vim.lsp.buf.declaration,
                { noremap = true, silent = true, buffer = bufnr, desc = 'go to declaration' })

            map('n', 'gd', vim.lsp.buf.definition,
                { noremap = true, silent = true, buffer = bufnr, desc = 'go to definition' })

            map('n', 'gtd', vim.lsp.buf.type_definition,
                { noremap = true, silent = true, buffer = bufnr, desc = 'go to type definition' })

            map('n', 'D', vim.lsp.buf.hover, { noremap = true, silent = true, desc = 'show hover info' })

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

            map('n', ']d', function() vim.diagnostic.jump({ count = 1, float = true }) end,
                { noremap = true, silent = true, buffer = bufnr, desc = 'go to next diagnostic message' })

            map('n', '[d', function() vim.diagnostic.jump({ count = -1, float = true }) end,
                { noremap = true, silent = true, buffer = bufnr, desc = 'got to previous diagnostic message' })

            map('n', '<leader><vh>', vim.lsp.buf.signature_help,
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

            map('n', '<leader>vrn', function() vim.lsp.buf.rename() end,
                { noremap = true, silent = true, buffer = bufnr, desc = 'rename under cursor' })

            map('n', '<leader>vca', vim.lsp.buf.code_action,
                { noremap = true, silent = true, buffer = bufnr, desc = 'code action' })

            map('n', '<leader>pca', function()
                    require('tiny-code-action').code_action()
                end,
                { noremap = true, silent = true, buffer = bufnr, desc = 'code action' })

            map('n', '<leader>vrr', function()
                    builtin.lsp_references()
                end,
                { noremap = true, silent = true, buffer = bufnr, desc = 'show all references' })

            map('n', '<leader>vf', function() vim.lsp.buf.format() end,
                { noremap = true, silent = true, buffer = bufnr, desc = 'format buffer' })
        end,
    })

    -- LuaSnip setup

    local luasnip = require("luasnip")
    local snippets = vim.fn.stdpath("config") .. "/lua/sebs/snippets"
    luasnip.setup({
        keep_roots = true,
        link_roots = true,
        link_children = true,
        update_events = "TextChanged,TextChangedI",
    });

    require("luasnip.loaders.from_lua").load({
        paths = snippets,
    })

    -- Setup Completion
    -- See https://github.com/hrsh7th/nvim-cmp#basic-configuration
    local cmp = require 'cmp'
    local kind_icons = {
        Text = " ",
        Method = " ",
        Function = "󰊕 ",
        Constructor = " ",
        Field = " ",
        Variable = " ",
        Class = " ",
        Interface = " ",
        Module = " ",
        Property = " ",
        Unit = " ",
        Value = " ",
        Enum = " ",
        Keyword = " ",
        Snippet = " ",
        Color = "",
        File = " ",
        Reference = " ",
        Folder = " ",
        EnumMember = " ",
        Constant = " ",
        Struct = " ",
        Event = " ",
        Operator = "  ",
        TypeParameter = "  ",
    }

end

return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewfile" },
        dependencies = {
            { "nvim-telescope/telescope.nvim" },
            {
                "rachartier/tiny-code-action.nvim",
                event = "LspAttach",
                config = function()
                    require('tiny-code-action').setup()
                end
            },
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },
            { "folke/lsp-colors.nvim" },
            { "f3fora/cmp-spell" },
            { "hrsh7th/cmp-calc" },
            { "hrsh7th/cmp-nvim-lsp-signature-help" },
            {
                "saghen/blink.cmp",
                version = "1.*",
                opts = {
                    signature = { enabled = true },
                    keymap = {
                        preset = 'default',
                        ['<C-n>'] = {
                            function(cmp)
                                cmp.show({providers = { 'snippets', 'lsp' } })
                            end
                        },
                        ['<Tab>'] = {'select_next', 'fallback'},
                        ['<S-Tab>'] = {'select_prev', 'fallback'},
                        ['<CR>'] = { 'accept', 'fallback'},
                    },
                },
            },
            {
                "L3MON4D3/LuaSnip",
                version = "v2.1.1",
                dependencies = {
                    { "saadparwaiz1/cmp_luasnip" },
                    { "hrsh7th/nvim-cmp" }
                }
            },
            {
                "chrisgrieser/nvim-lsp-endhints",
                event = "LspAttach",
                opts = {
                    icons = {
                        type = " ",
                        parameter = "󰰘 ",
                        offspec = "󰚺 ",
                        unknown = " ",
                    },
                    label = {
                        truncateAtChars = 30,
                        padding = 1,
                        marginLeft = 1,
                        sameKindSeperator = "; "
                    },
                    extmark = {
                        priority = 50,
                    },
                }, -- required, even if empty
            },
        },
        config = config
    }
}
