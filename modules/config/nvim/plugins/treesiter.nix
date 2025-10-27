{ config, pkgs, ... }:
{
  programs.nixvim = {
    plugins.treesitter.enable = true;

    extraConfigLua = ''
      require("nvim-treesitter.configs").setup({
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
        },
        ensure_installed = {
          "bash", "c", "cpp", "css", "html", 
          "java", "javascript", "lua", "json", "python", "nix", "hyprlang",
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = false,
            node_decremental = "<bs>",
          },
        },
        parser_install_dir = vim.fn.stdpath("data") .. "/treesitter",
      })

      vim.opt.runtimepath:append(vim.fn.stdpath("data") .. "/treesitter")
      vim.treesitter.language.register("bash", "zsh")
    '';
  };
}
