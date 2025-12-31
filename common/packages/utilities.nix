{ config, lib, inputs, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    alacarte
    distrobox
    ghostty
    jdk
    transmission_4-gtk
    virt-manager
  ];

}
