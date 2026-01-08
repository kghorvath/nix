{ config, lib, inputs, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    alacarte
    distrobox
    ghostty
    jdk
    ifuse
    libimobiledevice
    opencloud-desktop
    transmission_4-gtk
    virt-manager
  ];

}
