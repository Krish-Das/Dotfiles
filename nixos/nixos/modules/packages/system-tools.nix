{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    system-config-printer
    simple-scan

    wl-clipboard
    cliphist

    # Lets niri expose DISPLAY and run X11-only/fallback apps under Xwayland.
    xwayland-satellite

    quickshell
    libnotify
    swaynotificationcenter

    pavucontrol

    tofi
    fuzzel
  ];

  programs.appimage.enable = true;
  programs.appimage.binfmt = false; # +258ms boot time if enabled
}
