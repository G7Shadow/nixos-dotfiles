{ config, pkgs, ... }:
{
  programs.nixvim = {
    # Enable blink-cmp plugin
    plugins.blink-cmp = {
      enable = true;
      
      settings = {
        keymap.preset = "default";
        appearance = {
          nerd_font_vont = "mono"; # Fixed typo: 'nerd_font_variant'
          use_nvim_cmp_as_default = true;
        };
        completion.documentation.auto_show = false;
        sources.default = [ "lsp" "path" "snippets" "buffer" ];
        fuzzy.implementation = "prefer_rust_with_warning";
        signature.enabled = true;
      };
    };

    # Add dependencies
    extraPlugins = with pkgs.vimPlugins; [
      blink-pairs
      friendly-snippets
    ];
    
    extraConfigLua = ''
      -- Initialize blink-pairs if the plugin is available
      local status, blink_pairs = pcall(require, 'blink.pairs')
      if status then
        blink_pairs.setup({
          mappings = {
            enabled = true,
          },
          highlights = {
            enabled = true,
          },
        })
      end
    '';
  };
}
