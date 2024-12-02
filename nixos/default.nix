{ config, lib, inputs, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./steam.nix
      ./virtualization.nix
      ];
     
   # Enable Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Blacklisting IPU6 modules because they currently break audio on the surface kernel
  boot.blacklistedKernelModules = [ 
    "ipu3_imgu"
    "intel-ipu6"
    "intel-ipu6-isys"
  ]; 

  # Disabling tmpfs so we don't run out of space on large builds
  boot.tmp = {
    useTmpfs = false;
    #tmpOnTmpfsSize = "12G";
    #cleanOnBoot = true;
  };
  
  boot.loader = {
    # Disabling systemd-boot because it doesn't scale well on hidpi screens
    # systemd-boot = {
      # enable = true;
      # consoleMode = "max";
    # };
    
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

  # Enable zram
  zramSwap.enable = true;

  # Set up networking
  networking.hostName = "hokie";
  networking.domain = "lan.kghorvath.com";
  networking.networkmanager.enable = true;

  # Time zone
  time.timeZone = "America/New_York";

  # Set environment variables
  environment.variables = {
    EDITOR = "vim";
  };

  # User accounts
  users = {
    mutableUsers = true;
    users.khorvath= {
      isNormalUser = true;
      description = "Kamin Horvath";
      shell = pkgs.fish;
      extraGroups = [ "wheel" "networkmanager" "libvirtd" "kvm" "vboxusers" ];
      packages = with pkgs; [   ]; 
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # System packages
  environment.systemPackages = with pkgs; [ vim nfs-utils lxqt.lxqt-policykit ];

  # Font packages
  fonts.packages = with pkgs; [
    cascadia-code
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
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

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  programs.fish.enable = true;

  # Enabled services
  services = {
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };	  
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
    printing = {
      enable = true;
      drivers = [ pkgs.brlaser ];
    };
    nfs.server.enable = true;
    rpcbind.enable = true;
    thermald = {
      enable = true;
      configFile = ./conf.d/thermal-conf.xml;
    };
    gnome.gnome-keyring.enable=true;
  };

  # Security
  security = {
    pam.services.hyprlock = {};
    sudo = {
      execWheelOnly = true;
      wheelNeedsPassword = true;
    };
  };

   # Enable polkit
  security.polkit.enable = true;
 
  system.stateVersion = "24.05";
}
