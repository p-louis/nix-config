{pkgs, lib, config, ...}: 
{
  options = {
    myNixOs.bundles.desktop.enable = lib.mkEnableOption "enable Baseline Desktop config";
  };

  config = lib.mkIf config.myNixOs.bundles.desktop.enable {

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
    # Enable the X11 windowing system.
    # You can disable this if you're only using the Wayland session.
    services.xserver = {
      enable = true;
      # Configure keymap in X11
      xkb = {
        layout = "us";
        variant = "";
      };
    };

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
      darktable 
      gimp 
      inkscape
    ];

  };
}
# vim: ts=2 sts=2 sw=2 et
