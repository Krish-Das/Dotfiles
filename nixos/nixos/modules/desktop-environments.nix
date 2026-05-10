{
  pkgs,
  lib,
  ...
}: {
  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  programs.niri.enable = true;

  programs.xwayland.enable = true;

  # Portal routing for Wayland compositors.
  # Keep defaults simple; route niri capture interfaces explicitly.
  xdg.portal = {
    enable = true;
    # wlr.enable = true;

    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
      xdg-desktop-portal-hyprland
    ];

    config = {
      common.default = ["gtk"];
      hyprland.default = ["hyprland" "gtk"];

      # Use GNOME portal only for niri screencast/screenshot.
      niri."org.freedesktop.impl.portal.ScreenCast" = lib.mkForce ["gnome"];
      niri."org.freedesktop.impl.portal.Screenshot" = lib.mkForce ["gnome" "gtk"];
    };
  };

  # Bridge niri startup to systemd graphical-session.target.
  # This ensures portal backends start reliably in niri sessions.
  systemd.user.targets.niri-session = {
    description = "Niri graphical session";
    bindsTo = ["graphical-session.target"];
    wants = ["graphical-session-pre.target" "graphical-session.target"];
    after = ["graphical-session-pre.target"];
  };
}
