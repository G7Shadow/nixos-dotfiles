{ config, pkgs, ... }:

{
  programs.nixvim.plugins.nvim-tree.enable = true;

  programs.nixvim.keymaps = [
    {
      key = "<leader>ee";
      action = "<cmd>NvimTreeToggle<CR>";
      options.desc = "Toggle file explorer";
    }
    {
      key = "<leader>ef";
      action = "<cmd>NvimTreeFindFileToggle<CR>";
      options.desc = "Toggle file explorer on current file";
    }
    {
      key = "<leader>ec";
      action = "<cmd>NvimTreeCollapse<CR>";
      options.desc = "Collapse file explorer";
    }
    {
      key = "<leader>er";
      action = "<cmd>NvimTreeRefresh<CR>";
      options.desc = "Refresh file explorer";
    }
  ];
}
