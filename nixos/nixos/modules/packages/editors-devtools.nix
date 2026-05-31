{pkgs, ...}: {
  programs = {
    vim.enable = true;
    neovim.enable = true;
    git.enable = true;
    java.enable = true;
    lazygit.enable = true;
    zsh.enable = true;
    tmux.enable = true;
    nh.enable = true;
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
  };

  environment.systemPackages = with pkgs; [
    gh
    delta
    starship

    gcc
    nodejs
    cargo

    typst
    stow

    android-tools
  ];
}
