{ config, lib, inputs, pkgs, ... }:

{

  ## Enable libinput
  services.libinput.enable = true;

  ## Enable bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  services.blueman.enable = true;

}
