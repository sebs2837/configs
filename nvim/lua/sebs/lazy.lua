local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)
local lazy = require("lazy")

local opts = {
    git = { log = { '--since=3 days ago' } },
    ui = { custom_keys = { false } },
    performance = {
        rtp = {
            disabled_plugins = {
                'gzip',
                'tarPlugin',
                'tohtml',
                'tutor',
                'zipPlugin',
                'rplugin',
            },
        },
    },
    checker = { enabled = false },
}


return lazy.setup("sebs.plugins", opts)
