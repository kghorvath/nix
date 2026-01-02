{ config, lib, inputs, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    emacs-pgtk
    hugo
    libreoffice
    octaveFull
    typst
    xournalpp
  ];

}
