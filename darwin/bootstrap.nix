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
    extra-platforms = lib.mkIf (pkgs.stdenv.hostPlatform.system == "aarch64-darwin") [ "x86_64-darwin" "aarch64-darwin" ];
  };

  # Add shells installed by nix to /etc/shells file
  environment.shells = with pkgs; [
    bashInteractive
    fish
    zsh
  ];

  # Fish shell configuration
  programs.fish.enable = true;
  programs.fish.useBabelfish = true;
  programs.fish.babelfishPackage = pkgs.babelfish;

  # User-local tool paths (uses config option instead of impure builtins.getEnv)
  environment.systemPath = lib.mkIf (config ? users && config.users ? primaryUser && config.users.primaryUser.username != null) [
    "/Users/${config.users.primaryUser.username}/.local/bin"
  ];

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
