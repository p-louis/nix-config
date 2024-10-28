{
pkgs,
config,
lib,
inputs,
outputs,
nixLib,
...
}: let
  cfg = config.myNixOS;

  # Taking all modules in ./features and adding enables to them
in {
  imports = [ 
    ./features/nvidia.nix
    ./features/libreoffice.nix
    ./features/downloader.nix
    ./features/plasma.nix
    ./features/sddm.nix

    ./bundles/baseline.nix
    ./bundles/desktop.nix
    ./bundles/gaming.nix
    ];

  config = {
    nix.settings.experimental-features = ["nix-command" "flakes"];
    programs.nix-ld.enable = true;
    nixpkgs.config.allowUnfree = true;
  };
}

# vim: ts=2 sts=2 sw=2 et
