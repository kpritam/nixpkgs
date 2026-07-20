#!/usr/bin/env bash
set -euo pipefail

nix flake update

nix build .#darwinConfigurations.MacBookPro.system

sudo ./result/sw/bin/darwin-rebuild switch --flake .#MacBookPro

# Auto-updating casks (Chrome, Raycast, Stats, ...) self-update outside brew's
# tracking, so `brew upgrade` trying to re-upgrade them hits "already an App at
# ..." errors. Skip them here; they keep themselves current anyway.
HOMEBREW_NO_UPGRADE_AUTO_UPDATES_CASKS=1 brew upgrade
