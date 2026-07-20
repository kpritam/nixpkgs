{ config, lib, pkgs, ... }:

{
  # sesh: fuzzy tmux session manager (combines tmux sessions, zoxide dirs, and
  # saved project configs), driven from the Prefix+T binding below.
  # https://github.com/joshmedeski/sesh
  home.packages = [ pkgs.sesh ];

  programs.tmux = {
    enable = true;
    keyMode = "vi";
    mouse = true;
    baseIndex = 1;
    escapeTime = 0;
    focusEvents = true;
    historyLimit = 50000;
    terminal = "tmux-256color";
    sensibleOnTop = true;
    customPaneNavigationAndResize = false;

    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      yank
      {
        plugin = resurrect;
        extraConfig = ''
          set -g @resurrect-capture-pane-contents 'on'
        '';
      }
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '15'
        '';
      }
      tmux-fzf
      cpu
      battery
      {
        # renders its own default config/menus into $XDG_CONFIG_HOME on first
        # run since the nix store is read-only; xdg-enable makes it use that
        # writable path instead of trying (and failing) to write next to the
        # plugin's immutable store path.
        plugin = tmux-which-key;
        extraConfig = ''
          set -g @tmux-which-key-xdg-enable 1
        '';
      }
      {
        plugin = catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavor 'mocha'
          set -g @catppuccin_window_status_style 'rounded'
        '';
      }
    ];

    extraConfig = ''
      # -- general -----------------------------------------------------------

      set -g prefix2 C-a                # GNU-Screen compatible secondary prefix
      bind C-a send-prefix -2

      set -g renumber-windows on
      set -g set-titles on
      set -g display-panes-time 800
      set -g display-time 1000
      set -g status-interval 5
      set -g monitor-activity on
      set -g visual-activity on
      setw -g clock-mode-style 12
      setw -g automatic-rename on

      bind r source-file ~/.config/tmux/tmux.conf \; display 'tmux.conf reloaded'

      # -- catppuccin status line ---------------------------------------------

      set -g status-left-length 100
      set -g status-right-length 100
      set -g status-left "#{E:@catppuccin_status_session}"
      set -g status-right "#{E:@catppuccin_status_application}"
      set -agF status-right "#{E:@catppuccin_status_cpu}"
      set -agF status-right "#{E:@catppuccin_status_ram}"
      set -agF status-right "#{E:@catppuccin_status_battery}"
      set -ag status-right "#[fg=#cdd6f4,bg=#313244] %H:%M "

      # -- navigation ----------------------------------------------------------

      bind C-c new-session
      bind C-f command-prompt -p find-session 'switch-client -t %%'
      bind -n S-Right next-window
      bind -n S-Left previous-window

      # switch panes using Alt-arrow without prefix, Vim-aware
      is_vim="ps -o state= -o comm= -t '#{pane_tty}' | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"
      bind-key -n C-h if-shell "$is_vim" 'send-keys C-h' 'select-pane -L'
      bind-key -n C-j if-shell "$is_vim" 'send-keys C-j' 'select-pane -D'
      bind-key -n C-k if-shell "$is_vim" 'send-keys C-k' 'select-pane -U'
      bind-key -n C-l if-shell "$is_vim" 'send-keys C-l' 'select-pane -R'
      bind-key -n 'C-\' if-shell "$is_vim" 'send-keys C-\\' 'select-pane -l'
      bind-key -n M-Left select-pane -L
      bind-key -n M-Right select-pane -R
      bind-key -n M-Up select-pane -U
      bind-key -n M-Down select-pane -D
      bind-key -n S-M-Left resize-pane -L 5
      bind-key -n S-M-Right resize-pane -R 5
      bind-key -n S-M-Up resize-pane -U 5
      bind-key -n S-M-Down resize-pane -D 5

      bind-key -T copy-mode-vi C-h select-pane -L
      bind-key -T copy-mode-vi C-j select-pane -D
      bind-key -T copy-mode-vi C-k select-pane -U
      bind-key -T copy-mode-vi C-l select-pane -R
      bind-key -T copy-mode-vi 'C-\' select-pane -l

      # -- panes & windows -------------------------------------------------------

      bind v split-window -h -c "#{pane_current_path}"
      bind h split-window -v -c "#{pane_current_path}"
      unbind '"'
      unbind %
      bind > swap-pane -D
      bind < swap-pane -U
      bind q killp

      # -- copy mode -------------------------------------------------------------

      bind Enter copy-mode
      bind-key -T copy-mode-vi v send -X begin-selection
      bind-key -T copy-mode-vi V send -X select-line
      bind-key -T copy-mode-vi r send -X rectangle-toggle
      bind-key -T copy-mode-vi y send -X copy-pipe-and-cancel "pbcopy"
      bind-key -n C-v run-shell "tmux save-buffer - | pbcopy"

      bind y send-keys "clear && tmux clear-history" \; send-keys Enter \; display 'Screen cleared'

      # -- sesh session manager (Prefix+T) ---------------------------------------

      bind-key T run-shell -b "sesh connect \"$(sesh list --icons | fzf-tmux -p 70%,70% \
        --no-sort --ansi --border-label ' sesh ' --prompt '⚡  ' \
        --header '  ^a all ^t tmux ^g configs ^x zoxide ^d kill' \
        --bind 'tab:down,btab:up' \
        --bind 'ctrl-a:change-prompt(⚡  )+reload(sesh list --icons)' \
        --bind 'ctrl-t:change-prompt(🪟  )+reload(sesh list -t --icons)' \
        --bind 'ctrl-g:change-prompt(⚙️  )+reload(sesh list -c --icons)' \
        --bind 'ctrl-x:change-prompt(📁  )+reload(sesh list -z --icons)' \
        --bind 'ctrl-d:execute(tmux kill-session -t {})+change-prompt(⚡  )+reload(sesh list --icons)' \
        --preview-window 'right:55%' --preview 'sesh preview {}')\""
    '';
  };
}
