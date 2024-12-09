{config, lib, pkgs, inputs, ... }: let

    
in {

  imports = [
    #./greetd.nix
  ];

  # X Server Settings
  services.xserver = {
    enable = true;

    # Desktop Managers
    desktopManager = {
      gnome.enable = true;
      
    };

    displayManager = {
      gdm.enable = true;
    };
  };

  # Desktop Managers
  services.desktopManager = {
    #plasma6.enable = true;
  };

  # Display Managers
  services.displayManager = {
    defaultSession = "hyprland";
    sddm = {
      enable = false;
      enableHidpi = true;
      #wayland.enable = true;
    };
  };

 # Enable Hyprland
 programs.hyprland = {
   enable = true;
 };

 # Enable sound.
  hardware.pulseaudio.enable = false;
  services.pipewire = {
  	enable = true;
  	pulse.enable = true;
  };

  hardware.graphics.enable = true;
}  

