---@type LazySpec
return {

  "miikanissi/modus-themes.nvim",
  "dasupradyumna/midnight.nvim",

  {
    "yunlingz/equinusocio-material.vim",
    init = function() vim.g.equinusocio_material_style = "pure" end,
  },

  {
    "Shatur/neovim-ayu",
    lazy = true,
    init = function()
      local ayuColors = require "ayu.colors"
      require("heirline").load_colors(ayuColors)
    end,
  },

  {
    "bluz71/vim-moonfly-colors",
    name = "moonfly",
    lazy = true,
    init = function() vim.g.moonflyTransparent = true end,
  },
}
