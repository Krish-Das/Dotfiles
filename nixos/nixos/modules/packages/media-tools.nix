{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    ffmpeg
    wf-recorder
    mpv
    feh
    grim
    slurp
    swww
  ];
}
