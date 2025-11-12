{pkgs, ...}: {
  programs = {
    vim.enable = true;
    neovim.enable = true;
    git.enable = true;
    java.enable = true;
    lazygit.enable = true;
    zsh.enable = true;
    tmux.enable = true;
    adb.enable = true;
    nh.enable = true;
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
  };

  environment.systemPackages = with pkgs; [
    zed-editor-fhs
    # zed-editor
    gh
    # commitizen # To create conventional commits. Visit https://github.com/commitizen-tools/commitizen

    gcc
    nodejs
    cargo

    typst
    stow
    jq
  ];
}
