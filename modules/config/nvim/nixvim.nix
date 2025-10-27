{
  config,
  pkgs,
  inputs,
  ...
}:
{

  imports = [
    inputs.nixvim.homeModules.nixvim

    # Core configuration
    ./core/colorscheme.nix
    ./core/options.nix
    ./core/keymaps.nix

    # UI plugins
    ./plugins/lualine.nix
    ./plugins/nvim-tree.nix
    ./plugins/bufferline.nix
    ./plugins/indent-blankline.nix
    ./plugins/alpha.nix
    ./plugins/dressing.nix

    # Functional plugins (order matters here)
    ./plugins/treesiter.nix # Treesitter should come before LSP
    ./plugins/blink-cmp.nix # Completion should come before LSP
    ./plugins/lsp.nix # LSP depends on treesitter and completion

    ./plugins/telescope.nix
    ./plugins/autosession.nix
  ];

  programs.nixvim.enable = true;
}
