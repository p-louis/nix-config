{pkgs, lib, config, ...}: 
{
  options = {
    myNixOs.bundles.gaming.enable = lib.mkEnableOption "enable Gaming config";
  };

  config = lib.mkIf config.myNixOs.bundles.gaming.enable {
    programs.steam.enable = true;

    environment.systemPackages = with pkgs; [
      lutris
      discord
      gamemode
      scanmem
    ];
  };
}
