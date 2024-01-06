#  Global environment variables
set -xg EDITOR nvim

# HOMEBREW
set -xg HOMBREW_HOME /opt/homebrew

# Random work related tools
set -xg TOOLS $HOME/.tools/bin

# FIG
set -xg GIT $HOMBREW_HOME/bin/git

# JAVA
set -xg JAVA_HOME $HOMBREW_HOME/opt/openjdk/

# JULIA
set JULIA /Applications/Julia-1.6.app/Contents/Resources/julia/bin

# PYTHON
set PIP_USR_BIN $HOME/.local/bin
set PYTHON_USR_BIN $HOME/Library/Python/3.10/bin

# GO Settings
set -xg GOPATH $HOME/code/go
set -xg GOBIN $GOPATH/bin
set -xg GO111MODULE on

#RUST
set -xg CARGO_HOME $HOME/.cargo
set -xg CARGO_INSTALL_ROOT $CARGO_HOME

#RUBY
set RVM $HOME/.rvm/bin

set -xg PATH $HOME/bin $FIG $HOME/.cargo/bin $JAVA_HOME/bin $RVM $JULIA $PATH
set -xg PATH $TOOLS $GOBIN $CARGO_INSTALL_ROOT $PIP_USR_BIN $PYTHON_USR_BIN $GIT $GEMS $LUA_LSP $PATH 

set -xg RUST_SRC_PATH (rustc --print sysroot)/lib/rustlib/src/rust/library

set -xg ROGCAT_PROFILES $HOME/.config/rogcat/profiles.toml
set -xg CCACHE_DIR $HOME/CACHE
set -xg NAVI_CONFIG $HOME/.config/navi/config.yaml
#set -xg RUSTC_WRAPPER = /home/seri/.ccache

# User varibales 
# set -U  fish_user_paths (yarn global bin)
set fish_greeting


switch (uname)
  case Darwin
    set -U fish_user_paths /opt/homebrew/bin
end

if test -f ./aliases.fish
    source ./aliases.fish
end

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

setenv LESS_TERMCAP_mb \e'[1;31m'     # begin blink
setenv LESS_TERMCAP_md \e'[1;36m'     # begin bold
setenv LESS_TERMCAP_me \e'[0m'        # reset bold/blink
setenv LESS_TERMCAP_so \e'[01;44;33m' # begin reverse video
setenv LESS_TERMCAP_se \e'[0m'        # reset reverse video
setenv LESS_TERMCAP_us \e'[1;32m'     # begin underline
setenv LESS_TERMCAP_ue \e'[0m'        # reset underline
setenv MANPAGER        'less -s -M +Gg' # percentage into document


setenv FZF_DEFAULT_COMMAND 'rg --files --follow'
setenv FZF_CTRL_T_COMMAND 'rg --files --follow'
setenv FZF_DEFAULT_OPTS '--preview "bat --style=numbers --color=always {} | head -500" --height 20%'

# Fish should not add things to clipboard when killing
# See https://github.com/fish-shell/fish-shell/issues/772
set FISH_CLIPBOARD_CMD "cat"

function fish_user_key_bindings
  bind \cz 'fg>/dev/null ^/dev/null' # don't display message when sending to bg
  skim
end


eval (ssh-agent -c) >> /dev/null
starship init fish | source

# removing bin utils for testing
#fish_add_path /usr/local/opt/llvm/bin
#fish_add_path /usr/local/opt/binutils/bin
#fish_add_path /opt/homebrew/opt/binutils/bin

# kitty shell extensions 
if set -q KITTY_INSTALLATION_DIR
    set --global KITTY_SHELL_INTEGRATION enabled
    source "$KITTY_INSTALLATION_DIR/shell-integration/fish/vendor_conf.d/kitty-shell-integration.fish"
    set --prepend fish_complete_path "$KITTY_INSTALLATION_DIR/shell-integration/fish/vendor_completions.d"
end
eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)"
if test  -b $HOME/.rvm/scripts/rvm
  source $HOME/.rvm/scripts/rvm
end
