# This is a flake-based configuration. Use flake commands:
#
#   darwin-rebuild switch --flake .#MacBookPro
#   nix build .#darwinConfigurations.MacBookPro.system
#   nix flake update
#
# Legacy (non-flake) Nix commands are not supported.
throw "This is a flake-based configuration. Use: darwin-rebuild switch --flake .#MacBookPro"
