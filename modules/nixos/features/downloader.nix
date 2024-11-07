{pkgs, lib, config, ...}: 
{
    services.mullvad-vpn.enable = true;

    environment.systemPackages = with pkgs; [
      mullvad-vpn 
      pyload-ng
    ];
}
# vim: ts=2 sts=2 sw=2 et
