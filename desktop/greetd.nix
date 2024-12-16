{ config, lib, pkgs, inputs, ... }:

{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland}/bin/Hyprland";
      };
    };
  };
}