local api = vim.api
local cmd = vim.cmd


api.nvim_create_augroup("open_folds", { clear = false })
api.nvim_create_autocmd({ "BufEnter", "BufReadPost" }, {
    pattern = { "*" },
    group = "open_folds",
    callback = function ()
        cmd([[ norm zx
               norm zR
        ]])
    end,
})

