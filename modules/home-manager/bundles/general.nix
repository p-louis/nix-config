{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: {
  nixpkgs = {
    config = {
      allowUnfree = true;
      experimental-features = "nix-command flakes";
    };
  };

    gtk = {
        enable = true;
        theme = {
            package = pkgs.gnome-themes-extra;
            name = "Adwaita-dark";
        };
    };

  myHomeManager.zsh.enable = lib.mkDefault true;
    #myHomeManager.fish.enable = lib.mkDefault true;
    #myHomeManager.lf.enable = lib.mkDefault true;
    #myHomeManager.yazi.enable = lib.mkDefault true;
    #myHomeManager.nix-extra.enable = lib.mkDefault true;
    #myHomeManager.btop.enable = lib.mkDefault true;
    #myHomeManager.nix-direnv.enable = lib.mkDefault true;
    #myHomeManager.nix.enable = lib.mkDefault true;
    #myHomeManager.git.enable = lib.mkDefault true;

  # myHomeManager.bottom.enable = lib.mkDefault true;

  programs.home-manager.enable = true;

  programs.bat.enable = true;

  home.packages = with pkgs; [
    file
    git
    p7zip
    unzip
    zip
    stow
    imagemagick
    killall
    neovim

    fzf
    btop
    lf
    eza
    fd
    zoxide
    du-dust
    ripgrep
    fastfetch

    ffmpeg
    wget

    yt-dlp
    tree-sitter

    nh
    jq
  ];

  home.sessionVariables = {
    FLAKE = "${config.home.homeDirectory}/Documents/nix-config";
  };

    # myHomeManager.impermanence.data.directories = [
    #   ".ssh"
    # ];

    # myHomeManager.impermanence.cache.directories = [
    #   ".local/share/nvim"
    #   ".config/nvim"
    # ];

    # myHomeManager.impermanence.cache.files = [
    #   ".zsh_history"
    # ];
}
