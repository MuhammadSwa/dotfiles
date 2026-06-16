return {
  -- LSP
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",

  -- Emmet
  {
    "mattn/emmet-vim",
    ft = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte" },
    init = function()
      vim.g.user_emmet_leader_key = "<C-,>"
      vim.g.user_emmet_settings = {
        javascript = { extends = "jsx" },
        typescript = { extends = "jsx" },
        typescriptreact = { extends = "jsx" },
        javascriptreact = { extends = "jsx" },
      }
    end,
  },

  -- Lua Development
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },

  -- Treesitter (main branch for Neovim 0.12+)
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      highlight = {
        enable = true,
        disable = function(lang, buf)
          local max_filesize = 100 * 1024
          local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
      },
      indent = { enable = true },
    },
    config = function(_, opts)
      require("nvim-treesitter").setup(opts)
      local parsers = {
        "typescript",
        "tsx",
        "javascript",
        "html",
        "css",
        "json",
        "lua",
        "vim",
        "vimdoc",
        "bash",
        "yaml",
        "go",
        "dart",
        "zig",
        "qml",
        "cpp",
        "c",
      }
      for _, parser in ipairs(parsers) do
        pcall(require("nvim-treesitter").install, parser)
      end
    end,
  },

  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    lazy = true,
  },

  -- Completion
  {
    "saghen/blink.cmp",
    version = "*",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
  },
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },
  },

  -- Editor Enhancements
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true,
      ts_config = {
        lua = { "string", "source" },
        javascript = { "string", "template_string" },
        typescript = { "string", "template_string" },
      },
    },
  },
  {
    "andymass/vim-matchup",
    event = "BufReadPost",
    init = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    opts = {},
  },

  -- Motion
  {
    "smoka7/hop.nvim",
    version = "*",
    event = "VeryLazy",
    opts = {
      keys = "etovxqpdygfblzhckisuran",
    },
  },

  -- Buffer Management
  {
    "akinsho/bufferline.nvim",
    version = "*",
    event = "VeryLazy",
    dependencies = "nvim-tree/nvim-web-devicons",
  },

  -- Code Manipulation
  {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = { use_default_keymaps = false },
    keys = {
      { "<leader>m", "<cmd>TSJToggle<cr>", desc = "Toggle split/join" },
    },
  },

  -- Session Management
  {
    "Shatur/neovim-session-manager",
    cmd = "SessionManager",
    config = function()
      require("session_manager").setup({
        autoload_mode = require("session_manager.config").AutoloadMode.Disabled,
      })
    end,
  },

  -- File Explorer
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  -- Colorscheme
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",
      transparent = false,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
      },
    },
  },
}
