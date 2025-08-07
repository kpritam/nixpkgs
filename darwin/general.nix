{ config, pkgs, lib, ... }:

{
  # Network configuration - Use fast and private DNS
  networking.dns = [
    "1.1.1.1"    # Cloudflare DNS (primary)
    "1.0.0.1"    # Cloudflare DNS (secondary)
    "8.8.8.8"    # Google DNS (fallback)
    "8.8.4.4"    # Google DNS (fallback)
  ];

  # Nix-index for better package discovery  
  programs.nix-index.enable = true;

  # Font packages - Programming and UI fonts
  fonts.packages = with pkgs; [
    # Programming fonts with good ligature support
    nerd-fonts.jetbrains-mono    # Excellent for coding
    nerd-fonts.fira-code         # Popular ligature font
    nerd-fonts.fira-mono         # Monospace variant
    nerd-fonts.hack              # Clear and readable
    nerd-fonts.inconsolata       # Classic programming font
    nerd-fonts.sauce-code-pro    # Source Code Pro variant
    nerd-fonts.ubuntu-mono       # Ubuntu's monospace font
  ];

  # System keyboard configuration
  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToEscape = lib.mkDefault false; # Can be overridden per user

  # Security: Enable TouchID for sudo authentication
  security.pam.services.sudo_local.touchIdAuth = true;
}
