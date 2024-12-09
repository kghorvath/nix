{ config, inputs, pkgs, ... }:

let

  unstable = import inputs.nixpkgs-unstable {
    system = pkgs.system;
  };

in

{

  imports = [
    ./programs/hyprland.nix
    ./programs/firefox.nix
    ./programs/wezterm.nix
  ];

  home.enableNixpkgsReleaseCheck = false;

  home.username = "khorvath";
  home.homeDirectory = "/home/khorvath";

  home.pointerCursor = {
    x11.enable = true;
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };

  home.packages = with pkgs; [

    # CLI tools
    appimage-run
    bchunk
    brightnessctl
    cdrkit
    fortune
    htop
    ipmitool
    jq
    neofetch
    podman-tui
    progress
    stow
    unzip
    wget
    xmlstarlet

    # Python
    (python3.withPackages
      (ps: with ps; [
        numpy
	scipy
      ])
    )

    # Productivity
    hugo
    libreoffice
    octaveFull
    simple-scan
    (texlive.combine { inherit (texlive) scheme-medium thaispec xstring; })
    typst
    xournalpp

    # Editors
    emacs29-pgtk
    neovim

    # Internet
    bitwarden
    element-desktop
    nextcloud-client
    thunderbird
    webcord
    vivaldi
    vivaldi-ffmpeg-codecs
    widevine-cdm

    # Networking
    remmina

    # Games
    openttd
    freeciv

    # Emulators
    _86Box
    dosbox-x

    # Media
    #calibre
    ffmpeg-full
    gimp-with-plugins
    krita
    libcamera-qcam
    obs-studio
    pinta
    vlc
    yt-dlp

    # Utilities
    alacarte
    distrobox
    gnome-tweaks
    nautilus
    nwg-look
    jdk
    inputs.nixgl.packages.${pkgs.system}.nixGLIntel
    xfce.thunar
    virt-manager
    
    # Hyprland
    hypridle
    hyprlock
    hyprlauncher
    hyprpaper
    hyprpicker
    hyprshot
    hyprwall
    kitty
    waybar
    wofi
    inputs.swww.packages.${pkgs.system}.swww

  ];
  
  programs.git = {
    enable = true;
    userName = "Kamin Horvath";
    userEmail = "kamin@kghorvath.com";
  };

  # Enable home manager itself
  programs.home-manager.enable = true;

  home.stateVersion = "24.05";

}
