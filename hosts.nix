{ inputs }:
let
  users = import ./users/users.nix { };
in {
  titan = {
    system = "x86_64-linux";
    stateVersion = "25.05";
    desktop = "mango";
    theme = "catppuccin";
    hostname = "titan";
    users = users;
    modules = [
      "ssh-server"
      "1password"
      "yubikey"
      "gaming"
    ];
  };
}
