local config = function()
    require "nvim-treesitter.configs".setup {
        ensure_installed = {
            "bash",
            "c",
            "cpp",
            "css",
            "fish",
            "go",
            "html",
            "haskell",
            "json",
            "javascript",
            "julia",
            "lua",
            "markdown",
            "markdown_inline",
            "python",
            "ruby",
            "rust",
            "scss",
            "toml",
            "typst",
            "vimdoc",
            "yaml",
            "zig",
            "latex"
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
            "javascript",
            "vue",
            "xml",
            "rs",
            "go",
            "py",
            "lua",
            "c",
        },
        rainbow = {
            enable = true,
            extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
            max_file_lines = 2000 -- Do not enable for files with more than specified lines
        }
    }
    require 'treesitter-context'.setup {
        enable = true,            -- Enable this plugin (Can be enabled/disabled later via commands)
        max_lines = 0,            -- How many lines the window should span. Values <= 0 mean no limit.
        min_window_height = 0,    -- Minimum editor window height to enable context. Values <= 0 mean no limit.
        line_numbers = true,
        multiline_threshold = 20, -- Maximum number of lines to show for a single context
        trim_scope = 'outer',     -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
        mode = 'cursor',          -- Line used to calculate context. Choices: 'cursor', 'topline'
        -- Separator between context and content. Should be a single character string, like '-'.
        -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
        separator = nil,
        zindex = 20,     -- The Z-index of the context window
        on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
    }
end
return {
    {
        "nvim-treesitter/nvim-treesitter",
        config = config,
        dependencies = {
            { "nvim-treesitter/nvim-treesitter-textobjects" },
            { "nvim-treesitter/nvim-treesitter-context" },
        },
        build = ":TSUpdate"
    },
}
