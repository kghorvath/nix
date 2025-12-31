{ config, lib, inputs, pkgs, ... }:

{

  ## Enable unfree packages
  nixpkgs.config.allowUnfree = true;

  ## Common system packages
  environment.systemPackages = with pkgs; [
    bchunk
    emacs
    htop
    ipmitool
    jq
    neofetch
    neovim
    nfs-utils
    progress
    stow
    wget
    unzip
    vim
    xmlstarlet
  ];

}
