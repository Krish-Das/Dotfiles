{pkgs, ...}: {
  programs.java.enable = true;
  programs.lazygit.enable = true;
  programs.zsh.enable = true;
  programs.tmux.enable = true;
  programs.adb.enable = true;
  programs.nh.enable = true;

  environment.systemPackages = with pkgs; [
    # editors
    vim
    neovim
    zed-editor-fhs
    # zed-editor
    git
    gh

    # runtimes
    gcc
    nodejs
    cargo

    tree-sitter
    typst
    stow
    jq
  ];
}
