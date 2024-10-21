{ config, lib, pkgs, ... }:

{
  nix.settings = {
    substituters = [
      "https://cache.nixos.org/"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];

    trusted-users = [ "@admin" ];

    auto-optimise-store = false;

    experimental-features = [
      "nix-command"
      "flakes"
    ];

    extra-platforms = lib.mkIf (pkgs.system == "aarch64-darwin") [ "x86_64-darwin" "aarch64-darwin" ];
  };

  # https://github.com/LnL7/nix-darwin/issues/970
  # nix.configureBuildUsers = true;

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # Add shells installed by nix to /etc/shells file
  environment.shells = with pkgs; [
    bashInteractive
    fish
    zsh
  ];

  # Make Fish the default shell
  programs.fish.enable = true;
  programs.fish.useBabelfish = true;
  programs.fish.babelfishPackage = pkgs.babelfish;

  # Lunarvim installs its binary at ~/.local/bin
  environment.systemPath = [ 
    "${builtins.getEnv "HOME"}/.local/bin"
    "${builtins.getEnv "HOME"}/Library/Application\\ Support/Coursier/bin"
  ];

  # Needed to address bug where $PATH is not properly set for fish:
  # https://github.com/LnL7/nix-darwin/issues/122
  programs.fish.shellInit = ''
    for p in (string split : ${config.environment.systemPath})
      if not contains $p $fish_user_paths
        set -g fish_user_paths $fish_user_paths "$p"
      end
    end
  '';

  programs.tmux = {
    enable = true;
    enableFzf = true;
    enableMouse = true;
    enableVim = true;
  };

  environment.variables.SHELL = "${pkgs.fish}/bin/fish";

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
