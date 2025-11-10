{ inputs }:
({
  system,
  stateVersion,
  theme,
  desktop,
  users,
  hostname,
  modules
}:
let
  inherit (inputs) nixpkgs;

  pkgs = import nixpkgs {
    inherit system;
  };

  themeConfig = import ../themes/${theme}.nix { inherit inputs pkgs; };
  hardwareConfig = ../hosts/${hostname}/hardware-configuration.nix;
  desktopConfig = import ../desktops/${desktop}.nix { inherit inputs pkgs; };
  commonConfig = import ./common.nix { inherit inputs pkgs hostname stateVersion; };

  enabledModules = pkgs.lib.imap0 (i: name: ( import ../modules/${name}.nix { inherit inputs pkgs; })) modules;

in nixpkgs.lib.nixosSystem {
  inherit system;
  modules = [ commonConfig hardwareConfig desktopConfig ] ++ enabledModules;
})
