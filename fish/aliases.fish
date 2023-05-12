#!/bin/fish

# ALIASES

# GIT
abbr -a g git
abbr -a gc 'git checkout'
abbr -a ga 'git add -p'
abbr -a gah 'git stash; and git pull --rebase; and git stash pop'
abbr -a vimdiff 'nvim -d'

# NVIM
alias vi="nvim"
alias vim="nvim"

# RUST 
abbr -a c cargo
abbr -a ct 'cargo t'

# BUILDERS
abbr -a m make

alias tma='tmux attach -d -t'
alias tmx='tmux new -f ~/.config/tmux/tmux.conf -s (basename (pwd))'
alias tmux='tmux -f ~/.config/tmux/tmux.conf'

# CLI-TOOL
abbr -a yr 'cal -y'
abbr -a calc 'bc'


if command -v exa > /dev/null
	abbr -a l 'exa --icons '
	abbr -a ls 'exa --icons'
	abbr -a ll 'exa --icons -l'
	abbr -a lll 'exa --icons -la'
	abbr -a lt 'exa --icons -T'
else
	abbr -a l 'ls'
	abbr -a ll 'ls -l'
	abbr -a lll 'ls -la'
end
# make standard ls also available

abbr -a lx 'ls'


# nice cheat sheet appl in rust
if command -v navi > /dev/null
    navi widget fish | source
end

if set -q ARCH_LINUX
    if command -v paru > /dev/null
        abbr -a p 'paru'
        abbr -a up 'paru -Syu'
    end
end

