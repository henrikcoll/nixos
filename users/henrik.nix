{ pkgs, inputs,  ... }: {
  users.users.henrik = {
    isNormalUser = true;
    description = "henrik";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ vim kitty ];
  };
}
