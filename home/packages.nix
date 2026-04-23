{ config, lib, pkgs, ... }:

{
  # Bat, a substitute for cat.
  # https://github.com/sharkdp/bat
  # https://nix-community.github.io/home-manager/options.html#opt-programs.bat.enable
  programs.bat = {
    enable = true;
    config = {
      style = "numbers,changes,header";
      theme = "OneHalfDark";
    };
  };

  # Direnv, load and unload environment variables depending on the current directory.
  # https://direnv.net
  # https://nix-community.github.io/home-manager/options.html#opt-programs.direnv.enable
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };

  programs.bash.enable = true;

  # Zoxide, a faster way to navigate the filesystem
  # https://github.com/ajeetdsouza/zoxide
  # https://nix-community.github.io/home-manager/options.html#opt-programs.zoxide.enable
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = "fd --type f --hidden --follow --exclude .git --exclude .vim --exclude .cache --exclude vendor";
    defaultOptions = [
      "--border sharp"
      "--inline-info"
      "--bind ctrl-h:preview-down,ctrl-l:preview-up"
    ];
  };

  programs.dircolors.enable = true;
  programs.java = {
    enable = true;
    package = pkgs.temurin-bin-21;
  };

  programs.emacs = {
    enable = true;
    package = pkgs.emacs;
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = false;
  };

  home.packages = with pkgs; [
    coreutils
    curl
    eza # fancy version of `ls`
    fd # fancy version of `find`
    jq
    just
    nixd
    nixpkgs-fmt
    ripgrep # better version of `grep`
    sbt
    tealdeer # rust implementation of `tldr`
    wget
    xh # rust alternative of httpie
    graphviz # required for plantuml
  ];
}
