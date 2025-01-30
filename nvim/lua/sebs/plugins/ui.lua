local color_config = function()
    require('rose-pine').setup({
        variant = "main",
        dim_inactive_windows = true,
        extend_background_behind_borders = true,
        dark_variant = "main",
        enable = {
            legacy_highlight = true,
            migrations = true,
            terminal = true,
        },
        styles = {
            bold = true,
            italic = true,
            transparency = false,
        },
    })
    vim.cmd.colorscheme("rose-pine")
end

local render_markdown = function()
    require('render-markdown').setup()
end


local oil_cfg = function()
    require("oil").setup({
        default_file_explorer = true,
        columns = {
            "icon", "permission",
        },
        win_options = {
            wrap = false,
            signcolumn = "no"
        }
    })
    vim.keymap.set("n", "-", "<cmd>Oil<cr>", { desc = "Open oil at cwd", silent = true, noremap = true })
end

return {
    {
        "stevearc/oil.nvim",
        config = oil_cfg
    },
    "j-hui/fidget.nvim",
    {
        'rose-pine/neovim',
        name = 'rose-pine',
        config = color_config,
    },
    { "EdenEast/nightfox.nvim" },
    { "folke/tokyonight.nvim" },
    {
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {},
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' },
        config = render_markdown,
    }
}
