{ config, lib, inputs, pkgs, ... }:

{

  imports = [
    ./fonts.nix
    ./packages/common.nix
    ./programs.nix
    ./services.nix
    ./virtualization.nix
  ];

  ## Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  ## Enable ZRAM
  zramSwap.enable = true;

  ## Timezone
  time.timeZone = "America/New_York";

  ## Networking
  networking.networkmanager.enable = true;

  ## Environment Variables
  environment.variables = {
    EDITOR = "vim";
  };


  system.stateVersion = "25.11";

}
