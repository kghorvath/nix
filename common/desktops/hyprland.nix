{ config, lib, inputs, pkgs, ... }:

{

  imports = [
    ./common/default.nix
    ./common/greetd.nix
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
    hyprlock
    hypridle
    hyprpaper
    hyprpolkitagent
  ];
}
