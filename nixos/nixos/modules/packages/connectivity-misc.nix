{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    scrcpy
    yaak
    unzip
    wget
  ];
}
