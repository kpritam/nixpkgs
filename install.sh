#!/usr/bin/env bash

nix flake update

nix build .#darwinConfigurations.MacBookPro.system

./result/sw/bin/darwin-rebuild switch --flake .#MacBookPro

echo "Upgrading stackline ..."
cd ~/.hammerspoon/stackline && git pull

echo "Upgrading npm packages ..."
npm update -y

