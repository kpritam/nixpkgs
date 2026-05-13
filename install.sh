#!/usr/bin/env bash
set -euo pipefail

nix flake update

nix build .#darwinConfigurations.MacBookPro.system

sudo ./result/sw/bin/darwin-rebuild switch --flake .#MacBookPro

brew upgrade
