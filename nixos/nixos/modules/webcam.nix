# custom.webcam
#
# Loads v4l2loopback so a phone camera can be forwarded as a virtual webcam
# (e.g. via scrcpy).
#
# NOTE: if v4l2loopback is already loaded (e.g. after changing videoNr,
# cardLabel, or first enabling this), reload the module or reboot:
#   sudo rmmod v4l2loopback && sudo modprobe v4l2loopback
#
# Usage:
#   custom.webcam.enable = true;
#   or
#   custom.webcam = {
#     enable = true;
#     videoNr = 10;
#     cardLabel = "Phone Cam";
#   };
{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.custom.webcam;
in {
  options.custom.webcam = {
    enable = lib.mkEnableOption "virtual webcam via v4l2loopback for phone camera forwarding";

    videoNr = lib.mkOption {
      type = lib.types.int;
      default = 10;
      description = "Video device number for the loopback device (e.g. /dev/video10).";
    };

    cardLabel = lib.mkOption {
      type = lib.types.str;
      default = "Phone Cam";
      description = "Human-readable label exposed to applications selecting the camera.";
    };
  };

  config = lib.mkIf cfg.enable {
    boot.extraModulePackages = [config.boot.kernelPackages.v4l2loopback];
    boot.kernelModules = ["v4l2loopback"];
    # exclusive_caps=1 is required for Chromium/WebRTC (Google Meet, Zoom, etc.)
    boot.extraModprobeConfig = ''
      options v4l2loopback devices=1 video_nr=${toString cfg.videoNr} card_label="${cfg.cardLabel}" exclusive_caps=1
    '';

    environment.systemPackages = with pkgs; [v4l-utils];
  };
}
