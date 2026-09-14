{pkgs, ...}: let
in {
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      dbus # for GitButler CLI
    ];
  };
}
