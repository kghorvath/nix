{ config, lib, inputs, pkgs, ... }:

{
  programs.steam = {
    enable = true;
    localNetworkGameTransfers.openFirewall = true;
  };

}