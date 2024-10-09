{ config, inputs, pkgs, ... }:

{

  imports = [

  ];
  
  home.username = "khorvath";
  home.homeDirectory = "/home/khorvath";

  home.packages = with pkgs; [

    # CLI tools
    bchunk
    cdrkit
    htop
    jq
    neofetch
    progress
    stow
    wget

    # Terminal emulators

    # Productivity
    hugo
    libreoffice
    xournalpp

    # Editors
    emacs29-pgtk
    neovim

    # Internet
    firefox
    thunderbird
    nextcloud-client
    webcord
    element-desktop

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

    # Utilities
    distrobox

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

  # Hyprland config
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = builtins.readFile ./dotfiles/hyprland/hyprland.conf;
  };
  services.hypridle = {
    enable = true;
  };
  services.hyprpaper = {
    enable = true;
  };

  xdg.configFile."hypr/hypridle.conf".source = ./dotfiles/hyprland/hypridle.conf;
  xdg.configFile."hypr/hyprpaper.conf".source = ./dotfiles/hyprland/hyprpaper.conf;
  xdg.configFile."hypr/hyprlock.conf".source = ./dotfiles/hyprland/hyprlock.conf;

  # Enable home manager itself
  programs.home-manager.enable = true;

  home.stateVersion = "24.05";

}
