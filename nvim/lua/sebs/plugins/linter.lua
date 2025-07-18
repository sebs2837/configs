local config = function()
    --[[
    require('lint').linters_by_ft = {
        markdown = {'markdownlint',}
    }
    vim.api.nvim_create_autocmd({'BufWritePost'}, {
        group = vim.api.nvim_create_augroup('SebsLinters', {}),
        callback = function (ev)
            require('lint').try_lint()
        end,
    })--]]
end

return {
    {
        "mfussenegger/nvim-lint",
        config = config
    }
}
