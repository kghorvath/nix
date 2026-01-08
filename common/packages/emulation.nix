{ config, lib, inputs, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    _86Box-with-roms
    dosbox-staging
    dosbox-x
  ];

}
