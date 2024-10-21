{
  description = "Pritam’s Nix system configs";

  inputs = {
    # Package sets
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixos-stable.url = "github:NixOS/nixpkgs/nixos-22.11";

    # Environment/system management
    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
   
    flake-utils.url = "github:numtide/flake-utils";
    
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    emacs-overlay.inputs.nixpkgs.follows = "nixpkgs-unstable";
    emacs-overlay.inputs.flake-utils.follows = "flake-utils";
  };

  outputs = { self, darwin, home-manager, flake-utils, ... }@inputs:
    let
      inherit (self.lib) attrValues makeOverridable optionalAttrs singleton;

      homeStateVersion = "24.05";

      nixpkgsDefaults = {
        config = {
          allowUnfree = true;
        };
        overlays = attrValues self.overlays ++ [
          inputs.emacs-overlay.overlays.emacs
        ];
      };

      primaryUserDefaults = {
        username = "pritamkadam";
        fullName = "Pritam Kadam";
        email = "phkadam2008@gmail.com";
        nixConfigDirectory = "~/.config/nixpkgs";
      };
    in
    {
      # Add some additional functions to `lib`.
      lib = inputs.nixpkgs-unstable.lib.extend (_: _: {
        mkDarwinSystem = import ./lib/mkDarwinSystem.nix inputs;
        lsnix = import ./lib/lsnix.nix;
      });

      overlays = {
        pkgs-unstable = _: prev: {
          pkgs-unstable = import inputs.nixpkgs-unstable {
            inherit (prev.stdenv) system;
            inherit (nixpkgsDefaults) config;
          };
        };
      };

      darwinModules = {
        pritamkadam-bootstrap = import ./darwin/bootstrap.nix;
        pritamkadam-defaults = import ./darwin/defaults.nix;
        pritamkadam-general = import ./darwin/general.nix;
        pritamkadam-homebrew = import ./darwin/homebrew.nix;

        users-primaryUser = import ./modules/darwin/users.nix;
      };

      homeManagerModules = {
        pritamkadam-config-files = import ./home/config-files.nix;
        pritamkadam-fish = import ./home/fish.nix;
        pritamkadam-nu = import ./home/nu.nix;
        pritamkadam-git = import ./home/git.nix;
        pritamkadam-git-aliases = import ./home/git-aliases.nix;
        pritamkadam-gh-aliases = import ./home/gh-aliases.nix;
        pritamkadam-kitty = import ./home/kitty.nix;
        pritamkadam-packages = import ./home/packages.nix;
        pritamkadam-yabai = import ./home/yabai.nix;
        pritamkadam-borders = import ./home/borders.nix;

        home-user-info = { lib, ... }: {
          options.home.user-info =
            (self.darwinModules.users-primaryUser { inherit lib; }).options.users.primaryUser;
        };
      };
      
      darwinConfigurations = {
        # Minimal macOS configurations to bootstrap systems
        bootstrap-x86 = makeOverridable darwin.lib.darwinSystem {
          system = "x86_64-darwin";
          modules = [ ./darwin/bootstrap.nix { nixpkgs = nixpkgsDefaults; } ];
        };
        bootstrap-arm = self.darwinConfigurations.bootstrap-x86.override {
          system = "aarch64-darwin";
        };

        # My Apple Silicon macOS laptop config
        MacBookPro = makeOverridable self.lib.mkDarwinSystem (primaryUserDefaults // {
          modules = attrValues self.darwinModules ++ singleton {
            nixpkgs = nixpkgsDefaults;
            networking.computerName = "pritamkadam";
            networking.hostName = "MacBookPro";
            networking.knownNetworkServices = [
              "Wi-Fi"
              "USB 10/100/1000 LAN"
            ];
            nix.registry.my.flake = inputs.self;
          };
          inherit homeStateVersion;
          system = "aarch64-darwin";
          homeModules = attrValues self.homeManagerModules;
        });
    };
  } // flake-utils.lib.eachDefaultSystem (system: {
      # Re-export `nixpkgs-unstable` with overlays.
      # This is handy in combination with setting `nix.registry.my.flake = inputs.self`.
      # Allows doing things like `nix run my#prefmanager -- watch --all`
      legacyPackages = import inputs.nixpkgs-unstable (nixpkgsDefaults // { inherit system; });
  });
}
