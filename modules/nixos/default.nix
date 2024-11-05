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
  imports =
    [
      inputs.home-manager.nixosModules.home-manager
      ./features/nvidia.nix
      ./features/sddm.nix
      ./features/plasma.nix
      ./features/downloader.nix
      ./features/libreoffice.nix
      ./bundles/desktop.nix
      ./bundles/baseline.nix
      ./bundles/gaming.nix
    ];

  #options.myNixOS = {
  #  hyprland.enable = lib.mkEnableOption "enable hyprland";
  #};

  config = {
    nix.settings.experimental-features = ["nix-command" "flakes"];
    programs.nix-ld.enable = true;
    nixpkgs.config.allowUnfree = true;
  };
}

# vim: ts=2 sts=2 sw=2 et
