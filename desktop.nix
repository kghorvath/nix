{
  # Enable X11 Desktop
  services.xserver = {
    enable = true;

    # Enable GNOME
    displayManager.gdm.enable = true;
    # desktopManager.gnome.enable = true;

    # Enable KDE
    # displayManager.sddm.wayland.enable = true;
    desktopManager.plasma6.enable = true;

    xkb.layout = "us";
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
