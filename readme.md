```
# My Nix Configs

Hello world!

![Build Nix envs](https://github.com/malob/nixpkgs/workflows/Build%20Nix%20envs/badge.svg)

This repo contains my Nix configs for macOS and Linux and by extension, configuration for most tools/programs I use, at least in the terminal.

I'm continuously tweaking/improving my setup, trying to find ways to make more of my configuration declarative, and I like experimenting with bleeding edge updates/features, so this repo sees a lot of changes. I do try to ensure that `master` always builds and doesn't have any bad bugs (at least in my workflow), and keep the code fairly well documented.

Feel free to file an [issue](https://github.com/malob/nixpkgs/issues) or start a [discussion](https://github.com/malob/nixpkgs/discussions) if you find a bug, or think something is broken, or think I'm doing something in a dumb/clumsy way and have a suggestion for a more elegant alternative, or try to crib something from my config but just can't get it working, or are looking at my config and think to yourself "does this guy know about X, cause I bet he'd be into it", or have some other type of feedback/comment. (Issues, are better for things that are actually issues, while discussions are better for ideas, questions, etc.)

I make no promises that I'll respond quickly, or fix the bug (especially if I'm not experiencing it), or whatever, but you definitely shouldn't feel like you're imposing in any way, and I probably will respond within a few days.

Below, I've highlighted stuff that I'm particularly happy with or think others might find helpful/useful.

## Highlights

In no particular order:

* [Flakes](./flake.nix)!
  * All external dependencies managed through flakes for easy updating.
  * Outputs for [`nix-darwin`](https://github.com/LnL7/nix-darwin) macOS system configurations (using `home-manager` as a `nix-darwin` module) and a [`home-manager`](https://github.com/nix-community/home-manager) user configuration for Linux.
  * `darwinModules` output for `nix-darwin` modules that are pending upstream:
    * [`security-pam`](./modules/darwin/security/pam.nix) that provides an option, `enableSudoTouchIdAuth`, which enables using Touch ID for `sudo` authentication. (Pending upstream PR [#228](https://github.com/LnL7/nix-darwin/pull/228).)
    * [`programs-nix-index`](./modules/darwin/programs/nix-index.nix) that augments `nix-darwins`'s `programs.nix-index` module with a command not found handler for Fish. (Pending upstream PR [#272](https://github.com/LnL7/nix-darwin/pull/272).)
  * `homeManagerModules` output for `home-manager` modules with additional functionality and prepackaged configuration:
    * [`programs-neovim-extras`](./modules/home/programs/neovim/extras.nix) that provides `termBufferAutoChangeDir`, and `nvrAliases` options.
    * [`programs-kitty-extras`](./modules/home/programs/kitty/extras.nix) that provides a,
      * `colors` option to configure a light and dark colorscheme, which when used also adds `term-light`, `term-dark`, and `term-background` scripts to `home.packages` to easily switch between them; and
      * `useSymbolsFromNerdFont` option to use symbols from a NerdFont while using any font with Kitty.
    * [`malo-git-aliases`](./home/git-aliases.nix)
    * [`malo-gh-aliases`](./home/gh-aliases.nix)
  * Support for non-flake compatible versions of Nix and legacy workflows through [`flake-compat`](https://nixos.wiki/wiki/Flakes#Using_flakes_project_from_a_legacy_Nix