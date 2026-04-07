{
  pkgs,
  lib,
  ...
}: let
  enableUnpackagedElectronRuntime = false;
in {
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs;
    lib.optionals enableUnpackagedElectronRuntime [
      # Runtime libraries for unpackaged binaries such as the VS Code
      # Insider tarball and other Electron apps.
      glib
      gtk3
      nspr
      nss
      dbus
      atk
      at-spi2-atk
      expat
      libdrm
      libxkbcommon
      libgbm # replaces mesa
      pango
      cairo
      alsa-lib
      libX11
      libXcomposite
      libXdamage
      libXext
      libXfixes
      libXrandr
      libxcb
      libxshmfence
      libXi
      libXtst
      libXcursor
      libXrender
      libXScrnSaver
      libxkbfile
      wayland
    ];
}
