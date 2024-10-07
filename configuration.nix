# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [
      <nixos-hardware/microsoft/surface/surface-pro-intel>
      /etc/nixos/hardware-configuration.nix
      ./desktop.nix
      ./shell.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.consoleMode = "max";
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint="/boot/efi";

  # Set up networking
  networking.hostName = "hokie";
  networking.networkmanager.enable = true;

  #Time zone
  time.timeZone = "America/New_York";

  # User accounts
  users.users.khorvath= {
    isNormalUser = true;
    description = "Kamin Horvath";
    shell = pkgs.fish;
    extraGroups = [ "wheel" "networkmanager" "libvirtd" "kvm" ];
    packages = with pkgs; [
      wezterm webcord _86Box xournalpp calibre pinta dosbox-x
      ]; 
  };

  # System packages
  environment.systemPackages = with pkgs; [
    vim wget emacs29-pgtk virt-manager stow firefox thunderbird libreoffice nextcloud-client neofetch git podman-tui remmina docker-compose distrobox kitty waybar wofi hyprlock hypridle hyprpaper hyprshot lxqt.lxqt-policykit progress brightnessctl    ];

  # Font packages
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
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
    printing.enable = true;
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

