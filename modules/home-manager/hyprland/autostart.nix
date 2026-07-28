{
  config,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      # "hypridle & mako & waybar & fcitx5"
      # "waybar"
      # "swaybg -i ~/.config/omarchy/current/background -m fill"
      "hyprsunset"
      "systemctl --user start hyprpolkitagent"
      "wl-clip-persist --clipboard regular & clipse -listen"

      # "dropbox-cli start"  # Uncomment to run Dropbox
    ];

    # waybar is started as a systemd user service (programs.waybar.systemd.enable
    # in waybar.nix), not via a Hyprland exec. Launching it here as well would
    # spawn a second, unsupervised instance.
  };
}
