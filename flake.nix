{
  description = "A simple NixOS flake";

  nixConfig = {
    extra-substituters = [
	"https://wezterm.cachix.org"
    ];
    extra-trusted-public-keys = [
	"wezterm.cachix.org-1:kAbhjYUC9qvblTE+s7S+kl5XM1zVa4skO+E/1IDWdH0="
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
      };
    wezterm = {
      url = "github:wez/wezterm?dir=nix";
    };
  };

  outputs = { self, nixpkgs, nixos-hardware, home-manager, ... }@inputs: {
    nixosConfigurations.hokie = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        # Import the previous configuration.nix we used,
        # so the old configuration file still takes effect
        ./configuration.nix
	
	# Import home-manager
	home-manager.nixosModules.home-manager
	{  
	  home-manager.useGlobalPkgs = true;
	  home-manager.useUserPackages = true;
	  home-manager.backupFileExtension = "bak";
	  home-manager.users.khorvath = import ./home/home.nix;
	  home-manager.extraSpecialArgs = { inherit inputs; };
	}

	# Add surface hardware support
	nixos-hardware.nixosModules.microsoft-surface-pro-intel
      ];
    };
  };
}
