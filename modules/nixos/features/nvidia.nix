{ config, lib, pkgs, modulesPath, ... }:

{
    boot.kernelModules = [ "kvm-amd" "nvidia_drm" "nvidia_modeset" "nvidia_uvm" "nvidia" ];
    boot.kernelParams = [ "nvidia-drm.modeset=1" ];

    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
    };

    services.xserver.videoDrivers = [ "nvidia" ];
}
# vim: ts=2 sts=2 sw=2 et
