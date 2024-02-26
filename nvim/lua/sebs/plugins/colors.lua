
function ColoredPencils(color)
 	color = color or "rose-pine-main"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {
    {
        'rose-pine/neovim',
        name = 'rose-pine',
        config = function ()
            require('rose-pine').setup({
                variant = "auto",
                dim_inactive_windows = false,
                dark_variant = "main",
                styles = {
                    bold = true,
                    italic = true,
                    transparency = false,
                },
            })
        ColoredPencils('rose-pine-main')
		-- vim.cmd.colorscheme('rose-pine-main')

        end
    },
}

