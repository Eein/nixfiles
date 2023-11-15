{
  programs.tmux = {
    enable = true;
    extraConfig = ''
      unbind v
      unbind h
      unbind Up
      unbind Down
      unbind Left
      unbind Right

      set -g prefix `
      bind-key ` send-prefix

      set -g history-limit 10000
      set -g default-terminal "tmux-256color"
      # set -ag terminal-overrides ",xterm-256color:RGB"
      set-option -sa terminal-overrides ',*256color:Tc'
      set-option -sa terminal-overrides ',xterm*:Tc'
      




      # reload tmux config with ` + r
      unbind r
      bind r \
      source-file ~/.tmux.conf \;\
       display 'Reloaded tmux config.'

      bind Up resize-pane -U 4
      bind Down resize-pane -D 4
      bind Left resize-pane -L 8
      bind Right resize-pane -R 8

      bind v split-window -h -c "#{pane_current_path}"
      bind h split-window -v -c "#{pane_current_path}"

      # Fix escape bug in neovim
      set -sg escape-time 0
      setw -g mode-keys vi
      set-option -g mouse on
      set -g base-index 1
      set -g pane-base-index 1
      set -g status-interval 5

      # Theme
      #  modes
      set -g clock-mode-colour colour5
      setw -g mode-style 'fg=colour1 bg=colour16 bold'

      # panes
      set -g pane-border-style 'fg=colour233 bg=colour0'
      set -g pane-active-border-style 'bg=colour16 fg=colour16'

      # statusbar
      # Status bar color
      set -g status-style 'bg=#3e4251 fg=colour137 dim'
      set -g status-left ""
      set -g status-right '#[fg=colour255,bg=#1d1f2b] %b %d%l:%M '
      set -g status-right-length 50
      set -g status-left-length 20

      setw -g window-status-current-style 'fg=colour16 bg=colour255 bold'
      setw -g window-status-current-format ' #I#[fg=colour249]:#[fg=colour237]#W#[fg=colour249]  '

      setw -g window-status-style 'fg=colour9 bg=#3e4251'
      setw -g window-status-format ' #[fg=colour39]#I#[fg=colour237]:#[fg=colour250]#W#[fg=colour244]  '
    '';
  };
}
