{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    scrcpy
    yaak
    unzip
    p7zip
    wget
  ];
}
