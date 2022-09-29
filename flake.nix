{
  description = "Pritam Nix system configs, and some other useful stuff.";

  inputs = {
    # Package sets
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixpkgs-22.05-darwin";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixos-stable.url = "github:NixOS/nixpkgs/nixos-22.05";

    # Environment/system management
    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-unstable";

    # Other sources
    flake-compat = { url = "github:edolstra/flake-compat"; flake = false; };
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, darwin, home-manager, flake-utils, ... }@inputs:
    let
      # Some building blocks

      inherit (darwin.lib) darwinSystem;
      inherit (inputs.nixpkgs-unstable.lib) attrValues makeOverridable optionalAttrs singleton;

      # Configuration for `nixpkgs`
      nixpkgsConfig = {
        config = { allowUnfree = true; };
      };

      homeManagerStateVersion = "22.11";

      primaryUserInfo = {
        username = "pritamkadam";
        fullName = "Pritam Kadam";
        email = "kpritam@thoughtworks.com";
        nixConfigDirectory = "/Users/pritamkadam/.config/nixpkgs";
      };

      # Modules shared by most `nix-darwin` personal configurations.
      nixDarwinCommonModules = attrValues self.darwinModules ++ [
        # `home-manager` module
        home-manager.darwinModules.home-manager
        (
          { config, ... }:
          let
            inherit (config.users) primaryUser;
          in
          {
            nixpkgs = nixpkgsConfig;
            # Hack to support legacy worklows that use `<nixpkgs>` etc.
            # nix.nixPath = { nixpkgs = "${primaryUser.nixConfigDirectory}/nixpkgs.nix"; };
            nix.nixPath = { nixpkgs = "${inputs.nixpkgs-unstable}"; };
            # `home-manager` config
            users.users.${primaryUser.username}.home = "/Users/${primaryUser.username}";
            home-manager.useGlobalPkgs = true;
            home-manager.users.${primaryUser.username} = {
              imports = attrValues self.homeManagerModules;
              home.stateVersion = homeManagerStateVersion;
              home.user-info = config.users.primaryUser;
            };
            # Add a registry entry for this flake
            nix.registry.my.flake = self;
          }
        )
      ];
    in
    {

      # System outputs

      # My `nix-darwin` configs
      darwinConfigurations = rec {
        # Mininal configurations to bootstrap systems
        bootstrap-x86 = makeOverridable darwinSystem {
          system = "x86_64-darwin";
          modules = [ ./darwin/bootstrap.nix { nixpkgs = nixpkgsConfig; } ];
        };

        MacBookPro = darwinSystem {
          system = "x86_64-darwin";
          modules = nixDarwinCommonModules ++ [
            {
              users.primaryUser = primaryUserInfo;
              networking.computerName = "pritamkadam";
              networking.hostName = "MacBookPro";
              networking.knownNetworkServices = [
                "Wi-Fi"
                "USB 10/100/1000 LAN"
              ];
            }
          ];
        };
      };

      darwinModules = {
        # My configurations
        pritamkadam-bootstrap = import ./darwin/bootstrap.nix;
        pritamkadam-defaults = import ./darwin/defaults.nix;
        pritamkadam-general = import ./darwin/general.nix;
        pritamkadam-homebrew = import ./darwin/homebrew.nix;

        # Modules I've created
        programs-nix-index = import ./modules/darwin/programs/nix-index.nix;
        users-primaryUser = import ./modules/darwin/users.nix;
      };

      homeManagerModules = {
        # My configurations
        pritamkadam-config-files = import ./home/config-files.nix;
        pritamkadam-fish = import ./home/fish.nix;
        pritamkadam-git = import ./home/git.nix;
        pritamkadam-git-aliases = import ./home/git-aliases.nix;
        pritamkadam-gh-aliases = import ./home/gh-aliases.nix;
        # pritam-kitty = import ./home/kitty.nix;
        pritamkadam-packages = import ./home/packages.nix;
        pritamkadam-starship = import ./home/starship.nix;
        pritamkadam-starship-symbols = import ./home/starship-symbols.nix;

        home-user-info = { lib, ... }: {
          options.home.user-info =
            (self.darwinModules.users-primaryUser { inherit lib; }).options.users.primaryUser;
        };
      };
    };
}
