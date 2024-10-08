{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
      };
  };

  outputs = { self, nixpkgs, nixos-hardware, home-manager, ... }@inputs: {
    nixosConfigurations.hokie = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        # Import the previous configuration.nix we used,
        # so the old configuration file still takes effect
        ./configuration.nix

	# Import home-manager
	home-manager.nixosModules.home-manager
	{  
	  home-manager.useGlobalPkgs = true;
	  home-manager.useUserPackages = true;
	  home-manager.users.khorvath = import ./home.nix;
	}
	  
	# Add surface hardware support
	nixos-hardware.nixosModules.microsoft-surface-pro-intel
      ];
    };
  };
}
