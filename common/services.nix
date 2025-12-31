{ config, lib, inputs, pkgs, ... }:

{

  services = {

    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

}
