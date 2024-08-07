{ pkgs, ... }:

{
  # Networking
  networking.dns = [
    "1.1.1.1"
    "8.8.8.8"
  ];

  # Apps
  # `home-manager` currently has issues adding them to `~/Applications`
  # Issue: https://github.com/nix-community/home-manager/issues/1341
  environment.systemPackages = with pkgs; [
    # kitty
    terminal-notifier
  ];
  programs.nix-index.enable = true;

  # Fonts
  fonts.packages = with pkgs; [
    recursive
    (nerdfonts.override { 
      fonts = [ 
        "JetBrainsMono"
        "Hack"
        "FiraCode"
        "FiraMono"
        "Inconsolata"
        "SourceCodePro"
        "UbuntuMono"
      ]; 
    })
   ];

  # Keyboard
  system.keyboard.enableKeyMapping = true;

  # Add ability to used TouchID for sudo authentication
  security.pam.enableSudoTouchIdAuth = true;
}
