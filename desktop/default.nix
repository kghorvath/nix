{config, lib, pkgs, inputs, ... }: let

  pkgs-unstable = inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};
  
in {

  # X Server Settings
  services.xserver = {
    enable = true;

    # Desktop Managers
    desktopManager = {
      xfce.enable = true;
    };
  };

  # Display Managers
  services.displayManager = {
    sddm = {
      enable = true;
      enableHidpi = true;
      #wayland.enable = true;
    };
  };

 # Enable Hyprland
 programs.hyprland = {
   enable = true;
   package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
   portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
 };

 # Enable sound.
  hardware.pulseaudio.enable = false;
  services.pipewire = {
  	enable = true;
  	pulse.enable = true;
  };

  hardware = {
    opengl =
      {
        enable = true;

        package = pkgs-unstable.mesa.drivers;
        package32 = pkgs-unstable.pkgsi686Linux.mesa.drivers;

        driSupport = true;
        driSupport32Bit = true;
      };

    # opentabletdriver.enable = true;
  };
}  

