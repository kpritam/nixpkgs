{ config, lib, pkgs, ... }:

let
  inherit (lib) elem optionalString;
  inherit (config.home.user-info) nixConfigDirectory;
in

{
  # Fish Shell
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.fish.enable
  programs.fish.enable = true;

  # Add Fish plugins
  home.packages = [ pkgs.fishPlugins.done ];

  # Aliases
  programs.fish.shellAliases = with pkgs; {
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
    du = "ncdu --color dark -rr -x";

    v = "lvim";
    vi = "nvim";
    vim = "nvim";


    ".." = "cd ..";
    l = "${pkgs.eza}/bin/eza -lahG";
    ls = "${pkgs.eza}/bin/eza";
    lst = "${pkgs.eza}/bin/eza -T";
    la = "${pkgs.eza}/bin/eza -lah";
    ll = "${pkgs.eza}/bin/eza -l -g --icons";
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

    R = "radian";
    localip = "ipconfig getifaddr en0";
    tb = "toggle-background";
  };

  # Configuration that should be above `loginShellInit` and `interactiveShellInit`.
  programs.fish.shellInit = ''
    set -U fish_term24bit 1
  '';

  programs.fish.interactiveShellInit = ''
    set -g fish_greeting ""
    ${pkgs.thefuck}/bin/thefuck --alias | source

    # Set Fish colors that aren't dependant the `$term_background`.
    set -g fish_color_quote        cyan      # color of commands
    set -g fish_color_redirection  brmagenta # color of IO redirections
    set -g fish_color_end          blue      # color of process separators like ';' and '&'
    set -g fish_color_error        red       # color of potential errors
    set -g fish_color_match        --reverse # color of highlighted matching parenthesis
    set -g fish_color_search_match --background=yellow
    set -g fish_color_selection    --reverse # color of selected text (vi mode)
    set -g fish_color_operator     green     # color of parameter expansion operators like '*' and '~'
    set -g fish_color_escape       red       # color of character escapes like '\n' and and '\x70'
    set -g fish_color_cancel       red       # color of the '^C' indicator on a canceled command
  '';
}
