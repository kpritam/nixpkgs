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
    "google-chrome"
    "arc"
    "tuple"
    "fork"
    "insomnia"
    "jetbrains-toolbox"
    "karabiner-elements"
    "orbstack"
    "spotify"
    "stats"
    "zoom"
    "dbeaver-community"
    "sf-symbols"
    "discord"
    "visual-studio-code@insiders"
    "zed@preview"
    "hiddenbar"
    "font-iosevka"
    "font-input"
    "ghostty"
  ];

  # Configuration related to casks
  environment.variables.SSH_AUTH_SOCK = mkIfCaskPresent "secretive"
    "/Users/${config.users.primaryUser.username}/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh";

  # For cli packages that aren't currently available for macOS in `nixpkgs`.Packages should be
  # installed in `../home/default.nix` whenever possible.
  homebrew.brews = [
    "angular-cli"
    "asdf"
    "aspell"
    "awscli"
    "colima" # docker desktop alternative
    "coursier/formulas/coursier"
    "docker-compose"
    "go"
    "neovim"
    "node"
    "skhd" # keybinding manager
    "yabai" # tiling window manager
    "borders"
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
    "derailed/k9s/k9s"
    "lua"
  ];
}
