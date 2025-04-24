vim.cmd("source " .. vim.env.HOME .. "/.vimrc")

require("lazy").setup({
  {
    "AstroNvim/AstroNvim",
    version = "^5",
    import = "astronvim.plugins",
    opts = {
      mapleader = " ",
      maplocalleader = ",",
      icons_enabled = true,
      pin_plugins = nil,
      update_notifications = true,
    },
  },

  { import = "plugins" },
} --[[@as LazySpec]], {
  install = {
    colorscheme = { "astrotheme", "habamax" },
  },

  -- defaults = {
  --   lazy = true,
  -- },

  ui = { backdrop = 100 },

  performance = {
    rtp = {

      disabled_plugins = {
        "gzip",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "zipPlugin",
      },
    },
  },
} --[[@as LazyConfig]])
