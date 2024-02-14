require("sebs.cmds")
require("sebs.set")
require("sebs.remap")
require("sebs.lazy")

function R(name)
    require('plenary.reload').reload_module(name)
end

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 1
vim.g.netrw_winsize = 25
