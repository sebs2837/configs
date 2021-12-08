"==============================================================================
"                         ___       __    __  ___
"                        / (_)___ _/ /_  / /_/ (_)___  ___
"                       / / / __ `/ __ \/ __/ / / __ \/ _ \
"                      / / / /_/ / / / / /_/ / / / / /  __/
"                     /_/_/\__, /_/ /_/\__/_/_/_/ /_/\___/
"                         /____/
"==============================================================================
set showtabline=2
let g:lightline = {
      \ 'colorscheme': 'one',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch','readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }
let g:lightline.tabline          = {'left': [['buffers']], 'right': [['close']]}
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type   = {'buffers': 'tabsel'}
let g:lightline#bufferline#shorten_path=1
