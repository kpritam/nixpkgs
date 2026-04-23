#!/usr/bin/env bash
set -euo pipefail

nix flake update

nix build .#darwinConfigurations.MacBookPro.system --no-warn-dirty

sudo ./result/sw/bin/darwin-rebuild switch --flake .#MacBookPro --no-warn-dirty

brew upgrade
