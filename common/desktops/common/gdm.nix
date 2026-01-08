{ config, lib, inputs, pkgs, ... }:

{

  services.displayManager.gdm.enable = true;

  services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = true;
  environment.systemPackages = [ pkgs.libsecret ];
  security.pam.services.gdm.enableGnomeKeyring = true;

}
