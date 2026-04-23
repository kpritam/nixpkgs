{
  description = "Pritam's declarative macOS system configuration with nix-darwin and Home Manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, darwin, home-manager, ... }@inputs:
    let
      system = "aarch64-darwin";
      homeStateVersion = "25.11";

      nixpkgsConfig = {
        config.allowUnfree = true;
      };

      overlays = [
        (_: pkgs: {
          nushell = pkgs.nushell.overrideAttrs (_: {
            doCheck = false;
          });
        })
      ];

      primaryUserDefaults = {
        username = "pritamkadam";
        fullName = "Pritam Kadam";
        email = "phkadam2008@gmail.com";
        nixConfigDirectory = "~/.config/nixpkgs";
      };
    in
    {
      darwinModules = {
        pritamkadam-bootstrap = import ./darwin/bootstrap.nix;
        pritamkadam-defaults = import ./darwin/defaults.nix;
        pritamkadam-general = import ./darwin/general.nix;
        pritamkadam-homebrew = import ./darwin/homebrew.nix;
        users-primaryUser = import ./modules/darwin/users.nix;
      };

      homeManagerModules = {
        pritamkadam-fish = import ./home/fish.nix;
        pritamkadam-nu = import ./home/nu.nix;
        pritamkadam-git = import ./home/git.nix;
        pritamkadam-git-aliases = import ./home/git-aliases.nix;
        pritamkadam-gh-aliases = import ./home/gh-aliases.nix;
        pritamkadam-packages = import ./home/packages.nix;
        pritamkadam-yabai = import ./home/yabai.nix;
        pritamkadam-borders = import ./home/borders.nix;
        home-user-info = { lib, ... }: {
          options.home.user-info =
            (self.darwinModules.users-primaryUser { inherit lib; }).options.users.primaryUser;
        };
      };

      darwinConfigurations = {
        # Minimal configuration for bootstrapping new systems
        bootstrap = darwin.lib.darwinSystem {
          modules = [
            ./darwin/bootstrap.nix
            { nixpkgs = nixpkgsConfig // { hostPlatform = system; inherit overlays; }; }
          ];
        };

        # Main Apple Silicon macOS laptop config
        MacBookPro = darwin.lib.darwinSystem {
          specialArgs = { inherit inputs; };
          modules = builtins.attrValues self.darwinModules ++ [
            home-manager.darwinModules.home-manager
            ({ config, ... }:
              let user = primaryUserDefaults; in
              {
                nixpkgs = nixpkgsConfig // { hostPlatform = system; inherit overlays; };

                users.primaryUser = user;
                system.primaryUser = user.username;
                system.configurationRevision = self.rev or self.dirtyRev or null;

                networking.computerName = "pritamkadam";
                networking.hostName = "MacBookPro";
                networking.knownNetworkServices = [
                  "Wi-Fi"
                  "USB 10/100/1000 LAN"
                ];

                nix.nixPath.nixpkgs = "${nixpkgs}";
                nix.registry.my.flake = self;

                users.users.${user.username}.home = "/Users/${user.username}";
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  extraSpecialArgs = { inherit inputs; };
                  users.${user.username} = {
                    imports = builtins.attrValues self.homeManagerModules;
                    home.stateVersion = homeStateVersion;
                    home.user-info = config.users.primaryUser;
                    manual.manpages.enable = false;
                  };
                };
              })
          ];
        };
      };

      # Re-export nixpkgs with allowUnfree for `nix run my#package` etc.
      legacyPackages.${system} = import nixpkgs (nixpkgsConfig // {
        localSystem = { inherit system; };
      });
    };
}
