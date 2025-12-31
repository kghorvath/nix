{ config, lib, inputs, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    hugo
    libreoffice
    octaveFull
    typst
    xournalpp
  ];

}
