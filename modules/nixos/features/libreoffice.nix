{pkgs, lib, config, ...}: 
{
    environment.systemPackages = with pkgs; [
      libreoffice-qt
    ];
}
# vim: ts=2 sts=2 sw=2 et
