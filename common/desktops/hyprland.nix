{ config, lib, inputs, pkgs, ... }:

{

  imports = [
    ./common/default.nix
    ./common/gdm.nix
  ];

  programs = {
    hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
    };
    
  };

  security.pam.services.hyprlock = {};

  environment.systemPackages = with pkgs; [
    brightnessctl
    hyprlock
    hypridle
    hyprpaper
    hyprpolkitagent
    waybar
    wofi
  ];
}
