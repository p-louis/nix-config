{
pkgs,
config,
lib,
inputs,
outputs,
...
}: let
  nixLib = import ../../nixLib/default.nix {inherit inputs;};
  cfg = config.myNixOs;

  features =
    nixLib.extendModules
    (name: {
      extraOptions = {
        myNixOs.${name}.enable = lib.mkEnableOption "enable my ${name} configuration";
      };

      configExtension = config: (lib.mkIf cfg.${name}.enable config);
    })
    (nixLib.filesIn ./features);

  # Taking all module bundles in ./bundles and adding bundle.enables to them
  bundles =
    nixLib.extendModules
    (name: {
      extraOptions = {
        myNixOs.bundles.${name}.enable = lib.mkEnableOption "enable ${name} module bundle";
      };

      configExtension = config: (lib.mkIf cfg.bundles.${name}.enable config);
    })
    (nixLib.filesIn ./bundles);
  # Taking all modules in ./features and adding enables to them
in {
  imports =
    [
    ]
    ++ features
    ++ bundles;

  config = {
    nix.settings.experimental-features = ["nix-command" "flakes"];
    programs.nix-ld.enable = true;
    nixpkgs.config.allowUnfree = true;
  };
}

# vim: ts=2 sts=2 sw=2 et
