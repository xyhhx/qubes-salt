---@type LazySpec
return {
  "AstroNvim/astrotheme",

  lazy = false,
  priority = 1000,

  ---@type AstroThemeOpts
  opts = {

    palette = "dark",
    background = {
      light = "light",
      dark = "dark",
    },

    style = {
      transparent = true,
      inactive = true,
      float = true,
      neotree = true,
      border = true,
      title_invert = true,
      italic_comments = true,
      simple_syntax_colors = true,
    },

    termguicolors = true,

    terminal_color = true,

    plugin_default = "auto",

    plugins = {
      ["bufferline.nvim"] = false,
    },

    highlights = {
      global = {
        Normal = { bg = "None" },
        NormalFloat = { bg = "none" },
        NormalNC = { bg = "None" },
        -- NotifyBackground = { bg = "#000000" },
        ColorColumn = { bg = "None" },
        SignColumn = { bg = "None" },
        Folded = { bg = "None" },
        FoldColumn = { bg = "None" },
        CursorLine = { bg = "None" },
        CursorColumn = { bg = "None" },
        VertSplit = { bg = "None" },
      },
    },
  },
}
