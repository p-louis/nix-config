{
pkgs,
config,
lib,
...
}: {
  nixpkgs = {
    config = {
      allowUnfree = true;
      experimental-features = "nix-command flakes";
    };
  };


  myHomeManager.zsh.enable = lib.mkDefault true;
  myHomeManager.git.enable = lib.mkDefault true;

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
    yq
  ];


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
# vim: sw=2 ts=2 sts=2
