{ config, lib, inputs, pkgs, ... }:

{

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
      execWheelOnly = true;
      wheelNeedsPassword = true;
    };

    polkit.enable = true;
  };

}
