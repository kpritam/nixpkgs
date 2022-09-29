{ config, lib, pkgs, ... }:

{
  # Bat, a substitute for cat.
  # https://github.com/sharkdp/bat
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.bat.enable
  programs.bat.enable = true;
  programs.bat.config = {
    style = "plain";
  };

  # Direnv, load and unload environment variables depending on the current directory.
  # https://direnv.net
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.direnv.enable
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  # Htop
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.htop.enable
  programs.htop.enable = true;
  programs.htop.settings.show_program_path = true;

  # Zoxide, a faster way to navigate the filesystem
  # https://github.com/ajeetdsouza/zoxide
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.zoxide.enable
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
  };

  home.packages = with pkgs; [
    bandwhich # display current network utilization by process
    coreutils
    curl
    exa # fancy version of `ls`
    fd # fancy version of `find`
    fzf
    htop # fancy version of `top`
    ripgrep # better version of `grep`
    tealdeer # rust implementation of `tldr`
    unrar # extract RAR archives
    wget
    xz # extract XZ archives
    jq
    comma # run software from without installing it

  ] ++ lib.optionals stdenv.isDarwin [
    cocoapods
  ];
}
