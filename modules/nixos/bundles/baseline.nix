{pkgs, ...}: 
{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;


  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };


  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.hardware.bolt.enable = true;

  systemd.user.services = {
    ydotool.enable = true;
  };

  # Enable sound with pipewire.
  hardware.enableAllFirmware = true;

  security.rtkit.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = false;
    pulse.enable = true;
    jack.enable = false;
    wireplumber.enable = true;
  };
  hardware.pulseaudio.enable = false;

  services.pcscd.enable = true;

  # Install firefox.
  programs.firefox.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.mtr.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim 
    unzip wget zip mpv git zsh fzf zoxide fastfetch starship eza pass gnupg alacritty tmux nerdfonts bind openssl rar nmap usbutils pciutils nfs-utils ntfs3g borgbackup minicom cryptsetup
    pinentry-all dmenu-wayland ydotool
    rustup gcc gnat
    pavucontrol
    wakelan
    bolt
    #sof-firmware
    alsa-firmware alsa-oss alsa-lib alsa-utils alsa-tools alsaequal 
    #pulseaudio
    pipewire wireplumber # Audio stuff
  ];

}
# vim: ts=2 sts=2 sw=2 et
