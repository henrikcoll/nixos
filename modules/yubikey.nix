{ pkgs, inputs,  ... }: {
  services.pcscd.enable = true;
  programs.gnupg.agent = {
     enable = true;
     enableSSHSupport = true;
  };

  environment.systemPackages = with pkgs; [
    age-plugin-yubikey
    gnupg
    pinentry-curses
  ];
}
