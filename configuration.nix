# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [
      <nixos-hardware/microsoft/surface/surface-pro-intel>
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint="/boot/efi";

  # Set up networking
  networking.hostName = "hokie";
  networking.networkmanager.enable = true;

  #Time zone
  time.timeZone = "America/New_York";

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;

    # Enable GNOME
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;

    # Enable KDE
    # displayManager.sddm.wayland.enable = true;
    # desktopManager.plasma6.enable = true;

    xkb.layout = "us";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  hardware.pulseaudio.enable = false;
  services.pipewire = {
  	enable = true;
  	pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.khorvath= {
    isNormalUser = true;
    description = "Kamin Horvath";
    extraGroups = [ "wheel" "networkmanager" "libvirt" ];
    packages = with pkgs; [
      firefox libreoffice neofetch openttd thunderbird wezterm
      ]; 
  };

  # System packages
  environment.systemPackages = with pkgs; [
    vim wget emacs virt-manager stow git podman-tui docker-compose distrobox
    ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Enabled services
  services = {
    libinput.enable = true;
    openssh.enable = true;
    thermald = {
      enable = true;
      configFile = ./conf.d/thermal-conf.xml;
    };
  };

  # Virtualization support
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
      ovmf = {
        enable = true;
        packages = [(pkgs.OVMF.override {
          secureBoot = true;
          tpmSupport = true;
        }).fd];
      };
    };
  };

  # Container support
  virtualisation.containers.enable = true;
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
  };
  
  system.stateVersion = "24.05";
}

