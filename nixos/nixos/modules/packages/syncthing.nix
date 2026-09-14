# custom.syncthing
#
# Enables Syncthing...
#
# Usage:
#   custom.syncthing.enable = true;
#
#   custom.syncthing = {
#     enable = true;
#     override = false; # (defaults to true)
#     folder = {
#       path = "/home/upsher/Sync";
#       id = "k9wkd-t6vm9";
#       label = "Sync"; # (defaults to baseNameOf path)
#     };
#     # optional:
#     devices = {
#       "phone" = "id...";
#     };
#   };
{
  config,
  lib,
  ...
}: let
  cfg = config.custom.syncthing;
in {
  options.custom.syncthing = {
    enable = lib.mkEnableOption "Syncthing file synchronization";

    override = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Whether NixOS should override Syncthing devices (overrideDevices).";
    };

    folder = lib.mkOption {
      type = lib.types.submodule ({config, ...}: {
        options = {
          path = lib.mkOption {
            type = lib.types.str;
            default = "/home/upsher/Sync";
            description = "Local path for the sync folder; also created via systemd-tmpfiles.";
          };

          id = lib.mkOption {
            type = lib.types.str;
            default = baseNameOf config.path;
            defaultText = lib.literalExpression "baseNameOf path";
            description = "Syncthing folder ID (must match peers).";
          };

          label = lib.mkOption {
            type = lib.types.str;
            default = baseNameOf config.path;
            defaultText = lib.literalExpression "baseNameOf path";
            description = "Human-readable Syncthing folder label and settings key.";
          };
        };
      });
      default = {};
      description = "Declarative Syncthing folder (path, id, label).";
    };

    devices = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = {};
      example = {
        phone = "ABCDEFG-HIJKLMN-OPQRSTU-VWXYZ12-3456789-ABCDEFG-HIJKLMN-OPQRSTU";
      };
      description = "Map of Syncthing device name to device ID.";
    };
  };

  config = lib.mkIf cfg.enable {
    services.syncthing = {
      enable = true;
      user = "upsher";
      dataDir = "/home/upsher";
      configDir = "/home/upsher/.config/syncthing";
      openDefaultPorts = true; # opens 22000/tcp+udp, 21027/udp
      overrideDevices = cfg.override;
      overrideFolders = true;

      settings = {
        gui = {
          enabled = true;
          address = "127.0.0.1:8384";
        };
        options = {
          localAnnounceEnabled = true; # LAN discovery
          globalAnnounceEnabled = false; # no relay/external
          relaysEnabled = false;
          urAccepted = -1; # disable telemetry
        };

        devices = lib.mapAttrs (_name: id: {inherit id;}) cfg.devices;

        folders = {
          ${cfg.folder.label} = {
            id = cfg.folder.id;
            label = cfg.folder.label;
            path = cfg.folder.path;
            devices = lib.attrNames cfg.devices;
          };
        };
      };
    };

    # Create folder path
    systemd.tmpfiles.rules = [
      "d ${cfg.folder.path} 0755 upsher users -"
    ];

    networking.firewall = {
      allowedTCPPorts = [22000];
      allowedUDPPorts = [22000 21027];
    };
  };
}
