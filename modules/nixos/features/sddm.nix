{pkgs, lib, config, ...}: 
{
    services = {
      xserver = {
        enable = true;
        xkb = {
          layout = "us";
          variant = "";
        };
      };
      displayManager = {
        sddm = {
          enable = lib.mkDefault true;
          wayland.enable = true;
        };
      };
    };

    environment.systemPackages = with pkgs; [
      libsForQt5.qt5.qtquickcontrols2
      libsForQt5.qt5.qtgraphicaleffects
    ];
}
# vim: ts=2 sts=2 sw=2 et
