{ config, pkgs, ... }:
{
  programs.nixvim = {
    plugins.auto-session.enable = true;

    extraConfigLua = ''
      require("auto-session").setup({
        auto_restore_enabled = false,
        auto_session_suppress_dirs = { "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop/" },
      })
    '';

    keymaps = [
      {
        key = "<leader>wr";
        action = "<cmd>AutoSession restore<CR>";
        options = {
          desc = "Restore session for cwd";
        };
      }
      {
        key = "<leader>ws";
        action = "<cmd>AutoSession save<CR>";
        options = {
          desc = "Save session for auto session root dir";
        };
      }
    ];
  };
}
