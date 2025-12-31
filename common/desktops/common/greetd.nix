{ config, lib, inputs, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    greetd.gtkgreet
    cage
  ];

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.cage}/bin/cage -s -- ${pkgs.greetd.gtkgreet}/bin/gtkgreet -l -c Hyprland";
        user = "greeter";
      };
    };
  };
  security.pam.services.greetd.enableGnomeKeyring = true;

  environment.etc."greetd/environments".text = ''
    Hyprland
    bash
  '';

}
