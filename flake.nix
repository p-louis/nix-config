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
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let 
      nixLib = import ./nixLib/default.nix {inherit inputs;};
    in
      with nixLib; {
        homeManagerModules.default = ./modules/home-manager;
        nixosModules.default = ./modules/nixos;

        nixosConfigurations = {
          hades = mkSystem ./hosts/hades/configuration.nix;
          uranos = mkSystem ./hosts/uranos/configuration.nix;
        };

        homeConfigurations = {
          "fuzzel@hades" = mkHome "x86_64-linux" ./hosts/hades/home.nix;
          "fuzzel@uranos" = mkHome "x86_64-linux" ./hosts/uranos/home.nix;
        };
      };
}

# vim: ts=2 sts=2 sw=2 et
