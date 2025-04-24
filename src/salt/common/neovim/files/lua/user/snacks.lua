---@type LazySpec
return {
  {
    "folke/snacks.nvim",

    keys = {
      { "<leader>o", function() require("snacks").explorer() end, desc = "File Explorer" },
    },

    ---
    ---@module 'snacks'
    ---@type snacks.Config
    opts = {

      ---@class snacks.bigfile.Config
      bigfile = { enabled = true },

      ---@class snacks.dim.Config
      dim = { enabled = true },

      ---@class snacks.explorer.Config
      explorer = {
        replace_netrw = false,
      },

      ---@class snacks.image.Config
      image = { enabled = false },

      ---@class snacks.indent.Config
      indent = {
        animate = {
          enabled = true,
        },
        indent = {
          scope = {
            enabled = true,
            underline = false,
            hl = "SnacksPickerCol",
          },
          chunk = {
            enabled = true,
          },
          char = "·",
        },
      },

      ---@class snacks.lazygit.Config
      lazygit = {
        configure = true,
      },

      ---@class snacks.notifier.Config
      notifier = {
        timeout = 5000,
        style = "fancy",
      },

      ---@class snacks.picker.Config
      picker = {
        sources = {
          explorer = {
            hidden = false,
            ignored = true,
            -- replace_netrw = true,
          },
          files = {
            hidden = true,
            ignored = true,
          },
        },
      },

      ---@class snacks.quickfile.Config
      quickfile = {
        enabled = true,
      },

      ---@class snacks.scroll.Config
      scroll = {
        enabled = true,
      },

      ---@class snacks.statuscolumn.Config
      statuscolumn = {
        left = { "mark", "sign" },
        right = { "fold", "git" },
        folds = {
          open = false,
          git_hl = false,
        },
        git = {
          patterns = { "GitSign", "MiniDiffSign" },
        },
        refresh = 50,
      },

      ---@class snacks.words.Config
      words = {
        enabled = true,
      },

      ---@class snacks.zen.Config
      zen = {
        toggles = {
          dim = true,
          git_signs = false,
          mini_diff_signs = false,
          -- diagnostics = false,
          -- inlay_hints = false,
        },
        show = {
          statusline = false, -- can only be shown when using the global statusline
          tabline = false,
        },

        ---@type snacks.win.Config
        win = {
          relative = "editor",
          style = "zen",
        },

        --- Options for the `Snacks.zen.zoom()`
        ---@type snacks.zen.Config
        zoom = {
          toggles = {},
          show = { statusline = true, tabline = true },
          win = {
            backdrop = false,
            width = 0, -- full width
          },
        },
      },

      ---@class snacks.styles.Config
      styles = {
        zen = {
          enter = true,
          fixbuf = false,
          minimal = false,
          width = 120,
          height = 0,
          backdrop = { transparent = false, blend = 40 },
          keys = { q = false },
          zindex = 40,
          wo = {
            winhighlight = "NormalFloat:Normal",
          },
          w = {
            snacks_main = true,
          },
        },
        input = {
          border = "none",
          backdrop = true,
        },
        blame_line = {
          border = "none",
        },
        notification = {
          wo = {
            wrap = true,
          },
        },
      },
    },
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false,
  },

  {
    "AstronVim/astrocore",

    ---@type AstroCoreOpts
    opts = {
      options = {
        o = {
          statuscolumn = "%{%v:lua.require('statuscol').get_statuscol_string()%}",
        },
      },
    },
  },
}
