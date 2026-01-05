{ config, lib, inputs, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    alacarte
    distrobox
    ghostty
    jdk
    opencloud-desktop
    transmission_4-gtk
    usbmuxd
    virt-manager
  ];

}
