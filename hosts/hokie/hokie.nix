{ config, lib, inputs, pkgs, ... }:

{

  imports = [
    ./hardware-configuration.nix
  ];

  ## Bootloader Settings
  boot.loader = {
    systemd-boot = {
      enable = true;
      consoleMode = "max";
    };

    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
  };

  ## Network and Hostname
  networking = {
    hostName = "hokie";
    domain = "dir.sathani.com";
  };

  ## Allow domain users to manage networks
  users.groups.networkmanager.members = ["kamin"];

}
