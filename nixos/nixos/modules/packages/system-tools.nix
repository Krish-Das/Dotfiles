{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    system-config-printer
    appimage-run

    wl-clipboard
    cliphist

    libnotify
    swaynotificationcenter

    pavucontrol

    tofi
  ];
}
