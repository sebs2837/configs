-- Neovim Lua config setting--

HOME = os.getenv("HOME") -- get home dir since ~ seems not to work

local opt = vim.opt

-- General settings
-- disable inline diagnostics 
vim.diagnostic.config({virtual_text = false})

opt.compatible = false
opt.syntax = "on"
opt.number = true
opt.hidden = true
opt.relativenumber = true
opt.mouse = "a" -- mouse in all previouse modes
opt.filetype = "off"
opt.hidden = true
opt.cmdheight = 2
opt.updatetime = 500
opt.encoding = "utf8"
opt.spelllang = {"en_us"}
opt.spell = false


opt.shortmess:append("c")
opt.swapfile = false
opt.backup = false
opt.undodir = HOME.."/.vimdid"
opt.undofile = true
opt.signcolumn = "yes" -- signcolumn for git and other extensions

opt.cursorline = false

opt.expandtab = true
opt.shiftwidth = 4
opt.softtabstop = 4
opt.tabstop = 4

opt.wrap = true -- wrap lines
opt.breakindent = true
opt.title = true

-- UI Settings
opt.background = "dark"
opt.termguicolors = true

opt.guifont = "Fira Code:h16"
opt.showtabline = 2
opt.ruler = true
opt.laststatus = 2

opt.colorcolumn = "80,120" -- draw a colorcolumn at 80 and 120
opt.listchars = "eol:¬,tab:▸·,trail:~,extends:>,precedes:<,space:␣"

opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.magic = true

opt.grepprg = "rg --hidden --vimgrep --smart-case --"
opt.completeopt = {"menu", "menuone", "noselect", "noinsert"} -- A comma separated list of options for Insert mode completion

--[[
- tc wrap text and comments using the textwidht
- r continue comments when pressing
- q enable formatting of comments with gq
- n detect list formatting
- b autowarp in instert mode but not old long lines
--]]
opt.formatoptions:append("tcrqnb")

opt.splitbelow = true -- force all horizontal splits to go below current window
opt.splitright = true -- force all vertical splits to go to the right of current window

opt.wildmode = "full"

opt.wildignorecase = true -- When set case is ignored when completing file names and directories
opt.wildignore = [[
.git,.hg,.svn
*.aux,*.out,*.toc
*.o,*.obj,*.exe,*.dll,*.manifest,*.rbc,*.class
*.ai,*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.psd,*.webp
*.avi,*.divx,*.mp4,*.webm,*.mov,*.m2ts,*.mkv,*.vob,*.mpg,*.mpeg
*.mp3,*.oga,*.ogg,*.wav,*.flac
*.eot,*.otf,*.ttf,*.woff
*.doc,*.pdf,*.cbr,*.cbz
*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz,*.kgb
*.swp,.lock,.DS_Store,._*
*/tmp/*,*.so,*.swp,*.zip,**/node_modules/**,**/target/**,**.terraform/**"
]]

opt.diffopt = {"iwhite", "algorithm:histogram", "indent-heuristic"} -- ignore whitespaces
opt.clipboard='unnamed'
opt.scrolloff = 8 -- always have 8 lines ahead of the cursor

