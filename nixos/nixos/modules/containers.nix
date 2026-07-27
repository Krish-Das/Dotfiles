# custom.containers
#
# Enables Podman with Docker-compatible commands and installs Distrobox.
#
# Usage:
#   custom.containers.enable = true;
{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.custom.containers;
in {
  options.custom.containers = {
    enable = lib.mkEnableOption "container support with Podman and Distrobox";
  };

  config = lib.mkIf cfg.enable {
    virtualisation.containers.enable = true;
    virtualisation.podman = {
      enable = true;
      dockerCompat = true;
    };

    environment.systemPackages = [pkgs.distrobox];
  };
}
