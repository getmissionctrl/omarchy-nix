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

    # Optionally load a monitor layout written by an external tool such as
    # nwg-displays (~/.config/hypr/monitors.conf). A glob is used so that a
    # missing file is silently ignored (a literal `source` to an absent file
    # is a Hyprland config error). Because "source" sorts after "monitor" in
    # the generated config, these directives override `cfg.monitors` above
    # whenever the file is present, letting the GUI own the live layout while
    # `cfg.monitors` remains the declarative fallback.
    source = [ "~/.config/hypr/monitors*.conf" ];
  };
}
