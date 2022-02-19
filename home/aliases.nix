{ config, pkgs, ... }:
let
  inherit (config.home.user-info) nixConfigDirectory;
in
{
  drb = "darwin-rebuild build --flake ${nixConfigDirectory}";
  drs = "darwin-rebuild switch --flake ${nixConfigDirectory}";
  flakeup = "nix flake update ${nixConfigDirectory}";
  nb = "nix build";
  nd = "nix develop";
  nf = "nix flake";
  nr = "nix run";
  ns = "nix search";
  garbage = "nix-collect-garbage -d && docker image prune --force"; # Nix garbage collection
  # See which Nix packages are installed
  installed = "nix-env --query --installed";

  # Aliases for commonly used tools
  grep = "grep --color=auto";
  cloc = "tokei";
  dk = "docker";
  k = "kubectl";
  dc = "docker-compose";
  find = "fd";
  mk = "minikube";
  du   = "ncdu --color dark -rr -x";

  v = "lvim";
  vi = "nvim";
  vim = "nvim";


  ".." = "cd ..";
  l = "${pkgs.exa}/bin/exa -lahG";
  ls = "${pkgs.colorls}/bin/colorls";
  lst = "${pkgs.colorls}/bin/colorls --tree";
  la = "${pkgs.colorls}/bin/colorls -lah";
  md = "mkdir -p";
  cx = "chmod +x";
  cat = "${pkgs.bat}/bin/bat";
  #  Jump to projects
  D = "cd ~/Downloads";
  p = "cd ~/projects";
  my = "cd ~/projects/kpritam";
  #  git
  root = "cd (${pkgs.gitAndTools.git}/bin/git rev-parse --show-cdup)";
  gpom = "${pkgs.gitAndTools.git}/bin/git push origin master";
  gpr = "${pkgs.gitAndTools.git}/bin/git pull --rebase";
  g = "${pkgs.gitAndTools.git}/bin/git";
  r = "${pkgs.ranger}/bin/ranger";

  c = "code-insiders";

  localip = "ipconfig getifaddr en0";
  ps = "${pkgs.procs}/bin/procs";
  tb = "toggle-background";
}
