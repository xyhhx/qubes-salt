---@type LazySpec
return {
  "AstroNvim/astrocore",

  lazy = false,
  priority = 1000,

  ---@type AstroCoreOpts
  opts = {

    features = {
      large_buf = { size = 1024 * 256, lines = 10000 },
      autopairs = true,
      cmp = true,
      diagnostics = { virtual_text = true, virtual_lines = true },
      highlighturl = true,
      notifications = true,
    },

    diagnostics = {
      virtual_lines = true,
      virtual_text = true,
      underline = true,
    },

    filetypes = {
    },

    options = {
      opt = {
        relativenumber = true,
        number = true,
        spell = false,
        signcolumn = "yes",
        wrap = false,
      },
      g = {},
    },

    mappings = {

      n = {

        ["]b"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["[b"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

        ["<Leader>bd"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Close buffer from tabline",
        },
      },
    },
  },
}
