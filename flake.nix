{
  description = "My (new) flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixgl.url = "github:nix-community/nixGL";
  };

  outputs = { self, nixpkgs, nixgl, ... }: {
    nixosConfigurations = {

      ## Main laptop configuration
      hokie = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
	modules = [
	  ./common/base.nix
	  ./common/workstation.nix
	  ./common/laptop.nix
	  ./common/domain.nix
	  ./common/desktops/hyprland.nix
	  ./common/desktops/niri.nix
	  ./common/drivers/intel.nix
	  ./hosts/hokie/hokie.nix

	];
      };

      ## Future hardware configurations go here

    };
  };
}
