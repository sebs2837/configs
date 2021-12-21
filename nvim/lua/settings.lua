-- Neovim Lua config setting--

HOME = os.getenv("HOME") -- get home dir since ~ seems not to work

local o = vim.opt

-- General settings

o.compatible = false
o.syntax = "on"
o.number = true
o.hidden = true
o.relativenumber = true
o.mouse = "a" -- mouse in all previouse modes
o.filetype = "off"
o.hidden = true
o.cmdheight = 2
o.updatetime = 500
o.encoding = "utf8"

o.shortmess:append("c")

o.undodir = HOME.."/.vimdid"
o.undofile = true
o.signcolumn = "yes" -- signcolumn for git and other extensions

o.cursorline = true
o.shiftwidth = 4
o.softtabstop = 4
o.autoindent = true

o.wrap = true -- wrap lines
o.breakindent = true
o.title = true

-- UI Settings
o.background = "dark"
o.termguicolors = true
o.guifont = "Fira Code:h16"
o.showtabline = 2
o.ruler = true
o.laststatus = 2

o.colorcolumn = "80,120" -- draw a colorcolumn at 80 and 120
o.listchars = "eol:¬,tab:▸·,trail:~,extends:>,precedes:<,space:␣"

o.incsearch = true
o.ignorecase = true
o.smartcase = true
o.hlsearch = true
o.magic = true

o.grepprg = "rg --hidden --vimgrep --smart-case --"
o.completeopt = {"menu", "menuone", "noselect", "noinsert"} -- A comma separated list of options for Insert mode completion

--[[
- tc wrap text and comments using the textwidht
- r continue comments when pressing
- q enable formatting of comments with gq
- n detect list formatting
- b autowarp in instert mode but not old long lines
--]]
o.formatoptions = {"tc", "r", "q", "n","b"}

o.splitbelow = true -- force all horizontal splits to go below current window
o.splitright = true -- force all vertical splits to go to the right of current window

o.wildmode = "full"

o.wildignorecase = true -- When set case is ignored when completing file names and directories
o.wildignore = [[
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

o.diffopt = {"iwhite", "algorithm:histogram", "indent-heuristic"} -- ignore whitespaces 

