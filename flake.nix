{
  description = "My NixOS flake";

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://hyprland.cachix.org"
      "https://wezterm.cachix.org"
	
      ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "wezterm.cachix.org-1:kAbhjYUC9qvblTE+s7S+kl5XM1zVa4skO+E/1IDWdH0="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";  
    nixos-hardware.url = "github:NixOS/nixos-hardware/feefc78";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Other programs
    hyprland = {
      url = "github:hyprwm/Hyprland/12f9a0d";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprlock.url = "github:hyprwm/hyprlock";
    hypridle.url = "github:hyprwm/hypridle";
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";  
    nixgl.url = "github:nix-community/nixGL";  
    swww.url = "github:LGFae/swww";  
    wezterm.url = "github:wez/wezterm?dir=nix";

    # Hyprland plugins
    hypr-dynamic-cursors = {
      url = "github:VirtCode/hypr-dynamic-cursors";
      inputs.hyprland.follows = "hyprland";
    };
  };

    outputs = {self, nixpkgs, nixos-hardware, nixgl, home-manager, hyprland, hyprpanel, ... } @ inputs:
    let
      inherit (self) outputs;
    in {
      nixosConfigurations = {
        hokie = nixpkgs.lib.nixosSystem {
	 system = "x86_64-linux";
	 specialArgs = {inherit inputs outputs;};
	 modules = [
	   ./nixos
	   ./desktop
	   (import ./overlays)
	   nixos-hardware.nixosModules.microsoft-surface-pro-intel

	   home-manager.nixosModules.home-manager {
	     home-manager = {
	       useGlobalPkgs = true;
	       useUserPackages = true;
	       users.khorvath = import ./home/khorvath.nix;
	       extraSpecialArgs = {inherit inputs outputs;};
	     };
	     nixpkgs.overlays = [ inputs.hyprpanel.overlay ];
	   }
	 ];
      };
    };

#    homeConfigurations = {
#      "khorvath@hokie" = home-manager.lib.homeManagerConfiguration {
#        pkgs = nixpkgs.legacyPackages.x86_64-linux;
#	extraSpecialArgs = {inherit inputs outputs;};
#	modules = [
#	  ./home/home.nix
#	];
#      };
#    };
  };
}
