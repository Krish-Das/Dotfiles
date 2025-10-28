{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    alacritty
    ghostty
    wezterm
    fzf
    eza
    bat
    fd
    ripgrep
    trash-cli
    bottom
    procs
    fastfetch
    yazi
    thokr
  ];
}
