{ config, lib, inputs, pkgs, ... }:

{

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      libvdpau-va-gl
    ];
  };

  environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; };

  environment.systemPackages = [
    (pkgs.appimage-run.override {
      extraPkgs = pkgs: [ 
        pkgs.libglvnd
        pkgs.mesa.drivers
	pkgs.intel-vaapi-driver # Hardware video acceleration
      	pkgs.intel-media-driver # Hardware video acceleration (newer)
      	pkgs.libva            # VAAPI support 
      ];
    })
  ];
}
