-- Treesitter configuration for modern Neovim
require("nvim-treesitter.configs").setup({
  ensure_installed = {
    -- Frontend essentials
    "typescript",
    "tsx",
    "javascript",
    "html",
    "css",
    -- "scss",  -- DISABLED: uncomment if needed
    "json",
    "jsonc",
    -- General
    "lua",
    "vim",
    "vimdoc",
    -- "markdown",  -- DISABLED: heavy on large files
    -- "markdown_inline",  -- DISABLED: heavy on large files
    "bash",
    "yaml",
    -- "toml",  -- DISABLED: uncomment if needed
    "go",
    "dart",
    -- Git - DISABLED: not essential
    -- "git_config",
    -- "gitcommit",
    -- "gitignore",
  },
  sync_install = false,
  auto_install = false,  -- DISABLED: prevents automatic downloads
  highlight = {
    enable = true,
    -- Disable for large files to improve performance
    disable = function(lang, buf)
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = true },
  -- DISABLED: incremental_selection adds overhead
  -- incremental_selection = {
  --   enable = true,
  --   keymaps = {
  --     init_selection = "<C-space>",
  --     node_incremental = "<C-space>",
  --     scope_incremental = false,
  --     node_decremental = "<bs>",
  --   },
  -- },
  -- DISABLED: textobjects are heavy, uncomment if you really need them
  -- textobjects = {
  --   select = {
  --     enable = true,
  --     lookahead = true,
  --     keymaps = {
  --       ["af"] = "@function.outer",
  --       ["if"] = "@function.inner",
  --       ["ac"] = "@class.outer",
  --       ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
  --       ["aa"] = "@parameter.outer",
  --       ["ia"] = "@parameter.inner",
  --       ["ai"] = "@conditional.outer",
  --       ["ii"] = "@conditional.inner",
  --       ["al"] = "@loop.outer",
  --       ["il"] = "@loop.inner",
  --     },
  --     selection_modes = {
  --       ["@parameter.outer"] = "v",
  --       ["@function.outer"] = "V",
  --       ["@class.outer"] = "<c-v>",
  --     },
  --     include_surrounding_whitespace = true,
  --   },
  --   move = {
  --     enable = true,
  --     set_jumps = true,
  --     goto_next_start = {
  --       ["]f"] = "@function.outer",
  --       ["]c"] = "@class.outer",
  --       ["]a"] = "@parameter.inner",
  --     },
  --     goto_next_end = {
  --       ["]F"] = "@function.outer",
  --       ["]C"] = "@class.outer",
  --     },
  --     goto_previous_start = {
  --       ["[f"] = "@function.outer",
  --       ["[c"] = "@class.outer",
  --       ["[a"] = "@parameter.inner",
  --     },
  --     goto_previous_end = {
  --       ["[F"] = "@function.outer",
  --       ["[C"] = "@class.outer",
  --     },
  --   },
  --   swap = {
  --     enable = true,
  --     swap_next = {
  --       ["<leader>a"] = "@parameter.inner",
  --     },
  --     swap_previous = {
  --       ["<leader>A"] = "@parameter.inner",
  --     },
  --   },
  -- },
})

-- nvim-ts-autotag for auto-closing HTML/JSX tags
require("nvim-ts-autotag").setup({
  opts = {
    enable_close = true,
    enable_rename = true,
    enable_close_on_slash = true,
  },
  per_filetype = {
    ["html"] = { enable_close = true },
  },
})

-- ts-context-commentstring for proper JSX/TSX comments
-- This integrates with native commenting in Neovim 0.10+
local ok, ts_context_commentstring = pcall(require, "ts_context_commentstring")
if ok then
  ts_context_commentstring.setup({
    enable_autocmd = false,
  })
  -- Integrate with native commenting
  local get_option = vim.filetype.get_option
  vim.filetype.get_option = function(filetype, option)
    return option == "commentstring"
        and require("ts_context_commentstring.internal").calculate_commentstring()
        or get_option(filetype, option)
  end
end

