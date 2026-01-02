{ config, lib, inputs, pkgs, ... }:

{

  services.flatpak.enable = true;

  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

}
