{pkgs, lib, config, ...}: 
{
  options = {
    myNixOs.downloader.enable = lib.mkEnableOption "enable Downloader-Setup";
  };

  services.mullvad-vpn.enable = true;

  config = lib.mkIf config.myNixOs.downloader.enable {
    environment.systemPackages = with pkgs; [
      mullvad-vpn 
      pyload-ng
    ];
  };
}
# vim: ts=2 sts=2 sw=2 et
