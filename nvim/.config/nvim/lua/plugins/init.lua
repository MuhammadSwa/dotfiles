return {
  {
    'nvim-flutter/flutter-tools.nvim',
    lazy = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
    config = true,
  },
  { "autolyticus/hot-reload.vim" },

  -- lsp
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",
  -- treesitter
  {
    'neovim/nvim-lspconfig',
    requires = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
    },

    {
      "folke/lazydev.nvim",
      ft = "lua", -- only load on lua files
      opts = {
        library = {
          -- See the configuration section for more details
          -- Load luvit types when the `vim.uv` word is found
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },

    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
    },

    -- cmp related
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-cmdline",
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-nvim-lua",
    -- luasnip related
    {
      "L3MON4D3/LuaSnip",
      dependencies = { "rafamadriz/friendly-snippets" },
    },
    -- "saadparwaiz1/cmp_luasnip",


    -- git
    "lewis6991/gitsigns.nvim",
    -- statusLine
    {
      'nvim-lualine/lualine.nvim',
      dependencies = { 'nvim-tree/nvim-web-devicons' },
    },
    -- AI
    {
      "Exafunction/codeium.vim",
    },



    {
      "folke/which-key.nvim",
      event = "VeryLazy",
      dependencies = { "echasnovski/mini.icons", "nvim-tree/nvim-web-devicons" },
      opts = {},
    },
    "RRethy/vim-illuminate",
    {
      'windwp/nvim-autopairs',
      event = "InsertEnter",
      config = true
      -- use opts = {} for passing setup options
      -- this is equivalent to setup({}) function
    },

    {
      "andymass/vim-matchup",
      setup = function()
        vim.g.matchup_matchparen_offscreen = { method = "popup" }
      end,
    },
    { "windwp/nvim-ts-autotag",   opts = {} },

    -- todo comments
    { "folke/todo-comments.nvim", opts = {} },

    {
      "lukas-reineke/indent-blankline.nvim",
      main = "ibl",
      ---@module "ibl"
      ---@type ibl.config
      opts = {},
    },

    -- {"ggandor/leap.nvim",
    --   dependencies={"tpope/vim-repeat"},
    --   config = function()
    --     require("leap").create_default_mappings()
    --   end
    -- },

    {
      'smoka7/hop.nvim',
      version = "*",
      opts = {
        keys = 'etovxqpdygfblzhckisuran'
      }
    },


    { 'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons', opts = {} },
    {
      'nvim-telescope/telescope.nvim',
      tag = '0.1.8',
      dependencies = { 'nvim-lua/plenary.nvim' },
    },
    {
      "chentoast/marks.nvim",
      event = "VeryLazy",
      opts = {},
    },

    {
      "Wansmer/treesj",
      keys = { "<space>m", "<space>j", "<space>s" },
      dependencies = { "nvim-treesitter/nvim-treesitter" },
    },
    "Shatur/neovim-session-manager",

    "kyazdani42/nvim-tree.lua",

    {
      "folke/tokyonight.nvim",
      lazy = false,
      priority = 1000,
      opts = {},
    },
  },


  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
  },


  -- {
  --   'saghen/blink.cmp',
  --   -- optional: provides snippets for the snippet source
  --   opts_extend = {
  --     "sources.completion.enabled_providers",
  --     "sources.compat",
  --     "sources.default",
  --   },
  --   dependencies = {
  --     "rafamadriz/friendly-snippets",
  --     -- add blink.compat to dependencies
  --     {
  --       "saghen/blink.compat",
  --       optional = true, -- make optional so it's only enabled if any extras need it
  --       opts = {},
  --       version = not vim.g.lazyvim_blink_main and "*",
  --     },
  --   },
  --   event = "InsertEnter",
  -- },

  {
    "folke/ts-comments.nvim",
    opts = {},
    event = "VeryLazy",
    enabled = vim.fn.has("nvim-0.10.0") == 1,
  },

  "akinsho/toggleterm.nvim",

  -- {
  --   'saghen/blink.cmp',
  --   -- optional: provides snippets for the snippet source
  --   dependencies = { 'rafamadriz/friendly-snippets' },
  --
  --   -- use a release tag to download pre-built binaries
  --   version = '1.*',
  --   -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  --   -- build = 'cargo build --release',
  --   -- If you use nix, you can build from source using latest nightly rust with:
  --   -- build = 'nix run .#build-plugin',
  --
  --   ---@module 'blink.cmp'
  --   ---@type blink.cmp.Config
  --   opts = {
  --     -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
  --     -- 'super-tab' for mappings similar to vscode (tab to accept)
  --     -- 'enter' for enter to accept
  --     -- 'none' for no mappings
  --     --
  --     -- All presets have the following mappings:
  --     -- C-space: Open menu or open docs if already open
  --     -- C-n/C-p or Up/Down: Select next/previous item
  --     -- C-e: Hide menu
  --     -- C-k: Toggle signature help (if signature.enabled = true)
  --     --
  --     -- See :h blink-cmp-config-keymap for defining your own keymap
  --     keymap = { preset = 'default' },
  --
  --     appearance = {
  --       -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
  --       -- Adjusts spacing to ensure icons are aligned
  --       nerd_font_variant = 'mono'
  --     },
  --
  --     -- (Default) Only show the documentation popup when manually triggered
  --     completion = { documentation = { auto_show = false } },
  --
  --     -- Default list of enabled providers defined so that you can extend it
  --     -- elsewhere in your config, without redefining it, due to `opts_extend`
  --     sources = {
  --       default = { 'lsp', 'path', 'snippets', 'buffer' },
  --     },
  --
  --     -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
  --     -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
  --     -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
  --     --
  --     -- See the fuzzy documentation for more information
  --     fuzzy = { implementation = "prefer_rust_with_warning" }
  --   },
  --   opts_extend = { "sources.default" }
  -- },
}
