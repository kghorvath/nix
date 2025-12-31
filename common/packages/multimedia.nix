{ config, lib, inputs, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    ffmpeg-full
    gimp-with-plugins
    krita
    pinta
    vlc
    yt-dlp
  ];

}
