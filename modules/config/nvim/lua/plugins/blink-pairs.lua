return {
  'saghen/blink.pairs',
  version = '*', -- Uses pre-built binaries from GitHub releases
  dependencies = 'saghen/blink.download',
  opts = {
    -- Refer to the blink.pairs documentation for specific options
    mappings = {
      enabled = true, -- Enable auto-pair mappings
    },
    highlights = {
      enabled = true, -- Enable highlighting of matching pairs
    },
  }
}
