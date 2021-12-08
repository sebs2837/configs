#  Global environment variables
set -xg EDITOR nvim
#Vulkan settings
#set -xg VULKAN_SDK $HOME/vulkan/1.2.170.0/x86_64
#set -xg VK_LAYER_PATH $VULKAN_SDK/etc/vulkan/explicit_layer.d
#set -xg LD_LIBRARY_PATH $VULKAN_SDK/lib $LD_LIBRARY_PATH
# neovide mutligrid
#set -xg NeoideMultiGrid
set -xg JAVA_HOME /usr/lib/jvm/java-14-openjdk
set JULIA /Applications/Julia-1.6.app/Contents/Resources/julia/bin
set NIX_LINK $HOME/.nix-profile
set RVM $HOME/.rvm/bin
set -xg PATH $HOME/bin $HOME/.cargo/bin $JAVA_HOME $RVM $JULIA $PATH
set -xg RUST_SRC_PATH (rustc --print sysroot)/lib/rustlib/src/rust/library
set -xg PIP_USR_BIN $HOME/.local/bin
set -xg GOPATH $HOME/code/go
set -xg GOBIN $GOPATH/bin
set -xg GO111MODULE on
set -xg CARGO_HOME $HOME/.cargo
set -xg CARGO_INSTALL_ROOT $CARGO_HOME
set -xg GEMS $HOME/.gem/ruby/3.0.0/bin
set -xg PATH $GOBIN $CARGO_INSTALL_ROOT $PIP_USR_BIN $GEMS $DOOM_BIN_PATH $PATH $VULKAN_SDK/bin
#set -xg ROGCAT_PROFILES $HOME/.config/rogcat/profiles.toml
set -xg CCACHE_DIR $HOME/CACHE
set -xg NAVI_CONFIG $HOME/.config/navi/config.yaml
#set -xg RUSTC_WRAPPER = /home/seri/.ccache
#

# User varibales 
set -U  fish_user_paths (yarn global bin)
set fish_greeting

# Aliases
abbr -a yr 'cal -y'
abbr -a c cargo
abbr -a e nvim
abbr -a m make
#abbr -a o xdg-open
abbr -a g git
abbr -a gc 'git checkout'
abbr -a ga 'git add -p'
abbr -a vimdiff 'nvim -d'
abbr -a ct 'cargo t'
abbr -a gah 'git stash; and git pull --rebase; and git stash pop'
#abbr -a p 'paru'
#abbr -a up 'paru -Syu'
abbr -a lzd 'lazydocker'
#abbr -a pdf 'zathura'
abbr -a calc 'bc'

alias vi="nvim"
alias vim="nvim"
alias nnn="nnn -e"

alias tma='tmux attach -d -t'
alias tmx='tmux new -f ~/.config/tmux/tmux.conf -s (basename (pwd))'


if command -v nix-env > /dev/null
  abbr -a nixi 'nix-env -iA'
  abbr -a nixq 'nix-env -qaP'
  abbr -a nixu 'nix-env -u'
  abbr -a nixgc 'nix-collect-garbage -d'
end
# NNN env variables
set -xg NNN_PLUG 'o:fzopen'

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

if command -v bat > /dev/null
	abbr -a cat 'bat'
end


# Base16 Shell
if status --is-interactive
    set BASE16_SHELL "$HOME/.config/base16-shell"
    source "$BASE16_SHELL/profile_helper.fish"
end

# nice cheat sheet appl in rust
if command -v navi > /dev/null
    navi widget fish | source
end

#if [ -e /usr/share/fish/functions/fzf_key_bindings.fish ]; and status --is-interactive
#	source /usr/share/fish/functions/fzf_key_bindings.fish
#end


if test -f /usr/share/autojump/autojump.fish;
	source /usr/share/autojump/autojump.fish;
end


function ssh
	switch $argv[1]
	case "*"
		/usr/bin/ssh $argv
	end
end

function apass
	if test (count $argv) -ne 1
		pass $argv
		return
	end

	asend (pass $argv[1] | head -n1)
end

function asend
	if test (count $argv) -ne 1
		echo "No argument given"
		return
	end

	adb shell input text (echo $argv[1] | sed -e 's/ /%s/g' -e 's/\([[()<>{}$|;&*\\~"\'`]\)/\\\\\1/g')
end

function limit
	numactl -C 0,1,2 $argv
end




# Type - to move up to top parent dir which is a repository
function d
	while test $PWD != "/"
		if test -d .git
			break
		end
		cd ..
	end
end

# Fish git prompt
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate ''
set __fish_git_prompt_showupstream 'none'
set -g fish_prompt_pwd_dir_length 3

# colored man output
# from http://linuxtidbits.wordpress.com/2009/03/23/less-colors-for-man-pages/
# setenv LESS_TERMCAP_mb \e'[01;31m'       # begin blinking
# setenv LESS_TERMCAP_md \e'[01;38;5;74m'  # begin bold
# setenv LESS_TERMCAP_me \e'[0m'           # end mode
# setenv LESS_TERMCAP_se \e'[0m'           # end standout-mode
# setenv LESS_TERMCAP_so \e'[38;5;246m'    # begin standout-mode - info box
# setenv LESS_TERMCAP_ue \e'[0m'           # end underline
# setenv LESS_TERMCAP_us \e'[04;38;5;146m' # begin underline

setenv LESS_TERMCAP_mb \e'[1;31m'     # begin blink
setenv LESS_TERMCAP_md \e'[1;36m'     # begin bold
setenv LESS_TERMCAP_me \e'[0m'        # reset bold/blink
setenv LESS_TERMCAP_so \e'[01;44;33m' # begin reverse video
setenv LESS_TERMCAP_se \e'[0m'        # reset reverse video
setenv LESS_TERMCAP_us \e'[1;32m'     # begin underline
setenv LESS_TERMCAP_ue \e'[0m'        # reset underline
setenv MANPAGER        'less -s -M +Gg' # percentage into document

# For RLS
# https://github.com/fish-shell/fish-shell/issues/2456
#setenv LD_LIBRARY_PATH (rustc +nightly --print sysroot)"/lib:$LD_LIBRARY_PATH"
#setenv RUST_SRC_PATH (rustc --print sysroot)"/lib/rustlib/src/rust/src"

setenv FZF_DEFAULT_COMMAND 'rg --files --follow'
setenv FZF_CTRL_T_COMMAND 'rg --files --follow'
setenv FZF_DEFAULT_OPTS '--preview "bat --style=numbers --color=always {} | head -500" --height 20%'

# Fish should not add things to clipboard when killing
# See https://github.com/fish-shell/fish-shell/issues/772
set FISH_CLIPBOARD_CMD "cat"

function fish_user_key_bindings
	bind \cz 'fg>/dev/null ^/dev/null'
	if functions -q skim_key_bindings
		skim_key_bindings
	end
end

#function fish_prompt
#	set_color brblack
#	echo -n "["(date "+%H:%M")"] "
#	set_color blue
#	echo -n (hostname)
#	if [ $PWD != $HOME ]
#		set_color brblack
#		echo -n ':'
#		set_color yellow
#		echo -n (basename $PWD)
#	end
#	set_color green
#	printf '%s ' (__fish_git_prompt)
#	set_color red
#	echo -n '| '
#	set_color normal
#end

#function fish_greeting
#	echo
#	echo -e (uname -ro | awk '{print " \\\\e[1mOS: \\\\e[0;32m"$0"\\\\e[0m"}')
#	echo -e (uptime -p | sed 's/^up //' | awk '{print " \\\\e[1mUptime: \\\\e[0;32m"$0"\\\\e[0m"}')
#	echo -e (uname -n | awk '{print " \\\\e[1mHostname: \\\\e[0;32m"$0"\\\\e[0m"}')
#	echo -e " \\e[1mDisk usage:\\e[0m"
#	echo
#	echo -ne (\
#		df -l -h | grep -E 'dev/(xvda|nvm|sd|mapper)' | \
#		awk '{printf "\\\\t%s\\\\t%4s / %4s  %s\\\\n\n", $6, $3, $2, $5}' | \
#		sed -e 's/^\(.*\([8][5-9]\|[9][0-9]\)%.*\)$/\\\\e[0;31m\1\\\\e[0m/' -e 's/^\(.*\([7][5-9]\|[8][0-4]\)%.*\)$/\\\\e[0;33m\1\\\\e[0m/' | \
#		paste -sd ''\
#	)
#	echo
#
#	echo -e " \\e[1mNetwork:\\e[0m"
#	echo
#	# http://tdt.rocks/linux_network_interface_naming.html
#	echo -ne (\
#		ip addr show up scope global | \
#			grep -E ': <|inet' | \
#			sed \
#				-e 's/^[[:digit:]]\+: //' \
#				-e 's/: <.*//' \
#				-e 's/.*inet[[:digit:]]* //' \
#				-e 's/\/.*//'| \
#			awk 'BEGIN {i=""} /\.|:/ {print i" "$0"\\\n"; next} // {i = $0}' | \
#			sort | \
#			column -t -R1 | \
#			# public addresses are underlined for visibility \
#			sed 's/ \([^ ]\+\)$/ \\\e[4m\1/' | \
#			# private addresses are not \
#			sed 's/m\(\(10\.\|172\.\(1[6-9]\|2[0-9]\|3[01]\)\|192\.168\.\).*\)/m\\\e[24m\1/' | \
#			# unknown interfaces are cyan \
#			sed 's/^\( *[^ ]\+\)/\\\e[36m\1/' | \
#			# ethernet interfaces are normal \
#			sed 's/\(\(en\|em\|eth\)[^ ]* .*\)/\\\e[39m\1/' | \
#			# wireless interfaces are purple \
#			sed 's/\(wl[^ ]* .*\)/\\\e[35m\1/' | \
#			# wwan interfaces are yellow \
#			sed 's/\(ww[^ ]* .*\).*/\\\e[33m\1/' | \
#			sed 's/$/\\\e[0m/' | \
#			sed 's/^/\t/' \
#		)
#	echo
#
#	set_color normal
#	echo -e " \e[1mTODOs\e[0;32m"
#	echo
#
#	set c (task status:pending count)
#	if [ $c -gt 0 ] 
#		set_color magenta
#		set tl ( task list )
#		set mx (math (count $tl)-1)
#		for entry in $tl[2..$mx]
#		    echo -e "$entry"
#		end
#	end
#
#	set_color normal
#end

#setxkbmap -option caps:escape

eval (ssh-agent -c) >> /dev/null
starship init fish | source
#freshfetch
fish_add_path /usr/local/opt/llvm/bin
