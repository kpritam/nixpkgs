{ lib, pkgs, ... }:
{
  # Kitty terminal
  # https://sw.kovidgoyal.net/kitty/conf.html
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.kitty.enable
  programs.kitty.enable = true;

  programs.kitty.themeFile = "gruvbox_dark";

  programs.kitty.settings = {
    font_family = "Input Mono Narrow";
    bold_font = "Input Mono Narrow";
    italic_font = "JetBrains Mono Italic";
    bold_italic_font = "JetBrains Mono Italic";
    font_size = "14.0";
    adjust_line_height = "100%";
    # symbol_map = " U+E0A0-U+E0A3,U+E0C0-U+E0C7 PowerlineSymbols";
    disable_ligatures = "cursor"; # disable ligatures when cursor is on them
    cursor_shape = "block";

    macos_option_as_alt = "yes";
    # Window layout
    hide_window_decorations = "titlebar-only";
    scrollback_lines = "200000";
    window_padding_width = "10";
    kitty_mod = "cmd";

    # Tab bar
    tab_bar_edge = "top";
    tab_bar_style = "powerline";
    tab_title_template = "{index}: {title[title.rfind('/')+1:]}";
    active_tab_font_style = "bold";
    inactive_tab_font_style = "normal";
    tab_activity_symbol = "";
  };

  programs.kitty.keybindings = {
    "kitty_mod+t" = "new_tab_with_cwd";
    "kitty_mod+enter" = "new_window_with_cwd";
    "cmd+t" = "new_tab_with_cwd";
    "cmd+enter" = "new_window_with_cwd";
    "cmd+k" =
      "combine : clear_terminal scrollback active : send_text normal x0c";
    "ctrl+f" =
      "launch --type=overlay --stdin-source=@screen_scrollback ${pkgs.fzf} --no-sort --no-mouse --exact -i";
    "cmd+f" =
      "launch --type=overlay --stdin-source=@screen_scrollback ${pkgs.fzf} --no-sort --no-mouse --exact -i";
  };
}
