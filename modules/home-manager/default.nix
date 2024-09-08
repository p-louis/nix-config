{
  pkgs,
  system,
  inputs,
  config,
  lib,
  nixLib,
  ...
}: let
  cfg = config.myHomeManager;

  # Taking all modules in ./features and adding enables to them
  features =
    nixLib.extendModules
    (name: {
      extraOptions = {
        myHomeManager.${name}.enable = lib.mkEnableOption "enable my ${name} configuration";
      };

      configExtension = config: (lib.mkIf cfg.${name}.enable config);
    })
    (nixLib.filesIn ./features);

  # Taking all module bundles in ./bundles and adding bundle.enables to them
  bundles =
    nixLib.extendModules
    (name: {
      extraOptions = {
        myHomeManager.bundles.${name}.enable = lib.mkEnableOption "enable ${name} module bundle";
      };

      configExtension = config: (lib.mkIf cfg.bundles.${name}.enable config);
    })
    (nixLib.filesIn ./bundles);
in {
  imports =
    [
    ]
    ++ features
    ++ bundles;
}
