return {
  -- DISABLED: Flutter tools - only enable if you use Flutter
  -- {
  --   "nvim-flutter/flutter-tools.nvim",
  --   lazy = false,
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "stevearc/dressing.nvim", -- optional for vim.ui.select
  --   },
  --   config = true,
  -- },
  -- lsp
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",

  -- Formatting & Linting (replaces null-ls, modern approach)
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
      formatters_by_ft = {
        javascript = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        javascriptreact = { "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },
        css = { "prettierd", "prettier", stop_after_first = true },
        html = { "prettierd", "prettier", stop_after_first = true },
        json = { "prettierd", "prettier", stop_after_first = true },
        yaml = { "prettierd", "prettier", stop_after_first = true },
        markdown = { "prettierd", "prettier", stop_after_first = true },
        lua = { "stylua" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
      },
    },
  },

  -- Linting
  -- DISABLED: eslint_d runs frequently and slows down editing
  -- {
  --   "mfussenegger/nvim-lint",
  --   event = { "BufReadPre", "BufNewFile" },
  --   config = function()
  --     local lint = require("lint")
  --     lint.linters_by_ft = {
  --       javascript = { "eslint_d" },
  --       typescript = { "eslint_d" },
  --       javascriptreact = { "eslint_d" },
  --       typescriptreact = { "eslint_d" },
  --     }
  --     vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  --       callback = function()
  --         lint.try_lint()
  --       end,
  --     })
  --   end,
  -- },

  -- Emmet for rapid HTML/JSX expansion
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

  -- Color highlighting for CSS colors (includes Tailwind support)
  -- DISABLED: Heavy with tailwind scanning on large files
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   event = { "BufReadPre", "BufNewFile" },
  --   opts = {
  --     filetypes = { "*" },
  --     user_default_options = {
  --       RGB = true,
  --       RRGGBB = true,
  --       names = false,
  --       RRGGBBAA = true,
  --       css = true,
  --       css_fn = true,
  --       tailwind = true,
  --       mode = "background",
  --     },
  --   },
  -- },

  -- TypeScript enhanced features
  -- DISABLED: Heavy plugin with many inlay hints, uses lots of memory
  -- {
  --   "pmizio/typescript-tools.nvim",
  --   dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  --   ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  --   opts = {
  --     settings = {
  --       separate_diagnostic_server = true,
  --       publish_diagnostic_on = "insert_leave",
  --       tsserver_file_preferences = {
  --         includeInlayParameterNameHints = "all",
  --         includeInlayParameterNameHintsWhenArgumentMatchesName = false,
  --         includeInlayFunctionParameterTypeHints = true,
  --         includeInlayVariableTypeHints = true,
  --         includeInlayPropertyDeclarationTypeHints = true,
  --         includeInlayFunctionLikeReturnTypeHints = true,
  --         includeInlayEnumMemberValueHints = true,
  --       },
  --     },
  --   },
  -- },

  -- ═══════════════════════════════════════════════════════════
  -- Lua Development
  -- ═══════════════════════════════════════════════════════════
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },

  -- ═══════════════════════════════════════════════════════════
  -- Treesitter (Syntax Highlighting & Text Objects)
  -- ═══════════════════════════════════════════════════════════
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      ensure_installed = {
        "typescript",
        "tsx",
        "javascript",
        "html",
        "css",
        "json",
        "jsonc",
        "lua",
        "vim",
        "vimdoc",
        "bash",
        "yaml",
        "go",
        "dart",
      },
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
      require("nvim-treesitter.install").prefer_git = true
    end,
  },
  -- DISABLED: Heavy treesitter textobjects
  -- {
  --   "nvim-treesitter/nvim-treesitter-textobjects",
  --   dependencies = { "nvim-treesitter/nvim-treesitter" },
  -- },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    lazy = true,
  },

  -- ═══════════════════════════════════════════════════════════
  -- Completion (nvim-cmp)
  -- ═══════════════════════════════════════════════════════════
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lua",
    },
  },
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },
  },

  -- ═══════════════════════════════════════════════════════════
  -- Git Integration
  -- ═══════════════════════════════════════════════════════════
  -- DISABLED: Updates frequently, can slow down large repos
  -- {
  --   "lewis6991/gitsigns.nvim",
  --   event = { "BufReadPre", "BufNewFile" },
  --   opts = {},
  -- },

  -- ═══════════════════════════════════════════════════════════

  -- ═══════════════════════════════════════════════════════════
  -- AI Assistance
  -- ═══════════════════════════════════════════════════════════
  {
    "zbirenbaum/copilot.lua",
    dir = vim.fn.stdpath("data") .. "/local_plugins/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,
          keymap = {
            accept = "<C-j>",
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-x>",
          },
        },
        panel = { enabled = true },
      })
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    config = function()
      require("copilot_cmp").setup()
    end,
  },
  -- DISABLED: Heavy AI completion, runs constantly in background
  -- {
  --   "Exafunction/codeium.vim",
  --   event = "InsertEnter",
  --   config = function()
  --     vim.g.codeium_disable_bindings = 1
  --     vim.keymap.set("i", "<C-g>", function()
  --       return vim.fn["codeium#Accept"]()
  --     end, { expr = true, silent = true, desc = "Codeium Accept" })
  --     vim.keymap.set("i", "<M-]>", function()
  --       return vim.fn["codeium#CycleCompletions"](1)
  --     end, { expr = true, silent = true, desc = "Codeium Next" })
  --     vim.keymap.set("i", "<M-[>", function()
  --       return vim.fn["codeium#CycleCompletions"](-1)
  --     end, { expr = true, silent = true, desc = "Codeium Prev" })
  --     vim.keymap.set("i", "<C-x>", function()
  --       return vim.fn["codeium#Clear"]()
  --     end, { expr = true, silent = true, desc = "Codeium Clear" })
  --   end,
  -- },

  -- ═══════════════════════════════════════════════════════════
  -- Editor Enhancements
  -- ═══════════════════════════════════════════════════════════
  -- {
  --   "folke/which-key.nvim",
  --   event = "VeryLazy",
  --   dependencies = { "echasnovski/mini.icons", "nvim-tree/nvim-web-devicons" },
  --   opts = {
  --     preset = "helix",
  --     spec = {
  --       { "<leader>f", group = "find/file" },
  --       { "<leader>g", group = "git" },
  --       { "<leader>t", group = "typescript" },
  --       { "<leader>d", group = "dev/debug" },
  --       { "<leader>x", group = "diagnostics" },
  --       { "<leader>c", group = "code" },
  --       { "<leader>w", group = "workspace" },
  --     },
  --   },
  -- },
  -- DISABLED: Heavy reference highlighting, uses LSP/treesitter constantly
  -- {
  --   "RRethy/vim-illuminate",
  --   event = { "BufReadPost", "BufNewFile" },
  --   opts = {
  --     delay = 200,
  --     large_file_cutoff = 2000,
  --   },
  --   config = function(_, opts)
  --     require("illuminate").configure(opts)
  --   end,
  -- },
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

  -- ═══════════════════════════════════════════════════════════
  -- Comments & TODOs
  -- ═══════════════════════════════════════════════════════════
  -- DISABLED: Scans buffers for TODO patterns constantly
  -- {
  --   "folke/todo-comments.nvim",
  --   event = { "BufReadPost", "BufNewFile" },
  --   dependencies = { "nvim-lua/plenary.nvim" },
  --   opts = {},
  -- },
  -- {
  --   "folke/ts-comments.nvim",
  --   event = "VeryLazy",
  --   opts = {},
  --   enabled = vim.fn.has("nvim-0.10.0") == 1,
  -- },

  -- ═══════════════════════════════════════════════════════════
  -- Indentation Guides
  -- ═══════════════════════════════════════════════════════════
  -- DISABLED: Heavy indentation calculation on large files
  -- {
  --   "lukas-reineke/indent-blankline.nvim",
  --   main = "ibl",
  --   event = { "BufReadPost", "BufNewFile" },
  --   opts = {
  --     indent = { char = "│" },
  --     scope = { enabled = true },
  --   },
  -- },

  -- ═══════════════════════════════════════════════════════════
  -- Motion & Navigation
  -- ═══════════════════════════════════════════════════════════
  {
    "smoka7/hop.nvim",
    version = "*",
    event = "VeryLazy",
    opts = {
      keys = "etovxqpdygfblzhckisuran",
    },
  },

  -- ═══════════════════════════════════════════════════════════
  -- Buffer & Tab Management
  -- ═══════════════════════════════════════════════════════════
  {
    "akinsho/bufferline.nvim",
    version = "*",
    event = "VeryLazy",
    dependencies = "nvim-tree/nvim-web-devicons",
  },

  -- ═══════════════════════════════════════════════════════════
  -- Fuzzy Finder (fzf-lua)
  -- ═══════════════════════════════════════════════════════════
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "FzfLua",
    config = function()
      require("fzf-lua").setup({
        files = {
          fd_opts = "--color=never --type f --hidden --follow --exclude .git --exclude node_modules --exclude dist --exclude build",
        },
      })
    end,
  },

  -- ═══════════════════════════════════════════════════════════
  -- Code Manipulation
  -- ═══════════════════════════════════════════════════════════
  {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = { use_default_keymaps = false },
    keys = {
      { "<leader>m", "<cmd>TSJToggle<cr>", desc = "Toggle split/join" },
    },
  },

  -- ═══════════════════════════════════════════════════════════
  -- Session Management
  -- ═══════════════════════════════════════════════════════════
  {
    "Shatur/neovim-session-manager",
    cmd = "SessionManager",
    config = function()
      require("session_manager").setup({
        autoload_mode = require("session_manager.config").AutoloadMode.Disabled,
      })
    end,
  },

  -- ═══════════════════════════════════════════════════════════
  -- File Explorer
  -- ═══════════════════════════════════════════════════════════
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  -- ═══════════════════════════════════════════════════════════
  -- Colorscheme
  -- ═══════════════════════════════════════════════════════════
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

  -- ═══════════════════════════════════════════════════════════
  -- Diagnostics (Trouble)
  -- ═══════════════════════════════════════════════════════════
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {
      modes = {
        preview_float = {
          mode = "diagnostics",
          preview = {
            type = "float",
            relative = "editor",
            border = "rounded",
            title = "Preview",
            title_pos = "center",
          },
        },
      },
    },
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics" },
      { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols" },
      { "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions" },
    },
  },
}
