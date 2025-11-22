{pkgs, ...}: {
  programs = {
    bat.enable = true;
  };

  environment.systemPackages = with pkgs; [
    alacritty
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
