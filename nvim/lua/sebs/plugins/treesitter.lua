local config = function()
    require "nvim-treesitter.configs".setup {
        ensure_installed = {
            "bash",
            "c",
            "cpp",
            "css",
            "elixir",
            "fish",
            "graphql",
            "html",
            "json",
            "lua",
            "markdown",
            "markdown_inline",
            "php",
            "python",
            "regex",
            "ruby",
            "rust",
            "scss",
            "sql",
            "toml",
            "tsx",
            "typescript",
            "vim",
            "yaml"
        },                   -- one of "all", "maintained" (parsers with maintainers), or a list of languages
        ignore_install = {}, -- List of parsers to ignore installing
        highlight = {
            enable = true,   -- false will disable the whole extension
            disable = {}     -- list of language that will be disabled
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<CR>",
                scope_incremental = "<CR>",
                node_incremental = "<TAB>",
                node_decremental = "<S-TAB>"
            },
            is_supported = function()
                local mode = vim.api.nvim_get_mode().mode
                if mode == "c" then
                    return false
                end
                return true
            end
        },
        indent = { enable = true },
        autopairs = { { enable = true } },
        textobjects = {
            select = {
                enable = true,
                -- Automatically jump forward to textobj, similar to targets.vim
                lookahead = true,
                keymaps = {
                    -- You can use the capture groups defined in textobjects.scm
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                    ["ac"] = "@class.outer",
                    ["ic"] = "@class.inner",
                    ["al"] = "@loop.outer",
                    ["il"] = "@loop.inner",
                    ["ib"] = "@block.inner",
                    ["ab"] = "@block.outer",
                    ["ir"] = "@parameter.inner",
                    ["ar"] = "@parameter.outer"
                }
            }
        },
        filetypes = {
            "html",
            "svelte",
            "typescript",
            "typescriptreact",
            "vue",
            "xml",
            "rs",
        },
        rainbow = {
            enable = true,
            extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
            max_file_lines = 2000 -- Do not enable for files with more than specified lines
        }
    }
end
return {
    {
        "nvim-treesitter/nvim-treesitter",
        config = config,
        dependencies = "nvim-treesitter/nvim-treesitter-textobjects",
        build = ":TSUpdate"
    },
}
