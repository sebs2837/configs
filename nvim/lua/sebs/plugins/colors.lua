return {
    {
        'rose-pine/neovim',
        name = 'rose-pine',
        config = function ()
            require('rose-pine').setup({
                variant = "main",
                dim_inactive_windows = true,
                extend_background_behind_borders = true,
                dark_variant = "main",
                enable ={
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
    },
    { "EdenEast/nightfox.nvim" },
}

