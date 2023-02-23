{ lib, pkgs, ... }:
# Let-In --------------------------------------------------------------------------------------- {{{
let
  backgroundDependantColors = colors: with colors; {
    background = "#${base}";
    foreground = "#${main}";

    # Cursor
    cursor = "#${blue}";
    cursor_text_color = "#${base}";

    # Selection
    selection_background = "#${muted}";
    selection_foreground = "#${base}";

    # Tab bar
    tab_bar_background = "#${basehl}";
    inactive_tab_background = "#${strong}";
  };
in
# }}}
{
  # Kitty terminal
  # https://sw.kovidgoyal.net/kitty/conf.html
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.kitty.enable
  programs.kitty.enable = true;

  # General config ----------------------------------------------------------------------------- {{{

  programs.kitty.settings = {
    # https://fsd.it/shop/fonts/pragmatapro/
    font_family = "MonoLisa";
    font_size = "17.0";
    adjust_line_height = "140%";
    disable_ligatures = "cursor"; # disable ligatures when cursor is on them

    # Window layout
    hide_window_decorations = "titlebar-only";
    window_padding_width = "10";

    # Tab bar
    tab_bar_edge = "top";
    tab_bar_style = "powerline";
    tab_title_template = "Tab {index}: {title}";
    active_tab_font_style = "bold";
    inactive_tab_font_style = "normal";
    tab_activity_symbol = "";
  };

  # Change the style of italic font variants
  programs.kitty.extraConfig = ''
    font_features PragmataProMonoLiga-Italic +ss06
    font_features PragmataProMonoLiga-BoldItalic +ss07
  '';

  programs.kitty.extras.useSymbolsFromNerdFont = "JetBrainsMono Nerd Font";
  # }}}

  # Colors config ------------------------------------------------------------------------------ {{{
  # programs.fish.functions.set-term-colors = {
  #   body = "term-background $term_background";
  #   onVariable = "term_background";
  # };
  programs.fish.interactiveShellInit = ''
    # Set term colors based on value of `$term_backdround` when shell starts up.
    # set-term-colors
  '';
  programs.kitty.keybindings = {
    "kitty_mod+t" = "new_tab_with_cwd";
    "kitty_mod+enter" = "new_window_with_cwd";
    "cmd+t" = "new_tab_with_cwd";
    "cmd+enter" = "new_window_with_cwd";
    "cmd+k" =
      "combine : clear_terminal scrollback active : send_text normal x0c";
    "ctrl+f" =
      "launch --type=overlay --stdin-source=@screen_scrollback fzf --no-sort --no-mouse --exact -i";
    "cmd+f" =
      "launch --type=overlay --stdin-source=@screen_scrollback fzf --no-sort --no-mouse --exact -i";
  };
  # }}}
}
# vim: foldmethod=marker
