local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "html-lsp",
        "prettier",
        "stylua",
        "go",
        "deno",
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        -- defaults
        "vim",
        "lua",
        "bash",
        "dockerfile",
        "go",
        "terraform",
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "json",
      },
    },
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  {
    "zbirenbaum/copilot.lua",
    lazy = false,
    config = function()
      require("copilot").setup()
    end,
  },

  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  {
    "HampusHauffman/block.nvim",
    lazy = false,
    config = function()
      require("block").setup {
        depth = 8,
        automatic = false,
      }
    end,
  },

  -- {
  --   "svermeulen/text-to-colorscheme.nvim",
  --   lazy = false,
  --   hex_palettes = {
  --     {
  --       name = "tangerine dream in a warm ultramarine goo",
  --       background_mode = "dark",
  --       background = "#101941",
  --       foreground = "#ffc795",
  --       accents = {
  --         "#ff8253",
  --         "#ffaac7",
  --         "#84abff",
  --         "#648eff",
  --         "#325cff",
  --         "#205fff",
  --         "#ff593f",
  --       },
  --     },
  --   },
  --   default_palette = "jungle",
  --   config = function()
  --     require("text-to-colorscheme").setup {
  --       ai = {
  --         openai_api_key = os.getenv "OPENAI_API_KEY",
  --       },
  --       gpt_model = "gpt-4",
  --     }
  --     vim.cmd [[colorscheme text-to-colorscheme]]
  --     vim.keymap.set("n", "<F8>", ":T2CShuffleAccents<cr>", { noremap = true, silent = true })
  --     vim.keymap.set("n", "<F9>", ":T2CAddContrast -0.1<cr>", { noremap = true, silent = true })
  --     vim.keymap.set("n", "<F10>", ":T2CAddContrast 0.1<cr>", { noremap = true, silent = true })
  --     vim.keymap.set("n", "<F11>", ":T2CAddSaturation -0.1<cr>", { noremap = true, silent = true })
  --     vim.keymap.set("n", "<F12>", ":T2CAddSaturation 0.1<cr>", { noremap = true, silent = true })
  --   end,
  -- },
  --
  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },
}

return plugins
