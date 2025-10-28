{pkgs, ...}: {
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
  ];
}
