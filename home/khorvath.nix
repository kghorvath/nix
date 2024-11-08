{ config, inputs, pkgs, ... }:

let

  unstable = import inputs.nixpkgs-unstable {
    system = pkgs.system;
  };

in

{

  imports = [
    ./programs/wezterm.nix
  ];
  
  home.username = "khorvath";
  home.homeDirectory = "/home/khorvath";

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 22;
  };

  home.packages = with pkgs; [

    # CLI tools
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
    calibre
    ffmpeg-full
    gimp-with-plugins
    krita
    libcamera-qcam
    obs-studio
    pinta
    vlc

    # Utilities
    alacarte
    distrobox
    jdk
    inputs.nixgl.packages.${pkgs.system}.nixGLIntel
    xfce.thunar
    virt-manager
    
    # Hyprland
    inputs.hypridle.packages.${pkgs.system}.hypridle
    inputs.hyprlock.packages.${pkgs.system}.hyprlock
    hyprpanel
    hyprpaper
    hyprpicker
    hyprshot
    kitty
    waybar
    wofi
    inputs.swww.packages.${pkgs.system}.swww

  ];

  programs.firefox = {
    enable = true;
    package = pkgs.firefox-bin;
    policies = {
      EnableTrackingProtection = {
        Value = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      DisablePocket = true;
      OverrideFirstRunPage = true;
      ExtensionSettings = {
        "addon@darkreader.org" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
	  installation_mode = "normal_installed";
        };
        "jid1-xUfzOsOFlzSOXg@jetpack" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/reddit-enhancement-suite/latest.xpi";
	  installation_mode = "normal_installed";
        };
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "normal_installed";
        };
        "@testpilot-containers" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/multi-account-containers/latest.xpi";
	  installation_mode = "normal_installed";
        };
        "{00000f2a-7cde-4f20-83ed-434fcb420d71}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/imagus/latest.xpi";
	  installation_mode = "normal_installed";
        };
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
	  installation_mode = "normal_installed";
        };
      };
    };
  };
  
  programs.git = {
    enable = true;
    userName = "Kamin Horvath";
    userEmail = "kamin@kghorvath.com";
  };

  # Hyprland config
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    extraConfig = builtins.readFile ./dotfiles/hyprland/hyprland.conf;
    plugins = [
      #pkgs.hyprlandPlugins.hyprwinwrap
      inputs.hypr-dynamic-cursors.packages.${pkgs.system}.hypr-dynamic-cursors
    ];  
  };
  services.hypridle = {
    enable = true;
  };
  services.hyprpaper = {
    enable = false;
  };
  xdg.configFile."hypr/hypridle.conf".source = ./dotfiles/hyprland/hypridle.conf;
  xdg.configFile."hypr/hyprpaper.conf".source = ./dotfiles/hyprland/hyprpaper.conf;
  xdg.configFile."hypr/hyprlock.conf".source = ./dotfiles/hyprland/hyprlock.conf;
  xdg.configFile."waybar/config.top".source = ./dotfiles/waybar/config.top;
  xdg.configFile."waybar/config.bottom".source = ./dotfiles/waybar/config.bottom;
  xdg.configFile."waybar/style.css".source = ./dotfiles/waybar/style.css;

  # Enable home manager itself
  programs.home-manager.enable = true;

  home.stateVersion = "24.05";

}
