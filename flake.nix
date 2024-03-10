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

  };

  outputs = { self, darwin, home-manager, ... }@inputs:
    let
      inherit (self.lib) attrValues makeOverridable optionalAttrs singleton;

      homeStateVersion = "24.05";

      nixpkgsDefaults = {
        config = {
          allowUnfree = true;
        };
      };

      primaryUserDefaults = {
        username = "pritamkadam";
        fullName = "Pritam Kadam";
        email = "phkadam2008@gmail.com";
        nixConfigDirectory = "/Users/pritamkadam/.config/nixpkgs";
      };
    in
    {
      # Add some additional functions to `lib`.
      lib = inputs.nixpkgs-unstable.lib.extend (_: _: {
        mkDarwinSystem = import ./lib/mkDarwinSystem.nix inputs;
        lsnix = import ./lib/lsnix.nix;
      });

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
        pritamkadam-git = import ./home/git.nix;
        pritamkadam-git-aliases = import ./home/git-aliases.nix;
        pritamkadam-gh-aliases = import ./home/gh-aliases.nix;
        pritamkadam-kitty = import ./home/kitty.nix;
        pritamkadam-packages = import ./home/packages.nix;

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
          homeModules = attrValues self.homeManagerModules;
        });
      };
    };
}
