return {
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
      opts = {
        options = {
          component_separators = '|',
          section_separators = '',
        },
      },
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

}
