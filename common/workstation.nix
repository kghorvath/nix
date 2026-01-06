{ config, lib, inputs, pkgs, ... }:

{

  imports = [
    ./flatpak.nix
    ./packages/common.nix
    ./packages/games.nix
    ./packages/internet.nix
    ./packages/multimedia.nix
    ./packages/productivity.nix
    ./packages/utilities.nix
    ./drivers/print.nix
  ];

  ## Workstation specific services
  services = {
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
	  
    blueman.enable = true;
  };

  ## Workstation specific SSH settings
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

  ## Workstation specific Tailscale settings
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
  };

  ## Workstation security settings
  security = {
    sudo = {
      enable = true;
      execWheelOnly = true;
      wheelNeedsPassword = true;
    };

    polkit.enable = true;
  };
  users.groups.wheel.members = ["kamin"];


}
