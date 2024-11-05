{pkgs, lib, config, ...}: 
{
  options = {
    myNixOs.downloader.enable = lib.mkEnableOption "enable Downloader-Setup";
  };


  config = lib.mkIf config.myNixOs.downloader.enable {
    services.mullvad-vpn.enable = true;
    environment.systemPackages = with pkgs; [
      mullvad-vpn 
      pyload-ng
    ];
  };
}
# vim: ts=2 sts=2 sw=2 et
