{pkgs, lib, config, ...}: 
{
  options = {
    myNixOs.bundles.baseline.enable = lib.mkEnableOption "enable Baseline config";
  };

  config = lib.mkIf config.myNixOs.bundles.baseline.enable {
    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

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

    hardware.pulseaudio.enable = false;

    # Enable CUPS to print documents.
    services.printing.enable = true;


    systemd.user.services = {
      ydotool.enable = true;
    };

    # Enable sound with pipewire.
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };

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
      neovim unzip wget zip mpv git zsh fzf zoxide fastfetch starship eza pass gnupg alacritty tmux nerdfonts bind openssl rar nmap usbutils pciutils nfs-utils ntfs3g borgbackup minicom cryptsetup
      pinentry-all dmenu-wayland ydotool
      rustup gcc gnat
      wakelan
    ];

  };
}
# vim: ts=2 sts=2 sw=2 et
