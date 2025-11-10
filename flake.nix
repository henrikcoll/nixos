{
	description = "NixOS Config";

	inputs = {
		nixpkgs.url = "nixpkgs/nixos-unstable";
		agenix.url = "github:ryantm/agenix";
		mangowc.url = "github:DreamMaoMao/mangowc";

		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows ="nixpkgs";
		};
	};

	outputs = inputs@{ self, nixpkgs, home-manager, mangowc, agenix, ...}:
	  let
			make-system = import ./util/make-system.nix { inherit inputs; };
			hosts = import ./hosts.nix { inherit inputs; };
		in {
		  nixosConfigurations =
				nixpkgs.lib.mapAttrs (name: config: make-system config) hosts;
		};
}

	#outputs = { self, nixpkgs, home-manager, mangowc, agenix, ... }: {
	#	nixosConfigurations.titan = nixpkgs.lib.nixosSystem {
	#	  system = "x86_64-linux";
	#		modules = [
	#			./configuration.nix
	#			home-manager.nixosModules.home-manager {
	#				home-manager = {
	#					useGlobalPkgs = true;
	#					useUserPackages = true;
	#					users.henrik = import ./home.nix;
	#					backupFileExtension = "backup";
  #					sharedModules = [
  #            #mangowc.hmModules.mango { }
  #            agenix.homeManagerModules.default
  #					];
  #				};
  #			}
	#			mangowc.nixosModules.mango
	#			agenix.nixosModules.default
  #		  { environment.systemPackages = [ agenix.packages.x86_64-linux.default ]; }
	#		];
	#	};
	#};
#}
