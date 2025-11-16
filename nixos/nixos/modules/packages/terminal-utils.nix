{pkgs, ...}: {
  programs = {
    bat.enable = true;
  };

  environment.systemPackages = with pkgs; [
    alacritty
    ghostty
    wezterm
    fzf
    eza
    fd
    ripgrep
    trash-cli
    bottom
    procs
    fastfetch
    thokr
    yazi
  ];
}
