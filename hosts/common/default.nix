{ lib, pkgs, outputs, ... }:
{
  imports = [

    # Packages with custom configs go here
    ./bat.nix # cat with better syntax highlighting and extras like batgrep.
    ./fonts.nix # core fonts
    ./git.nix # personal git config
    ./kitty.nix # terminal
    ./zoxide.nix # cd replacement
    ./zsh.nix # primary shell: includes zsh, oh-my-zsh, and p10k theme
  ];

  home = {
    username = lib.mkDefault "patrick";
    homeDirectory = lib.mkDefault "/home/patrick";
    stateVersion = lib.mkDefault "21.11";
    sessionPath = [
      "$HOME/.local/bin"
    ];
    sessionVariables = {
      FLAKE = "$HOME/Documents/nix-config";
      SHELL = "zsh";
      TERM = "kitty";
      TERMINAL = "kitty";
      EDITOR = "nvim";
      MANPAGER = "batman"; # see ./cli/bat.nix
    };
  };

  home.packages = builtins.attrValues {
    inherit (pkgs)
      borgbackup# backups
      btop# resource monitor
      coreutils# basic gnu utils
      curl
      eza# ls replacement
      fd# tree style ls
      findutils# find
      fzf# fuzzy search
      jq# JSON pretty printer and manipulator
      nix-tree# nix package tree viewer
      ncdu# TUI disk usage
      pciutils
      pfetch# system info
      pre-commit# git hooks
      p7zip# compression & encryption
      ripgrep# better grep
      usbutils
      tree# cli dir tree viewer
      unzip# zip extraction
      unrar# rar extraction
      wget# downloader
      zip; # zip compression
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
    };
  };

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = [ "nix-command" "flakes" "repl-flake" ];
      warn-dirty = false;
    };
  };
}
