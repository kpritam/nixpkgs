# Legacy compatibility layer for non-flake Nix usage
# This enables the use of this flake-based configuration with traditional Nix commands
# See https://nixos.wiki/wiki/Flakes#Using_flakes_project_from_a_legacy_Nix
#
# For modern usage, prefer flake commands:
#   nix build .#darwinConfigurations.MacBookPro.system
#   darwin-rebuild switch --flake .
(import (
  let
    lock = builtins.fromJSON (builtins.readFile ./flake.lock);
  in fetchTarball {
    url = "https://github.com/edolstra/flake-compat/archive/${lock.nodes.flake-compat.locked.rev}.tar.gz";
    sha256 = lock.nodes.flake-compat.locked.narHash; 
  }
) {
  src = ./.;
}).defaultNix
