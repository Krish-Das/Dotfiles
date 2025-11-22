{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    system-config-printer

    wl-clipboard
    cliphist

    libnotify
    swaynotificationcenter

    pavucontrol

    tofi
  ];

  programs.appimage.enable = true;
  programs.appimage.binfmt = true;
}
