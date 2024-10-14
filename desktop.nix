{
  # Enable X11 Desktop
  services.xserver = {
    enable = true;

    # Enable GNOME
    displayManager.gdm.enable = true;
    # desktopManager.gnome.enable = true;

    xkb.layout = "us";
  };
  services.desktopManager = {
    # Enable KDE
    # displayManager.sddm.wayland.enable = true;
    # plasma6.enable = true;
  };

    # Hyprland
  programs.hyprland.enable = true;

  # Enable polkit
  security.polkit.enable = true;

   # Enable sound.
  hardware.pulseaudio.enable = false;
  services.pipewire = {
  	enable = true;
  	pulse.enable = true;
  };
}
