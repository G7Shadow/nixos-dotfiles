{ config, pkgs, ... }:
{
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [
      telescope-nvim
      telescope-fzf-native-nvim
      plenary-nvim
      nvim-web-devicons
    ];

    extraConfigLua = ''
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      telescope.setup({
        defaults = {
          path_display = { "smart" },
          mappings = {
            i = {
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-j>"] = actions.move_selection_next,
            },
          },
        },
      })

      telescope.load_extension("fzf")
    '';

    keymaps = [
      {
        key = "<leader>ff";
        action = "<cmd>Telescope find_files<cr>";
        options.desc = "Fuzzy find files in cwd";
      }
      {
        key = "<leader>fr";
        action = "<cmd>Telescope oldfiles<cr>";
        options.desc = "Fuzzy find recent files";
      }
      {
        key = "<leader>fs";
        action = "<cmd>Telescope live_grep<cr>";
        options.desc = "Find string in cwd";
      }
      {
        key = "<leader>fc";
        action = "<cmd>Telescope grep_string<cr>";
        options.desc = "Find string under cursor in cwd";
      }
    ];
  };
}
