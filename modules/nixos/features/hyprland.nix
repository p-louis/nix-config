{inputs, pkgs, lib, config, ...}: 
{
    programs.hyprland = {
      enable = true;

      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;

      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };
}
# vim: ts=2 sts=2 sw=2 et
