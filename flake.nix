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
      myConfig = {
        userName = "fuzzel";
        realName = "Patrick Louis";
        workEmail = "patrick.louis@linked-planet.com";
        personalEmail = "patrick.louis@mailbox.org";
      };

    mkSystem = user: configuration: sys: homeConfig:
        inputs.nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs myConfig;
          };
          system = sys;
          modules = [
            ./modules/nixos/default.nix
            configuration
            inputs.home-manager.nixosModules.home-manager
            {
              home-manager = {
                extraSpecialArgs = {
                  inherit inputs myConfig;
                };
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = ".backup";
                users.${user} = import homeConfig;
              };
            }
          ];
        };
    in {
      nixosConfigurations = {
        hades = mkSystem myConfig.userName ./hosts/hades/configuration.nix "x86_64-linux" ./hosts/hades/home.nix;
        uranos = mkSystem myConfig.userName ./hosts/uranos/configuration.nix "x86_64-linux" ./hosts/uranos/home.nix;
      };
    };
}

# vim: ts=2 sts=2 sw=2 et
