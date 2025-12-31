{ config, lib, inputs, pkgs, ... }:

{

  fonts.enableDefaultPackages = true;

  fonts.packages = with pkgs; [
    cascadia-code
    noto-fonts
    noto-fonts-cjk-sans
    fira-code
    fira-code-symbols
    font-awesome
    hack-font
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    powerline-fonts
    powerline-symbols
  ];

}
