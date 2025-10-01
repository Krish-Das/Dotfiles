{
  pkgs,
  lib,
  ...
}: {
  # ------------------------------
  # Thunar & its plugins
  # ------------------------------
  programs.thunar = {
    enable = true;

    plugins = with pkgs.xfce; [
      thunar-archive-plugin # archive handling (zip, tar, …)
      thunar-volman # removable‑media auto‑mount
    ];
    # If you also want the “trash” integration you can add
    # pkgs.xfce.thunar-dropbox-plugin or any other plugin that ships as a package.
  };

  # ------------------------------
  # Thumbnail generation (tumbler)
  # ------------------------------
  services.tumbler.enable = true; # runs the thumbnail daemon
  environment.systemPackages = with pkgs; [
    xfce.tumbler
    ffmpegthumbnailer
  ];
}
