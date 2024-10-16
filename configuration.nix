{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./desktop.nix
     ];

  # Enable Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader = {
    ## Use the systemd-boot EFI boot loader.
    # systemd-boot = {
      # enable = true;
      # consoleMode = "max";
    # };
    
    # Use the GRUB boot loader
    grub = {
      efiSupport = true;
      useOSProber = false;
      device = "nodev";
    };
    
    # EFI settings
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint="/boot/efi";
    };
  };

  # Set up hardware
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };
    
  # Set up networking
  networking.hostName = "hokie";
  networking.domain = "lan.kghorvath.com";
  networking.networkmanager.enable = true;

  # Time zone
  time.timeZone = "America/New_York";

  # Set environment variables
  environment.variables.EDITOR = "vim";

  # User accounts
  users.users.khorvath= {
    isNormalUser = true;
    description = "Kamin Horvath";
    shell = pkgs.fish;
    extraGroups = [ "wheel" "networkmanager" "libvirtd" "kvm" ];
    packages = with pkgs; [   ]; 
  };

  # System packages
  environment.systemPackages = with pkgs; [
    vim virt-manager podman-tui docker-compose kitty waybar wofi hyprlock hypridle hyprpaper hyprshot lxqt.lxqt-policykit swaynotificationcenter ];

  # Font packages
  fonts.packages = with pkgs; [
    cascadia-code
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    font-awesome
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    powerline-fonts
    powerline-symbols
  ];

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  programs.fish.enable = true;

  # Enabled services
  services = {
    blueman.enable = true;
    libinput.enable = true;
    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
	};
    };
    tailscale = {
      enable = true;
      useRoutingFeatures = "client";
    };
    printing.enable = true;
    thermald = {
      enable = true;
      configFile = ./conf.d/thermal-conf.xml;
    };
    gnome.gnome-keyring.enable=true;
  };

  # Security
  security.pam.services.hyprlock = {};

  # Virtualization support
  virtualisation.libvirtd = {
    enable = true;
    onBoot = "start";
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

