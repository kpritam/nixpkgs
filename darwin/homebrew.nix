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
  homebrew.autoUpdate = true;
  homebrew.cleanup = "zap";
  homebrew.global.brewfile = true;
  homebrew.global.noLock = true;

  homebrew.taps = [
    "homebrew/cask"
    "homebrew/cask-drivers"
    "homebrew/cask-fonts"
    "homebrew/cask-versions"
    "homebrew/core"
    "homebrew/services"
    "AdoptOpenJDK/openjdk"
    "koekeishiya/formulae"
    "coursier/formulas"
    "d12frosted/emacs-plus"
  ];
  
  homebrew.extraConfig = ''
    brew "emacs-plus@28", args:["with-xwidgets", "with-native-compe", "with-modern-purple-flat-icon", "with-no-titlebar"]
  '';

  # Prefer installing application from the Mac App Store
  #
  # Commented apps suffer continual update issue:
  # https://github.com/malob/nixpkgs/issues/9
  homebrew.masApps = {
    # "1Blocker" = 1365531024;
    # "1Password" = 1333542190;
    # "Accelerate for Safari" = 1459809092;
    # "Apple Configurator 2" = 1037126344;
    # DaisyDisk = 411643860;
    # "Dark Mode for Safari" = 1397180934;
    # Deliveries = 290986013;
    # Fantastical = 975937182;
    # "Gemini 2" = 1090488118;
    # "iMazing Profile Editor" = 1487860882;
    # Keynote = 409183694;
    # "LG Screen Manager" = 1142051783;
    # MindNode = 1289197285;
    # Numbers = 409203825;
    # Pages = 409201541;
    # Patterns = 429449079;
    # "Pixelmator Classic" = 407963104;
    # "Pixelmator Pro" = 1289583905;
    # "Save to Raindrop.io" = 1549370672;
    # Slack = 803453959;
    # SiteSucker = 442168834;
    # "Things 3" = 904280696;
    # TripMode = 1513400665;
    # Ulysses = 1225570693;
    # Vimari = 1480933944;
    # "WiFi Explorer" = 494803304;
    # Xcode = 497799835;
    # "Yubico Authenticator" = 1497506650;
  };

  # If an app isn't available in the Mac App Store, or the version in the App Store has
  # limitiations, e.g., Transmit, install the Homebrew Cask.
  homebrew.casks = [
    "firefox"
    "google-chrome"
    "google-drive"
    "gpg-suite"
    "hammerspoon"
    "keybase"
    "raycast"
    "vlc"
    "yubico-yubikey-manager"
    "yubico-yubikey-personalization-gui"

    "adoptopenjdk11"
    "brave-browser-beta"
    "caffeine"
    "docker"
    "evernote"
    "flycut"
    # Fonts
    "font-iosevka-nerd-font"
    "font-iosevka"
    "font-iosevka-aile"
    "font-iosevka-curly-slab"
    "font-juliamono"
    "font-jetbrains-mono-nerd-font"
    "font-jetbrains-mono"
    "font-hack-nerd-font"

    "fork"
    "iterm2"
    "jetbrains-toolbox"
    "karabiner-elements"
    "kitty"
    "slack"
    "spotify"
    "stats"
    "telegram"
    "virtualbox"
    "virtualbox-extension-pack"
    "whatsapp"
    "zoom"
    "miniconda"
    "yubico-yubikey-manager"
    "yubico-yubikey-personalization-gui"
    "miro"
  ];

  # Configuration related to casks
  environment.variables.SSH_AUTH_SOCK = mkIfCaskPresent "secretive"
    "/Users/${config.users.primaryUser.username}/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh";

  # For cli packages that aren't currently available for macOS in `nixpkgs`.Packages should be
  # installed in `../home/default.nix` whenever possible.
  homebrew.brews = [
    "swift-format"
    "swiftlint"
    "coursier"
    "go"
    "luajit" # brew install --HEAD luajit
    "neovim" # brew install --HEAD neovim
    "ninja"
    "node"
    "postgres"
    "sbt"
    "skhd"
    "yabai"
    "coreutils"
    # k8s
    "kubernetes-cli"
    "istioctl"
    "k3d"
    "kubie"
    "kustomize"
    "leapp"
    "pinentry-mac"
    "cockroachdb/tap/cockroach"
    "ngrok"
  ];
}
