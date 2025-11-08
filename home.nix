{ config, pkgs, ... }:

{

  home.username = "henrik";
  home.homeDirectory = "/home/henrik";
  home.stateVersion = "25.05";

  programs.bash = {
    enable = true;
    shellAliases = {
      nrs = "sudo nixos-rebuild switch --flake ~/nixos#titan";
    };
    #profileExtra = ''
    #  if [ -z "$SSH_CONNECTION" ] && [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = "1" ]; then
    #    exec mango
    #  fi
    #'';
    bashrcExtra = ''
      export GPG_TTY=$(tty)
      export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
      #gpgconf --launch gpg-agent
      #gpg-connect-agent updatestartuptty /bye > /dev/null
    '';

  };

  services.mako.enable = true;

  home.file.".config/hypr".source = ./config/hypr;
  home.file.".config/mango".source = ./config/mango;
  home.file.".config/kitty".source = ./config/kitty;
  home.file.".config/waybar".source = ./config/waybar;
  home.file.".config/zed".source = ./config/zed;
  home.file.".gitconfig".source = ./config/.gitconfig;

  #wayland.windowManager.mango = {
  #  enable = true;
  #  systemd.enable = true;
  #  autostart_sh = ''
  #      uwsm finalize SWAYSOCK I3SOCK XCURSOR_SIZE XCURSOR_THEME WAYLAND_DISPLAY XDG_CURRENT_DESKTOP &

  #      dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
  #      systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
  #  '';
  #};

  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    zed-editor
    discord
    obsidian

    (pkgs.writeShellApplication {
      name = "ns";
      runtimeInputs = with pkgs; [
        fzf
        (nix-search-tv.overrideAttrs {
          env.GOEXPERIMENT = "jsonv2";
        })
      ];
      text = ''exec "${pkgs.nix-search-tv.src}/nixpkgs.sh" "$@"'';
    })
  ];
}
