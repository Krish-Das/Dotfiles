# custom.virtualization
#
# Enables libvirtd and virt-manager for running virtual machines.
#
# Usage:
#   custom.virtualization = {
#     enable = true;
#     user = "upsher";
#   };
#
# After rebuild, log out/in or run `newgrp libvirtd` for group membership.
{
  config,
  lib,
  ...
}: let
  cfg = config.custom.virtualization;
in {
  options.custom.virtualization = {
    enable = lib.mkEnableOption "virtualization support with libvirtd and virt-manager";
    user = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "User to add to the libvirtd group.";
    };
  };

  config = lib.mkIf cfg.enable {
    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;

    users.users = lib.mkIf (cfg.user != null) {
      ${cfg.user}.extraGroups = ["libvirtd"];
    };
  };
}
