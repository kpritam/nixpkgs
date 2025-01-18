{ config, pkgs, lib, ... }: {
  home.file.yabai = {
    executable = true;
    target = ".config/yabai/yabairc";
    text = ''
      #!/usr/bin/env sh
      yabai -m signal --add event=dock_did_restart action="sudo yabai --load-sa"
      sudo yabai --load-sa
      
      # global settings
      yabai -m config                              \
          external_bar                all:30:0     \
          mouse_follows_focus         on           \
          focus_follows_mouse         autoraise    \
          window_placement            second_child \
          window_topmost              off          \
          window_shadow               off          \
          window_animation_duration   0.25         \
          window_opacity_duration     0.25         \
          active_window_opacity       0.95         \
          normal_window_opacity       0.85         \
          window_opacity              on           \
          insert_feedback_color       0xaad75f5f   \
          active_window_border_color  0xBF775759   \
          normal_window_border_color  0x7f353535   \
          window_border_width         4            \
          window_border_radius        12           \
          window_border_blur          on           \
          window_border_hidpi         on           \
          window_border               on           \
          split_ratio                 0.50         \
          split_type                  auto         \
          auto_balance                off          \
          top_padding                 10           \
          left_padding                10           \
          right_padding               10           \
          bottom_padding              10           \
          window_gap                  10           \
          layout                      bsp          \
          mouse_modifier              fn           \
          mouse_action1               move         \
          mouse_action2               resize       \
          mouse_drop_action           swap
      
      # Space labels
      yabai -m space 1 --label 1
      yabai -m space 2 --label 2
      yabai -m space 3 --label 3
      yabai -m space 4 --label 4
      yabai -m space 5 --label 5
      yabai -m space 6 --label 6
      yabai -m space 7 --label 7
      yabai -m space 8 --label 8
      yabai -m space 9 --label 9
      
      # Unmanaged
      yabai -m rule --add label="1Password 7" app="^1Password 7$" manage=off
      yabai -m rule --add label="Microsoft Excel" app="^Microsoft Excel$" manage=off
      yabai -m rule --add label="VLC" app="^VLC$" manage=off
      yabai -m rule --add app="^Docker Desktop$" manage=off
      yabai -m rule --add label="Activity Monitor" app="^Activity Monitor$" manage=off
      yabai -m rule --add label="Calculator" app="^Calculator$" manage=off
      yabai -m rule --add label="Finder" app="^Finder$" title="(Co(py|nnect)|Move|Info|Pref)" manage=off
      yabai -m rule --add label="Preview" app="Preview" manage=off
      yabai -m rule --add label="Stickies" app="Stickies" manage=off
      yabai -m rule --add app="^System Settings$" manage=off
      yabai -m rule --add app="^JetBrains Toolbox$" sticky=on layer=above manage=off
      yabai -m rule --add app="^IntelliJ IDEA-EAP$" title="Preferences" sticky=on layer=above manage=off
      yabai -m rule --add app="^IntelliJ IDEA$" title="Preferences" sticky=on layer=above manage=off
      yabai -m rule --add app="^IntelliJ IDEA$" title="Settings" sticky=on layer=above manage=off
      yabai -m rule --add app="Stats" sticky=on layer=above manage=off
      
      # Browser
      yabai -m rule --add app="^Brave Browser Beta$" space=^1
      
      # Dev
      yabai -m rule --add app="^kitty$" space=^2
      yabai -m rule --add app="^IntelliJ IDEA-EAP$" space=^3
      yabai -m rule --add app="^IntelliJ IDEA$" space=^3
      yabai -m rule --add app="^GoLand$" space=^3
      yabai -m rule --add app="^GoLand-EAP$" space=^3
      yabai -m rule --add app="^Code - Insiders$" space=^3
      yabai -m rule --add app="^Emacs$" space=^4
      
      yabai -m rule --add app="^Fork$" space=^5
      
      # Communication
      yabai -m rule --add app="^Slack$" space=^6
      
      # Social
      yabai -m rule --add app="^Discord$" space=^7
      yabai -m rule --add app="^WhatsApp$" space=^7
      yabai -m rule --add app="^Telegram$" space=^7
      
      # Media
      yabai -m rule --add app="^Music$" space=^8
      yabai -m rule --add app="^QuickTime Player$" space=^8
      yabai -m rule --add app="^VLC$" space=^8
      yabai -m rule --add app="^Spotify$" space=^8
      yabai -m rule --add app="^Firefox$" space=^8
      
      # Misc
      yabai -m rule --add app="^Finder$" space=^9
      yabai -m rule --add app="^Microsoft Word$" space=^9
      yabai -m rule --add app="^Microsoft Outlook$" space=^9
      
      # signals
      yabai -m signal --add event=window_destroyed action="yabai -m query --windows --window &> /dev/null || yabai -m window --focus mouse"
      yabai -m signal --add event=application_terminated action="yabai -m query --windows --window &> /dev/null || yabai -m window --focus mouse"
      
      # Sketchybar
      yabai -m signal --add event=window_focused action="sketchybar --trigger window_focus"
      yabai -m signal --add event=window_created action="sketchybar --trigger windows_on_spaces"
      yabai -m signal --add event=window_destroyed action="sketchybar --trigger windows_on_spaces"
      
      echo "yabai configuration loaded.."
      # borders active_color=0xffe1e3e4 inactive_color=0xff494d64 width=5.0 &
    '';
  };

  home.file.skhd = {
    target = ".config/skhd/skhdrc";
    text = ''
      ## Quickly restart the yabai launch agent
      ctrl + alt + cmd - r : yabai --restart-service
      
      ##############################################
      # Navigation (focussing)
      ##############################################
      
      # Windows Focus
      hyper - up    : yabai -m window --focus north
      hyper - down  : yabai -m window --focus south
      hyper - right : yabai -m window --focus east
      hyper - left  : yabai -m window --focus west
      
      # Spaces:  Alt + [NUM]
      alt - 1 : yabai -m space --focus 1
      alt - 2 : yabai -m space --focus 2
      alt - 3 : yabai -m space --focus 3
      alt - 4 : yabai -m space --focus 4
      alt - 5 : yabai -m space --focus 5
      alt - 6 : yabai -m space --focus 6
      alt - 7 : yabai -m space --focus 7
      alt - 8 : yabai -m space --focus 8
      alt - 9 : yabai -m space --focus 9
      
      # Monitors: Ctrl + Alt + [NUM]
      hyper - n  : yabai -m display --focus 1
      hyper - m  : yabai -m display --focus 2
      
      ##############################################
      # Moving
      ##############################################
      
      # "Swaps" with another Window, obtaining its size and position
      # Swap: Ctrl + Alt + [DIR]
      hyper - h : yabai -m window --swap west
      hyper - l : yabai -m window --swap east
      hyper - k : yabai -m window --swap north
      hyper - j : yabai -m window --swap south
      
      # Sends Window to Space and shifts focus
      # Send: Shift + Cmd + [NUM]
      shift + cmd - 1 : yabai -m window --space  1; yabai -m space --focus 1 && sketchybar --trigger windows_on_spaces
      shift + cmd - 2 : yabai -m window --space  2; yabai -m space --focus 2 && sketchybar --trigger windows_on_spaces
      shift + cmd - 3 : yabai -m window --space  3; yabai -m space --focus 3 && sketchybar --trigger windows_on_spaces
      shift + cmd - 4 : yabai -m window --space  4; yabai -m space --focus 4 && sketchybar --trigger windows_on_spaces
      shift + cmd - 5 : yabai -m window --space  5; yabai -m space --focus 5 && sketchybar --trigger windows_on_spaces
      shift + cmd - 6 : yabai -m window --space  6; yabai -m space --focus 6 && sketchybar --trigger windows_on_spaces
      shift + cmd - 7 : yabai -m window --space  7; yabai -m space --focus 7 && sketchybar --trigger windows_on_spaces
      shift + cmd - 8 : yabai -m window --space  8; yabai -m space --focus 8 && sketchybar --trigger windows_on_spaces
      shift + cmd - 9 : yabai -m window --space  9; yabai -m space --focus 9 && sketchybar --trigger windows_on_spaces
      
      # Sends Window to Monitor and shifts focus
      # Send Monitor: Ctrl + Cmd + [NUM]
      hyper - 1 : yabai -m window --display 1; yabai -m display --focus 1
      hyper - 2 : yabai -m window --display 2; yabai -m display --focus 2
      
      # Floating Move
      ctrl + alt - h : yabai -m window --move rel:-20:0
      ctrl + alt - j : yabai -m window --move rel:0:20
      ctrl + alt - k : yabai -m window --move rel:0:-20
      ctrl + alt - l : yabai -m window --move rel:20:0
      
      # Rotate
      alt - r : yabai -m space --rotate 90
      
      # toggle window split type
      hyper - e : yabai -m window --toggle split
      
      # toggle sticky (show on all spaces)
      hyper - s : yabai -m window --toggle sticky
      
      # toggle topmost (keep above other windows)
      hyper - o : yabai -m window --toggle topmost
      
      # toggle picture-in-picture
      hyper - p : yabai -m window --toggle border && \
                yabai -m window --toggle pip
      
      # Auto
      shift + alt - 0 : yabai -m space --balance
      
      # Increase (no decrease options, just resizing the relevant windows)
      # === Resize Mode ===
      # Set resize border color 
      :: resize @ : yabai -m config active_window_border_color 0xFFFF00FF
      # toggle resize mode 
      resize < hyper - r ; default
      default < hyper - r ; resize
      # resize commands
      resize < left : yabai -m window --resize left:-50:0; \
                        yabai -m window --resize right:-50:0
      resize < down : yabai -m window --resize bottom:0:50; \
                        yabai -m window --resize top:0:50
      resize < up   : yabai -m window --resize top:0:-50; \
                        yabai -m window --resize bottom:0:-50
      resize < right : yabai -m window --resize right:50:0; \
                        yabai -m window --resize left:50:0
      
      ##############################################
      # Toggling
      ##############################################
      
      # Fullscreen (still includes gaps)
      hyper - f : yabai -m window --toggle zoom-fullscreen;  sketchybar --trigger window_focus
      
      # toggle window parent zoom
      hyper - d : yabai -m window --toggle zoom-parent; sketchybar --trigger window_focus
      
      # Float and center
      hyper - t : yabai -m window --toggle float;\
                yabai -m window --grid 4:4:1:1:2:2; sketchybar --trigger window_focus
      
      # mirror tree y-axis
      hyper - y : yabai -m space --mirror y-axis
      
      # mirror tree x-axis
      hyper - x : yabai -m space --mirror x-axis
      
      # toggle desktop offset
      hyper - a : yabai -m space --toggle padding && yabai -m space --toggle gap
      
      # create desktop, move window and follow focus - uses jq for parsing json (brew install jq)
      shift + cmd - n : yabai -m space --create && \
                        set index (yabai -m query --spaces --display | jq 'map(select(."native-fullscreen" == 0))[-1].index') && \
                        yabai -m window --space $index && \
                        yabai -m space --focus $index
      
      # create desktop and follow focus - uses jq for parsing json (brew install jq)
      cmd + ctrl - n : yabai -m space --create && \
                      set index (yabai -m query --spaces --display | jq 'map(select(."native-fullscreen" == 0))[-1].index') && \
                      yabai -m space --focus $index
      
      # destroy desktop
      cmd + alt - w : yabai -m space --destroy
      
      ##############################################
      # Stacking
      ##############################################
      # if this doesn't work, try using the absolute path to the hammerspoon cli: /usr/local/bin/hs
      alt - t :  hs -c 'stackline.config:toggle("appearance.showIcons")'
      ctrl + alt - down : yabai -m window --stack south
      ctrl + alt - up : yabai -m window --stack north
      ctrl + alt - left : yabai -m window --stack west
      ctrl + alt - right : yabai -m window --stack east
      
      # change layout of desktop
      ctrl + alt - a : yabai -m space --layout bsp
      ctrl + alt - d : yabai -m space --layout float
      ctrl + alt - s : yabai -m space --layout $(yabai -m query --spaces --space | jq -r 'if .type == "bsp" then "float" else "bsp" end')
      
      lalt - f : yabai -m window --toggle float; sketchybar --trigger window_focus
    '';
  };
}
