{pkgs, lib, config, ...}: 
{
    services.desktopManager.plasma6.enable = true;

    programs.kdeconnect.enable = true;

    environment.systemPackages = with pkgs; [
      libsForQt5.qt5.qtquickcontrols2
      libsForQt5.qt5.qtgraphicaleffects
      plasma5Packages.kdeconnect-kde
      plasma-thunderbolt
    ];

    networking.firewall = { 
      enable = true;
      allowedTCPPortRanges = [ 
        { from = 1714; to = 1764; } # KDE Connect
      ];  
      allowedUDPPortRanges = [ 
        { from = 1714; to = 1764; } # KDE Connect
      ];  
    };
}
# vim: ts=2 sts=2 sw=2 et
