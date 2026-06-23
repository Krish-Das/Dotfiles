{
  lib,
  pkgs,
  ...
}: {
  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [proton-ge-bin];
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true; # required — Steam ships 32-bit libs
  };

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "steam"
      "steam-unwrapped"
    ];
}
