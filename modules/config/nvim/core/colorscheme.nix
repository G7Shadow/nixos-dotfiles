{ config, pkgs, ...}:

{
programs.nixvim = {
	enable = true;
	colorschemes.tokyonight.enable = true;
    };
}

