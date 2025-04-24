---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",

  ---@type AstroUIProviderTreesitterStatusOpts.
  opts = {
    ensure_installed = {
      "lua",
      "vim",
      -- "biome",
    },
  },
}
