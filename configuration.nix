{ config, pkgs, lib, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-original"
    "steam-unwrapped"
    "steam-run"
    "discord"
    "obsidian"
    "1password"
    "1password-cli"
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "titan";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Oslo";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "nb_NO.UTF-8";
    LC_IDENTIFICATION = "nb_NO.UTF-8";
    LC_MEASUREMENT = "nb_NO.UTF-8";
    LC_MONETARY = "nb_NO.UTF-8";
    LC_NAME = "nb_NO.UTF-8";
    LC_NUMERIC = "nb_NO.UTF-8";
    LC_PAPER = "nb_NO.UTF-8";
    LC_TELEPHONE = "nb_NO.UTF-8";
    LC_TIME = "nb_NO.UTF-8";
  };

  security.rtkit.enable = true;

  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.openssh.enable = true;

  #services.getty.autologinUser = "henrik";

  services.pcscd.enable = true;
  programs.gnupg.agent = {
     enable = true;
     enableSSHSupport = true;
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  console.keyMap = "no";

  users.users.henrik = {
    isNormalUser = true;
    description = "henrik";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  programs.firefox.enable = true;

  programs.steam = {
    enable = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  programs._1password = {
    enable = true;
  };

  programs._1password-gui = {
    enable = true;
  };

  #programs.mango.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    kitty
    waybar
    git
    gnupg
    rofi
    wl-clipboard
    grim
    slurp
    pavucontrol
    pinentry-curses
    mpvpaper
    socat
    uwsm
    wlr-randr
    xdg-desktop-portal
    xdg-desktop-portal-wlr
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    age-plugin-yubikey
  ];

  programs.xwayland.enable = true;

  qt = { enable = true; };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs.mango.enable = true;

  system.stateVersion = "25.05";

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

  age.identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

  age.secrets.syncthing-cert = {
    file = ./secrets/titan/syncthing/cert.pem.age;
    group = "users";
    owner = "henrik";
  };

  age.secrets.syncthing-key = {
    file = ./secrets/titan/syncthing/key.pem.age;
    group = "users";
    owner = "henrik";
  };

  services.syncthing = {
    enable = true;
    group = "users";
    user = "henrik";
    configDir = "/home/henrik/.config/syncthing";
    dataDir = "/home/henrik/Sync";
    key = config.age.secrets.syncthing-key.path;
    cert = config.age.secrets.syncthing-cert.path;
    settings = {
      openDefaultPorts = true;
      devices = {
        "fatshark" = { id = "IFSKHIE-ZDHMFIL-5JLMN5K-SJO4BZ3-3LFZWU4-P6DRFF2-QPDOAEE-DM5XCA7"; } ;
      };
      folders = {
        "Documents" = {
          path = "/home/henrik/Documents";
          devices = [ "fatshark" ];
        };
        "Videos" = {
          path = "/home/henrik/Videos";
          devices = [ "fatshark" ];
        };
        "Pictures" = {
          path = "/home/henrik/Pictures";
          devices = [ "fatshark" ];
        };
      };
    };
  };
}
