{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.omarchy;
in {
  imports = [
    ./autostart.nix
    ./bindings.nix
    ./envs.nix
    ./input.nix
    ./looknfeel.nix
    ./windows.nix
  ];
  wayland.windowManager.hyprland.settings = {
    # Default applications
    "$terminal" = lib.mkDefault "ghostty";
    "$fileManager" = lib.mkDefault "nautilus --new-window";
    "$browser" = lib.mkDefault "chromium --new-window --ozone-platform=wayland";
    "$music" = lib.mkDefault "spotify";
    "$passwordManager" = lib.mkDefault "1password";
    "$messenger" = lib.mkDefault "signal-desktop";
    "$webapp" = lib.mkDefault "$browser --app";

    monitor = cfg.monitors;
  };

  # Optionally load a monitor layout written by an external tool such as
  # nwg-displays (~/.config/hypr/monitors.conf). Appended via extraConfig with
  # mkAfter so it lands at the very end of hyprland.conf, after the `monitor`
  # defaults above — Hyprland inlines a sourced file where the directive
  # appears, so a later `monitor=` overrides the earlier one, letting the GUI
  # own the live layout while `cfg.monitors` stays the declarative fallback.
  # The glob makes a missing file a silent no-op rather than a config error.
  wayland.windowManager.hyprland.extraConfig = lib.mkAfter ''
    source = ~/.config/hypr/monitors*.conf
  '';
}
