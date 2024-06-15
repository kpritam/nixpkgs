#!/usr/bin/env bash

nix flake update

nix build .#darwinConfigurations.MacBookPro.system

./result/sw/bin/darwin-rebuild switch --flake .#MacBookPro

brew upgrade
