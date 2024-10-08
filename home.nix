{ config, inputs, pkgs, ... }:

{
  home.username = "khorvath";
  home.homeDirectory = "/home/khorvath";

  home.packages = with pkgs; [

    # CLI tools
    neofetch
    nnn
    jq
    stow
    wget

    # Terminal emulators

    # Productivity
    hugo
    libreoffice
    xournalpp

    # Editors
    neovim
    emacs29-pgtk

    # Internet
    firefox
    thunderbird
    nextcloud-client
    webcord

    # Networking
    remmina

    # Games
    openttd

    # Emulators
    _86Box
    dosbox-x

    # Media
    calibre
    pinta

  ];

  # Programs
  programs.git = {
    enable = true;
    userName = "Kamin Horvath";
    userEmail = "kamin@kghorvath.com";
  };

  programs.wezterm = {
    enable = true;
    package = inputs.wezterm.packages.${pkgs.system}.default;
    extraConfig = builtins.readFile ./dotfiles/wezterm/wezterm.lua;
  };

  # Enable home manager itself
  programs.home-manager.enable = true;

  home.stateVersion = "24.05";

}
