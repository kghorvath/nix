{ config, lib, inputs, pkgs, ... }:

{

  ## Enable unfree packages
  nixpkgs.config.allowUnfree = true;

  ## Common system packages
  environment.systemPackages = with pkgs; [
    bchunk
    git
    htop
    ipmitool
    jq
    neofetch
    neovim
    nfs-utils
    progress
    stow
    terminus_font
    unzip
    vim
    wget
    xmlstarlet
  ];

}
