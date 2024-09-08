{pkgs, lib, config, ...}: 
{
  options = {
    myNixOs.plasma6.enable = lib.mkEnableOption "enable Plasma 6";
  };

  config = lib.mkIf config.myNixOs.plasma6.enable {
    services.desktopManager.plasma6.enable = true;

    environment.systemPackages = with pkgs; [
      libsForQt5.qt5.qtquickcontrols2
      libsForQt5.qt5.qtgraphicaleffects
    ];
  };
}
# vim: ts=2 sts=2 sw=2 et