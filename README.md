# LazyVim Neovim Configuration

A modern Neovim setup bootstrapped with LazyVim plugin manager, featuring LSP support, Treesitter syntax highlighting, and productivity enhancements.

![Neovim screenshot](./src/Neovim-Dashboard.png)
![Neovim screenshot](./src/Neovim-Code-completion.png)
![Neovim screenshot](./src/Neovim-fzf-picker.png)

## Features

- **Plugin Management**: Powered by [lazy.nvim](https://github.com/folke/lazy.nvim)
- **Language Support**:
  - Lua, JavaScript, TypeScript, CSS, HTML, JSON, Bash, Nix
  - LSP configuration for intelligent code completion
- **Syntax Highlighting**: Treesitter-based for accurate parsing
- **File Navigation**:
  - Nvim-tree file explorer
  - Oil.nvim file operations
  - Fzf-lua fuzzy finder
- **Code Formatting**: Conform.nvim with formatters for multiple languages
- **Color Scheme**: Rose Pine

## Installation

1. Clone this repository to your Neovim config directory:

   ```bash
   git clone https://github.com/Krish-Das/Dotfiles -b neovim/main ~/.config/nvim
   ```

2. Start Neovim:

   ```bash
   nvim
   ```

3. Lazy will automatically install all plugins on first launch.

## Requirements

- Neovim 0.12+ (pre-release as of 2025)
- Git
- [fzf](https://search.nixos.org/packages?show=fzf) - Command-line fuzzy finder
- [ripgrep](https://search.nixos.org/packages?show=ripgrep) - Fast text search tool (required for live grep functionality)
- Language servers (automatically managed by Mason):
  - Lua (lua-language-server)
  - JavaScript/TypeScript (typescript-language-server)
  - CSS/HTML/JSON (css-lsp, html-lsp, json-lsp)
  - Shell scripts (bash-language-server)
  - Nix (nixd) - Must be installed separately via system package manager
- Formatters (managed by Mason):
  - Lua (stylua)
  - Nix (alejandra) - May need manual installation
  - Web formats (biome, prettierd)
  - Shell scripts (shfmt)
- Optional system packages for Nix LSP:
  - [nixd](https://search.nixos.org/packages?show=nixd) (language server)
  - [alejandra](https://search.nixos.org/packages?show=alejandra) (formatter)
  - Alternatively, you may install these using `:MasonToolsInstall` within Neovim
