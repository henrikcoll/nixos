{ pkgs, inputs,  ... }: {
  imports = [
    inputs.mangowc.nixosModules.mango
  ];

  environment.systemPackages = with pkgs; [
    kitty
    waybar
    rofi
    wl-clipboard
    grim
    slurp
    pavucontrol
    mpvpaper
    socat
    uwsm
    wlr-randr
    xdg-desktop-portal
    xdg-desktop-portal-wlr
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
  ];

  security.rtkit.enable = true;

  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  programs.xwayland.enable = true;

  qt = { enable = true; };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  programs.mango.enable = true;

  programs.uwsm = {
    enable = true;
    waylandCompositors.mango = {
      binPath = "/run/current-system/sw/bin/mango";
      prettyName = "Mango";
      comment = "Mango compositor with UWSM";
    };
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-wlr ];
    config = {
      mango = {
        default = [ "wlr" "gtk" ];
        "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
      };
    };
    xdgOpenUsePortal = true;
  };

  services.greetd = { enable = true; };
  security.pam.services.greetd.enable = true;
  programs.regreet = {
    enable = true;
    cageArgs = [ "-s" "-m" "last" ];
  };

  services.greetd.settings = {
    initial_session = {
      command = "${pkgs.uwsm}/bin/uwsm start /run/current-system/sw/bin/mango";
      user = "henrik";
    };
  };
}
