{ config, lib, inputs, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    bitwarden-desktop
    element-desktop
    thunderbird
    vesktop
    vivaldi
    vivaldi-ffmpeg-codecs
    widevine-cdm
  ];

}
