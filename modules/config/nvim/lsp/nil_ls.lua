return {
  cmd = { 'nil' },
  filetypes = { 'nix' },
  root_markers = { 'flake.nix','default.nix', '.git' },
      settings = {
        ['nil'] = {
            formatting = {
                command = { "alejandra" } -- or "alejandra" if you prefer
            }
        }
    }
}
