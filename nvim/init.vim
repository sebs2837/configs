
"""Neovim Init.vim
set runtimepath^=~/.vim
let &packpath = &runtimepath

" =============================================================================
" # Editor settings
" ============================================================================="

set nocompatible
set mouse=a
filetype off
set hidden
set cmdheight=2
set updatetime=300 "after 300ms without input write to swap
set shortmess+=c "don't give |ins-completion-menue| message
set signcolumn=yes "always show sign column"
syntax on " Coloring
set wrap breakindent
set encoding=utf8
set title
" Permanent undo
set undodir=~/.vimdid
set undofile

set cursorline
set shiftwidth=4
set softtabstop=4
set autoindent

""" Filetype-Specific Configurations

" HTML, XML
autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
autocmd FileType vue setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
autocmd FileType css setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
autocmd FileType xml setlocal shiftwidth=2 tabstop=2 softtabstop=2

" Markdown and Journal
autocmd FileType markdown setlocal shiftwidth=2 tabstop=2 softtabstop=2 textwidth=120
autocmd FileType journal setlocal shiftwidth=2 tabstop=2 softtabstop=2 textwidth=120
autocmd FileType asciidoc setlocal shiftwidth=2 tabstop=2 softtabstop=2 textwidth=120

" Programming languages
autocmd FileType c,cpp,cc setlocal expandtab shiftwidth=2 softtabstop=2 cindent
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4 autoindent
autocmd FileType java setlocal expandtab shiftwidth=2 softtabstop=4 autoindent
autocmd FileType groovy setlocal expandtab shiftwidth=2 softtabstop=4 autoindent
autocmd FileType rust setlocal expandtab shiftwidth=2 softtabstop=2 cindent


" =============================================================================
" # Plugins
" =============================================================================
call plug#begin('~/.vim/plugged')
"Web development
Plug 'ap/vim-css-color'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }

"Main
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
" Completion plugins
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do':'yarn install --frozen-lockfile'}

"For the looks
Plug 'ryanoasis/vim-devicons'
Plug 'junegunn/goyo.vim'
Plug 'KabbAmine/vCoolor.vim'
Plug 'mhinz/vim-startify'

"Additional themes and colors
"Plug 'tomasiser/vim-code-dark'

" Functionalities
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tommcdo/vim-lion'
Plug 'lifepillar/vim-cheat40'
Plug 'scrooloose/nerdtree'
Plug 'frazrepo/vim-rainbow'
Plug 'alvan/vim-closetag'
Plug 'Yggdroot/indentLine'
Plug 'junegunn/fzf', { 'dir': '~/.fzf_vim', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'wsdjeg/vim-hackernews'
Plug 'easymotion/vim-easymotion'
Plug 'chrisbra/unicode.vim'
Plug 'honza/vim-snippets'
Plug 'suan/vim-instant-markdown'
Plug 'voldikss/vim-floaterm'
Plug 'liuchengxu/vim-which-key'
Plug 'vifm/vifm.vim'

" language support
"Plug 'fatih/vim-go'
Plug 'rust-lang/rust.vim'
Plug 'habamax/vim-asciidoctor'

" Graveyard
" Plug 'airblade/vim-rooter'
" Plug 'scrooloose/nerdcommenter'
" Plug 'tpope/vim-abolish'
" Plug 'will133/vim-dirdiff'
" Plug 'junegunn/vim-easy-align'
"Testing area
Plug '~/code/rst/reqorous'

call plug#end()


"==============================================================================
" GUI Settings
"==============================================================================
"""Base 16
"set background=dark
colorscheme base16-gruvbox-dark-medium
""" Enable rainbow brackets
let g:rainbow_active = 1
"highlight Pmenu guibg=white guifg=black gui=bold
if has('nvim')
    set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
    set inccommand=nosplit
    noremap <C-q> :confirm qall<CR>
    set guifont=Fira\ Code\ Regular\ Nerd\ Font\ Complete:h16
end
set guifont=Fira\ Code:h16

highlight Comment gui=bold
highlight Normal gui=none
highlight NonText guibg=none

" Opaque Background (Comment out to use terminal's profile)
set termguicolors
"highlight CursorLine gui=underline cterm=underline guibg=none ctermbg=none
" Transparent Background (For i3 and compton)
highlight Normal guibg=NONE ctermbg=NONE
highlight LineNr guibg=NONE ctermbg=NONE

""" Other Configurations
set incsearch ignorecase smartcase hlsearch
set list listchars=trail:»,tab:»-
set fillchars+=vert:\ 
set guioptions-=T "No toolbar"
set ruler laststatus=2 showcmd showmode
set number
set relativenumber
set colorcolumn=80,120 "draw a colored column"

" Git diff options
set diffopt+=iwhite" No whitespace in vimdiff
" Make diffing better: https://vimways.org/2018/the-power-of-diff/
set diffopt+=algorithm:patience
set diffopt+=indent-heuristic

" =============================================================================
" # Custom Key Bindings
" =============================================================================
let mapleader="\<Space>"
let maplocalleader=","
nnoremap <leader>q :NERDTreeToggle<CR>
nmap <leader>ee :Colors<CR>
nmap <silent><leader>r  :so ~/.config/nvim/init.vim<CR>
nmap <leader>ws :call TrimWhitespace()<CR>
xmap <leader>a gaip*
nmap <leader>a gaip*
nmap <leader>x <C-w>s<C-w>j:terminal<CR>
nmap <leader>vs <C-w>v<C-w>l:terminal<CR>
nmap <leader>f :Files<CR>
nmap <leader>g :Goyo 120<CR>
nmap <leader>j :set filetype=journal<CR>
nmap <leader>T :enew<CR>
nmap <leader>bl :ls<CR>
nmap <leader>ev :vsplit $MYVIMRC<CR>

" Further fzf bindings
nnoremap <C-p> :Files<cr>
" Completion

" Ctrl+c and Ctrl+j as Esc
inoremap jk <Esc>
vnoremap jk <Esc>
inoremap <C-c> <Esc>
vnoremap <C-c> <Esc>

" Suspend with Ctrl+z
inoremap <C-z> :sus<cr>
vnoremap <C-z> :sus<cr>
nnoremap <C-z> :sus<cr>


" RG search mappings
noremap <leader>s :Rg
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

autocmd FileType python nmap <leader>x :0,$!~/.config/nvim/env/bin/python -m yapf<CR>
nmap <leader>n :HackerNews best<CR>J
nmap <silent> <leader><leader> :noh<CR>
nnoremap <right> :bnext<CR>
nnoremap <left> :bprevious<CR>

" Vim like movement beginn and end fo line
map H ^
map L $

" Ctrl+h to stop searching
vnoremap <C-h> :nohlsearch<cr>
nnoremap <C-h> :nohlsearch<cr>

" Search results centered please
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

nnoremap ? ?\v
nnoremap / /\v
cnoremap %s/ %sm/

" hard Mode no arrwos allowed
nnoremap <up>    <nop>
nnoremap <down>  <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

noremap <Leader>Y "+y
noremap <Leader>P "+p
noremap <leader>p :read !xsel --clipboard --output<cr>
noremap <leader>c :w !xsel -ib<cr><cr>

" Toggle visibilty of special character
nnoremap <leader>, :set invlist<cr>

" Toggle buffers
nnoremap <leader><leader> <c-^><cr>


"=============================================================================
"  Plugin Configurations
" =============================================================================
source $HOME/.config/nvim/plugin-cfg/floatterm-cfg.vim
source $HOME/.config/nvim/plugin-cfg/startify-cfg.vim
source $HOME/.config/nvim/plugin-cfg/nerdtree-cfg.vim
source $HOME/.config/nvim/plugin-cfg/which-key-cfg.vim
source $HOME/.config/nvim/plugin-cfg/fzf-cfg.vim
source $HOME/.config/nvim/plugin-cfg/coc-cfg.vim
source $HOME/.config/nvim/plugin-cfg/lightline-cfg.vim
source $HOME/.config/nvim/plugin-cfg/easymotion-cfg.vim


"Vim rooter
"let g:rooter_patterns = ['Rakefile', '.git/', 'Cargo.toml', 'CMakeLists']

" Neovim :Terminal
tmap <Esc> <C-\><C-n>
tmap <C-w> <Esc><C-w>
autocmd BufWinEnter,WinEnter term://* startinsert
autocmd BufLeave term://* stopinsert

"Python settings
let g:python3_host_prog='/usr/bin/python'

" settings for go lang
let g:go_play_open_browser = 0
let g:go_def_mapping_enabled = 0
let g:go_fmt_fail_silently = 1
let g:go_fmt_command = "goimports"
let g:go_bin_path = $GOBIN

" rust settings
"let g:rustfmt_autosave = 1
"let g:formatters_rust=['rustfmt']
"et g:formatdef_rustfmt='"rustfmt"'
let g:rust_clip_command = 'xclip -section clipboard'
"let g:rustfmt_options = '--edition 2018'


" autoformat
augroup autoformat_settings
  autocmd FileType bzl AutoFormatBuffer buildifier
  " autocmd FileType proto,javascript AutoFormatBuffer clang-format
  autocmd FileType dart AutoFormatBuffer dartfmt
  "autocmd FileType go AutoFormatBuffer gofmt
  autocmd FileType gn AutoFormatBuffer gn format
  autocmd FileType java AutoFormatBuffer google-java-format
  autocmd FileType python AutoFormatBuffer yapf
  " autocmd FileType rust AutoFormatBuffer rustfmt
  " autocmd FileType python AutoFormatBuffer autopep8
  " autocmd FileType vue AutoFormatBuffer prettier
augroup END

" enable spell check for dedicated files
autocmd BufRead,BufNewFile *.adoc setlocal spell spelllang=en_us
autocmd BufRead,BufNewFile *.md setlocal spell spelllang=en_us
autocmd BufRead,BufNewFile *.html setlocal spell spelllang=en_us

" Wrapping options
set formatoptions=tc " wrap text and comments using textwidth
set formatoptions+=r " continue comments when pressing ENTER in I mode
set formatoptions+=q " enable formatting of comments with gq
set formatoptions+=n " detect lists for formatting
set formatoptions+=b " auto-wrap in insert mode, and do not wrap old long line


"EasyAlign
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" indentLine
let g:indentLine_char = '▏'
let g:indentLine_color_gui = '#363949'

"==============================================================================
" Custom Functions
"==============================================================================

if executable('rg')
	set grepprg=rg\ --no-heading\ --vimgrep
	set grepformat=%f:%l:%c:%m
endif

" Trim Whitespaces
function! TrimWhitespace()
    let l:save = winsaveview()
    %s/\\\@<!\s\+$//e
    call winrestview(l:save)
endfunction

