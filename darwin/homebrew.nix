{ config, lib, ... }:

let
  inherit (lib) mkIf;
  mkIfCaskPresent = cask: mkIf (lib.any (x: x == cask) config.homebrew.casks);
  brewEnabled = config.homebrew.enable;
in

{
  environment.shellInit = mkIf brewEnabled ''
    eval "$(${config.homebrew.brewPrefix}/brew shellenv)"
  '';

  # https://docs.brew.sh/Shell-Completion#configuring-completions-in-fish
  # For some reason if the Fish completions are added at the end of `fish_complete_path` they don't
  # seem to work, but they do work if added at the start.
  programs.fish.interactiveShellInit = mkIf brewEnabled ''
    if test -d (brew --prefix)"/share/fish/completions"
      set -p fish_complete_path (brew --prefix)/share/fish/completions
    end

    if test -d (brew --prefix)"/share/fish/vendor_completions.d"
      set -p fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
    end
  '';

  homebrew.enable = true;
  homebrew.onActivation.autoUpdate = true;
  homebrew.onActivation.cleanup = "zap";
  homebrew.global.brewfile = true;

  homebrew.taps = [
    "coursier/formulas"
    "homebrew/cask-fonts"
    "homebrew/cask-versions"
    "homebrew/services"
    "koekeishiya/formulae"
    "FelixKratz/formulae"
    "derailed/k9s"
  ];

  # Applications not available in Mac App Store or with limitations
  homebrew.casks = [
    # Security & Password Management
    "1password"
    "gpg-suite"
    
    # System Utilities
    "hammerspoon"        # Window management and automation
    "raycast"           # Better Spotlight alternative
    "caffeine"          # Prevent sleep
    "flycut"            # Clipboard manager
    "hiddenbar"         # Hide menu bar items
    "stats"             # System monitoring
    "karabiner-elements" # Keyboard customization
    
    # Development Tools
    "jetbrains-toolbox" # JetBrains IDE manager
    "visual-studio-code@insiders" # VS Code Insiders
    "visual-studio-code"
    "zed@preview"       # Modern editor
    "fork"              # Git client
    "insomnia"          # API testing
    "orbstack"          # Docker alternative
    "dbeaver-enterprise" # Database tool
    "sf-symbols"        # Apple's SF Symbols
    "ghostty"           # Terminal emulator
    "figma"
    
    # Browsers
    "google-chrome"
    "arc"               # Modern browser
    
    # Media & Communication
    "vlc"               # Video player
    "spotify"           # Music streaming
    "discord"           # Communication
    "zoom"              # Video conferencing
    "tuple"             # Pair programming
    
    # Fonts
    "font-iosevka"      # Programming font
    "font-input"        # Programming font
    
    # AI/ML Tools
    "lm-studio"         # Local LLM runner
  ];

  # Configuration related to casks
  environment.variables.SSH_AUTH_SOCK = mkIfCaskPresent "secretive"
    "/Users/${config.users.primaryUser.username}/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh";

  # CLI packages not available or newer in nixpkgs
  # Prefer nixpkgs when possible for reproducibility
  homebrew.brews = [
    # Development Languages & Runtimes
    "go"                # Go programming language
    "node"              # Node.js runtime
    "lua"               # Lua scripting language
    "rustup"            # Rust toolchain installer
    "uv"                # Fast Python package installer
    
    # Development Tools
    "neovim"            # Text editor
    "angular-cli"       # Angular development
    "coursier/formulas/coursier" # Scala build tool
    "cmake"             # Build system
    "editorconfig"      # Editor configuration
    "ast-grep"          # Code search and transformation
    
    # Version Managers
    "asdf"              # Multi-language version manager
    "nvm"               # Node.js version manager
    
    # Package Managers & Build Tools
    "yarn"              # JavaScript package manager
    
    # System & Shell Tools
    "tmux"              # Terminal multiplexer
    "skhd"              # Keybinding manager for yabai
    "yabai"             # Tiling window manager
    "borders"           # Window borders for yabai
    "sketchybar"        # Custom menu bar
    
    # Container & Cloud Tools
    "colima"            # Docker Desktop alternative
    "docker-compose"    # Container orchestration
    "awscli"            # AWS command line
    
    # Kubernetes Tools
    "kubernetes-cli"    # kubectl
    "kubie"             # Kubernetes context switcher
    "derailed/k9s/k9s" # Kubernetes TUI
    
    # Code Quality & Formatting
    "shfmt"             # Shell formatter
    "shellcheck"        # Shell script linter
    
    # Security & GPG
    "pinentry-mac"      # GPG PIN entry for macOS
    
    # Language Support
    "aspell"            # Spell checker
    "unixodbc"          # Database connectivity

    # AI/ML Tools
    "sst/tap/opencode"
    "lazygit"
  ];
}
