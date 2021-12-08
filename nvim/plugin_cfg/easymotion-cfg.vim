"==============================================================================
"                                               __  _
"        ___  ____ ________  ______ ___  ____  / /_(_)___  ____
"       / _ \/ __ `/ ___/ / / / __ `__ \/ __ \/ __/ / __ \/ __ \
"      /  __/ /_/ (__  ) /_/ / / / / / / /_/ / /_/ / /_/ / / / /
"      \___/\__,_/____/\__, /_/ /_/ /_/\____/\__/_/\____/_/ /_/
"                     /____/
"==============================================================================

" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)
" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)
" Move to line
map <Leader>L <Plug>(easymotion-bd-jk) nmap <Leader>L <Plug>(easymotion-overwin-line)
" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)
