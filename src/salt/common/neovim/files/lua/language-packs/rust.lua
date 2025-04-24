---@type LazySpec
return {
  {
    "AstroNvim/astrocommunity",
    { import = "astrocommunity.pack.rust", ft = "rust", event = "VeryLazy" },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    ft = "rust", event = "VeryLazy",

    opts = function(_, opts)
      return require("astrocore").extend_tbl(opts, {
        ensure_installed = {
          "autotools-language-server",
          "awk-language-server",
          "bacon",
          "bacon-ls",
          "bash-debug-adapter",
          "bash-language-server",
          "beautysh",
          "biome",
          "cmake-language-server",
          "cmakelang",
          "codelldb",
          "commitlint",
          "dotenv-linter",
          "editorconfig-checker",
          "gitleaks",
          "gitlint",
          "hadolint",
          "harper-ls",
          "jinja-lsp",
          "markdownlint",
          "marksman",
          "mdformat",
          "prettydiff",
          "prettypst",
          "proselint",
          "prosemd-lsp",
          "remark-cli",
          "remark-language-server",
          "rpmlint",
          "salt-lint",
          "shellcheck",
          "shellharden",
          "shfmt",
          "systemd-language-server",
          "systemdlint",
          "taplo",
          "tree-sitter-cli",
        },
      })
    end,
  },
  { "saecki/crates.nvim", tag = "stable", ft = "rust" },

  {
    "rouge8/neotest-rust",
    ft = "rust", event = "VeryLazy",
    dependencies = {
      "nvim-neotest/neotest",
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },

  {
    "adaszko/tree_climber_rust.nvim",
    ft = "rust", event = "VeryLazy",
    init = function()
      vim.g.rustaceanvim = {
        server = {
          on_attach = function(_, bufnr)
            local opts = { noremap = true, silent = true }
            vim.api.nvim_buf_set_keymap(
              bufnr,
              "n",
              "s",
              '<cmd>lua require("tree_climber_rust").init_selection()<CR>',
              opts
            )
            vim.api.nvim_buf_set_keymap(
              bufnr,
              "x",
              "s",
              '<cmd>lua require("tree_climber_rust").select_incremental()<CR>',
              opts
            )
            vim.api.nvim_buf_set_keymap(
              bufnr,
              "x",
              "S",
              '<cmd>lua require("tree_climber_rust").select_previous()<CR>',
              opts
            )
          end,
        },
      }
    end,
  },
}
