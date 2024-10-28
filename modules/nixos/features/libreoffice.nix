{pkgs, lib, config, ...}: 
{
  options = {
    myNixOs.libreoffice.enable = lib.mkEnableOption "enable LibreOffice";
  };

  config = lib.mkIf config.myNixOs.libreoffice.enable {
    environment.systemPackages = with pkgs; [
      libreoffice-qt
    ];
  };
}
# vim: ts=2 sts=2 sw=2 et
