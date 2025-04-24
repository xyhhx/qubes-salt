---@type LazySpec
return {
  "AstroNvim/astroui",

  lazy = false,
  priority = 1000,

  ---@type AstroUIOpts
  opts = {

    colorscheme = "equinusocio_material",

    folding = {
      enabled = true,
      methods = { "treesitter" },
    },

    highlights = {
      equinusocio_material = {
        Normal = { bg = "None" },
        NormalFloat = { bg = "none" },
        NormalNC = { bg = "None" },
        ColorColumn = { bg = "None" },
        SignColumn = { bg = "None" },
        Folded = { bg = "None" },
        FoldColumn = { bg = "None" },
        CursorLine = { bg = "None" },
        CursorColumn = { bg = "None" },
        VertSplit = { bg = "None" },
      }
    },

    icons = {
      LSPLoading1 = "⠋",
      LSPLoading2 = "⠙",
      LSPLoading3 = "⠹",
      LSPLoading4 = "⠸",
      LSPLoading5 = "⠼",
      LSPLoading6 = "⠴",
      LSPLoading7 = "⠦",
      LSPLoading8 = "⠧",
      LSPLoading9 = "⠇",
      LSPLoading10 = "⠏",
    },

    status = {
      separators = {
        left = { "", " " },
      }
    },
  },
}
