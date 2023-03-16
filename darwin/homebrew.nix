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
    "homebrew/cask"
    "homebrew/cask-fonts"
    "homebrew/cask-versions"
    "homebrew/core"
    "homebrew/services"
    "AdoptOpenJDK/openjdk"
    "koekeishiya/formulae"
    "coursier/formulas"
    "d12frosted/emacs-plus"
    "FelixKratz/formulae"
    "r-lib/rig"
    "FelixKratz/formulae"
  ];

  homebrew.extraConfig = ''
    brew "emacs-plus@30", args:["with-xwidgets", "with-native-comp", "with-modern-purple-flat-icon", "with-imagemagick"]
  '';

  # If an app isn't available in the Mac App Store, or the version in the App Store has
  # limitiations, e.g., Transmit, install the Homebrew Cask.
  homebrew.casks = [
    "1password"
    "gpg-suite"
    "hammerspoon"
    "raycast"
    "vlc"
    "caffeine"
    "docker"
    "flycut"
    "font-jetbrains-mono-nerd-font"
    "font-jetbrains-mono"
    "font-hack-nerd-font"
    "font-iosevka-curly-slab"
    "font-iosevka-aile"
    "font-fira-code"
    "font-hasklug-nerd-font"

    "fork"
    "insomnia"
    "jetbrains-toolbox"
    "karabiner-elements"
    "kitty"
    "orbstack"
    "slack"
    "spotify"
    "stats"
    "zoom"
    "miniconda"
    "miro"
    "dbeaver-community"
    "sf-symbols"
    "microsoft-teams"
    "discord"
    "visual-studio-code-insiders"
    # R Deps
    "rig"
    "xquartz"
    "rstudio"
  ];

  # Configuration related to casks
  environment.variables.SSH_AUTH_SOCK = mkIfCaskPresent "secretive"
    "/Users/${config.users.primaryUser.username}/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh";

  # For cli packages that aren't currently available for macOS in `nixpkgs`.Packages should be
  # installed in `../home/default.nix` whenever possible.
  homebrew.brews = [
    "angular-cli"
    "aspell"
    "awscli"
    "coursier"
    "go"
    "neovim"
    "node"
    "rg"
    "skhd"
    "yabai"
    "tmux"
    # k8s
    "kubernetes-cli"
    "kubie"
    "pinentry-mac"
    "sketchybar"
    "nvm"
    "yarn"
    "unixodbc"
    "shfmt"
    "shellcheck"
    "editorconfig"
    "cmake"
    "borders"
  ];
}
