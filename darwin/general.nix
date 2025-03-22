{ pkgs, ... }:

{
  # Networking
  networking.dns = [
    "1.1.1.1"
    "8.8.8.8"
  ];

  programs.nix-index.enable = true;

  # Fonts
  fonts.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      nerd-fonts.hack
      nerd-fonts.fira-code
      nerd-fonts.fira-mono
      nerd-fonts.inconsolata
      nerd-fonts.sauce-code-pro
      nerd-fonts.ubuntu-mono
   ];

  # Keyboard
  system.keyboard.enableKeyMapping = true;

  # Add ability to used TouchID for sudo authentication
  security.pam.services.sudo_local.touchIdAuth = true;
}
