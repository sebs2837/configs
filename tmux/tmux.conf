set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'
set -g @plugin 'sainnhe/tmux-fzf'
set -g @plugin 'idevtier/tmux-cargo'
set -g @plugin 'akohlbecker/aw-watcher-tmux'
# change the default prefix key
unbind C-b
set -g prefix C-s
bind-key C-s send-prefix

# hot reload the config
unbind r
bind r source-file ~/.config/tmux/tmux.conf

# change the naming of panes and start with 1
set -g base-index 1

#set 256 terminal colors
set -g default-terminal "screen-256color"


#enable UTF9 unicode 
#setw -g utf8 on
#set -g status-utf8 on


# Key mapping
#
# split V
unbind '"'
unbind %
bind | split-window -h -c "#{pane_current_path}"
# split H
bind - split-window -v -c "#{pane_current_path}"
# create new window on current path
bind c new-window -c "#{pane_current_path}"

# switch panes using Alt-arrow without prefix
bind -n M-Left select-pane -L
bind -n M-Right select-pane -R
bind -n M-Up select-pane -U
bind -n M-Down select-pane -D


# Enable mouse mode (tmux 2.1 and above)
set -g mouse on

######################
### DESIGN CHANGES ###
######################

# Polar night (dark)
#nord1 #2E3440
#nord2 #3B4252
#nord3 #434C5E
#nord4 #4C566A
# Snow Storm (White)
#nord5 #D8DEE9
#nord6 #E5E9F0
#nord7 #ECEFF4
# Frost (Blue)
#nord8 #8FBCBB
#nord9 #88C0D0
#nord10 #81A1C1
#nord11 #5E81AC
# Aurora (Bright Colors)
#nord12 #BF616A Red
#nord13 #D08770 Orange
#nord14 #EBCB8B Yellow 
#nord15 #A3BE8C Green 
#nord16 #B48EAD Purple


# loud or quiet?
set -g visual-activity off
set -g visual-bell off
set -g visual-silence off
setw -g monitor-activity off
set -g bell-action none

#  modes
setw -g clock-mode-colour colour5
setw -g mode-style 'fg=colour1 bg=colour18 bold'

# panes
set -g pane-border-style 'fg=#4C566A dim'
set -g pane-active-border-style 'fg=#A3BE8C'

# statusbar
set -g status-position top
set -g status-justify centre
set -g status-style 'bg=#2E3440, fg=#D8DEE9 nodim'
set -g status-left ''
set -g status-right '#[fg=#434C5E, bg=#2E3440]#[bg=#434C5E, fg=#ECEFF4] %d/%m #[bg=#4C566A, fg=#ECEFF4] %H:%M:%S #[fg=#4C566A, bg=#2E3440] '
set -g status-right-length 50
set -g status-left-length 20

setw -g window-status-current-style 'bg=#2F3440 fg=#A3BE8C bold nodim'
setw -g window-status-current-format '#[bg=#A3BE8C, fg=#3B4252]#I:#W#F#[fg=#A3BE8C, bg=#2F3440]'

setw -g window-status-style 'bg=#2F3440 fg=#5F81AC nodim'
setw -g window-status-format '#[bg=#5F81AC, fg=#3B4252]#I:#W#F#[fg=#5F81AC, bg=#2F3440]'

setw -g window-status-bell-style 'fg=colour255 bg=colour1 bold'

# messages
set -g message-style 'fg=#B48EAD bg=black bold'

# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run '~/.tmux/plugins/tpm/tpm'
