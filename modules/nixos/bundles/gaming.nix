{pkgs, lib, config, ...}: 
{

    programs.steam.enable = true;

    environment.systemPackages = with pkgs; [
      lutris
      discord
      gamemode
      scanmem
    ];
}
