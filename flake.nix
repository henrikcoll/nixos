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
		agenix.url = "github:ryantm/agenix";
	};

	outputs = { self, nixpkgs, home-manager, mangowc, agenix, ... }: {
		nixosConfigurations.titan = nixpkgs.lib.nixosSystem {
		  system = "x86_64-linux";
			modules = [
				./configuration.nix
				home-manager.nixosModules.home-manager {
					home-manager = {
						useGlobalPkgs = true;
						useUserPackages = true;
						users.henrik = import ./home.nix;
						backupFileExtension = "backup";
  					sharedModules = [
              #mangowc.hmModules.mango { }
              agenix.homeManagerModules.default
  					];
					};
				}
				mangowc.nixosModules.mango
				agenix.nixosModules.default
  		  { environment.systemPackages = [ agenix.packages.x86_64-linux.default ]; }
			];
		};
	};
}
