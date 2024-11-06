{ 
config, 
lib, 
pkgs, 
... 
}:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  myNixOs = {
    bundles.baseline.enable = true;
    bundles.desktop.enable = false;
    bundles.gaming.enable = false;
    bundles.work.enable = true;

    nvidia.enable = false;
    sddm.enable = false;
    plasma.enable = false;
    downloader.enable = false;
    libreoffice.enable = true;
    hyprland.enable = true;
  };

  # Enable networking
  networking.hostName = "uranos"; # Define your hostname.
  networking.domain = "patricklouis.de";
  networking.networkmanager.enable = true;

  hardware.cpu.intel.updateMicrocode = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true; # use xkb.options in tty.
  };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  services.xserver.videoDrivers = [ "displaylink" "modesetting" ];

  programs.zsh.enable = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.fuzzel = {
    isNormalUser = true;
    description = "Patrick";
    extraGroups = [ "networkmanager" "wheel" "audio" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      kdePackages.kate
    ];
  };

  home-manager.users.fuzzel = {
    home.username = "fuzzel";
    home.homeDirectory = "/home/fuzzel";

    home.stateVersion = "24.05"; # Please read the comment before changing.
    programs.zsh.enable = true;
    programs.home-manager.enable = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wlr-randr
    vpl-gpu-rt
    neovim
    git
  ];

  system.stateVersion = "24.05"; # Did you read the comment?
}

# vim: ts=2 sts=2 sw=2 et
