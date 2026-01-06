{ config, lib, inputs, pkgs, ... }:

{

  imports = [
    ./drivers/power.nix
  ];

  ## Enable libinput
  services.libinput.enable = true;

  ## Enable bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  services.blueman.enable = true;

}
