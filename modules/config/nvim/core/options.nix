{ config, pkgs, ...}:
{
  programs.nixvim.opts = {
    number = true;
    relativenumber = true;
    cursorline = true;
    shiftwidth = 4;
    tabstop = 4;
    expandtab = true;
    smartindent = true;
    wrap = false;
    swapfile = false;
    backup = false;
    undodir = "~/.vim/undodir";
    undofile = true;
    incsearch = true;
    termguicolors = true;
    scrolloff = 8;
    signcolumn = "yes";
    colorcolumn = "80";
  };	
}
