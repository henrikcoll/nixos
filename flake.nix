{
	description = "henriks system";

	inputs = {
		nixpkgs.url = "nixpkgs/nixos-unstable";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows ="nixpkgs";
		};
		mangowc = {
		  url = "github:DreamMaoMao/mangowc";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { nixpkgs, home-manager, mangowc, ... }: {
		nixosConfigurations.titan = nixpkgs.lib.nixosSystem {
			modules = [
				./configuration.nix
				home-manager.nixosModules.home-manager {
					home-manager = {
						useGlobalPkgs = true;
						useUserPackages = true;
						users.henrik = import ./home.nix;
						backupFileExtension = "backup";
					};
				}
				mangowc.nixosModules.mango
			];
		};
	};
}
