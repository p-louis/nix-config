{
  description = "nixos config";

  inputs = { 
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let 
      home-manager = inputs.home-manager;
    in {
      nixosConfigurations = {
        hades = inputs.nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
          };
          system = "x86_64-linux";
          modules = [
            ./modules/nixos/default.nix
            ./hosts/hades/configuration.nix
            inputs.home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.fuzzel = import ./hosts/hades/home.nix;
            }
          ];
        };
        uranos = inputs.nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
          };
          system = "x86_64-linux";
          modules = [
            ./modules/nixos/default.nix
            ./hosts/uranos/configuration.nix
            inputs.home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = ".backup";
              home-manager.users.fuzzel = import ./hosts/uranos/home.nix;
            }
          ];
        };
      };
    };
}

# vim: ts=2 sts=2 sw=2 et
