{ config, lib, inputs, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    freeciv
    openttd
  ];

  programs.steam = {
    enable = true;
    localNetworkGameTransfers.openFirewall = true;
  };

}
