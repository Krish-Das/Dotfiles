{pkgs, ...}: {
  programs = {
    bat.enable = true;
  };

  environment.systemPackages = with pkgs; [
    wezterm
    fzf
    eza
    fd
    ripgrep
    trash-cli
    btop
    procs
    fastfetch
    thokr
    yazi
  ];

  environment.sessionVariables = {
    RIPGREP_CONFIG_PATH = "\${HOME}/.config/ripgrep/config";
  };
}
