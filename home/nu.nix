
{ config, lib, pkgs, ... }:
let
  inherit (lib) elem optionalString;
  inherit (config.home.user-info) nixConfigDirectory;
in
{ 
  programs.nushell = {
    enable = true;
  };
}
