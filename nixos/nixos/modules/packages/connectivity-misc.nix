{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    scrcpy
    unzip
    p7zip
    wget
    jq
  ];
}
