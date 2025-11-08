#!/usr/bin/env bash
uwsm finalize SWAYSOCK I3SOCK XCURSOR_SIZE XCURSOR_THEME WAYLAND_DISPLAY XDG_CURRENT_DESKTOP &
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP

wlr-randr --output DP-3 --mode 3440x1440@144

sleep 1 && mpvpaper DP-3 /home/henrik/Videos/wallpapers/ -o "--loop-playlist --loop --panscan=1 input-ipc-server=/run/user/1000/mpv" &
