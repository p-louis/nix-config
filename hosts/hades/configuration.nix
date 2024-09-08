# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ 
config, 
pkgs, 
lib, 
inputs, 
outputs, 
system, 
nixLib, 
... 
}: {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  myNixOs = {
    bundles.desktop.enable = true;

    sddm.enable = true;
    nvidia.enable = true;
    plasma6.enable = true;
  };

  # Enable networking
  networking.hostName = "hades"; # Define your hostname.
  networking.networkmanager.enable = true;


  hardware.cpu.amd.updateMicrocode = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.fuzzel = {
    isNormalUser = true;
    description = "Patrick";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
    ];
  };


  programs.steam.enable = true;


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}

# vim: ts=2 sts=2 sw=2 et
