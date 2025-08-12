vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true -- highlight line number
vim.o.wrap = false      -- don't wrap lines
vim.o.scrolloff = 10    -- keep 10 lines about/below cursor
vim.o.sidescrolloff = 8 -- keep 8 columns left/right of cursor

-- -- Indentation
vim.o.tabstop = 2        -- Tab width
vim.o.shiftwidth = 2     -- Indent width
vim.o.softtabstop = 2    -- Soft tab stop
vim.o.expandtab = true   -- Use spaces instead of tabs
vim.o.smartindent = true -- Smart auto-indenting
vim.o.autoindent = true  -- Copy indent from current line

-- Search settings
vim.o.ignorecase = true -- Case insensitive search
vim.o.smartcase = true  -- Case sensitive if uppercase in search
-- vim.o.hlsearch = false                           -- Don't highlight search results
vim.o.incsearch = true  -- Show matches as you type

-- Visual settings
vim.o.termguicolors = true                      -- Enable 24-bit colors
vim.o.signcolumn = "yes"                        -- Always show sign column
vim.o.showmatch = true                          -- Highlight matching brackets
vim.o.matchtime = 2                             -- How long to show matching bracket
vim.o.cmdheight = 1                             -- Command line height
vim.o.completeopt = "menuone,noinsert,noselect" -- Completion options
vim.o.showmode = false                          -- Don't show mode in command line
vim.o.pumheight = 10                            -- Popup menu height
vim.o.pumblend = 10                             -- Popup menu transparency
vim.o.winblend = 0                              -- Floating window transparency
vim.o.conceallevel = 0                          -- Don't hide markup
vim.o.concealcursor = ""                        -- Don't hide cursor line markup
vim.o.lazyredraw = true                         -- Don't redraw during macros
vim.o.synmaxcol = 300                           -- Syntax highlighting limit
vim.o.winborder = "rounded"

-- File handling
vim.o.backup = false                            -- Don't create backup files
vim.o.writebackup = false                       -- Don't create backup before writing
vim.o.swapfile = false                          -- Don't create swap files
vim.o.undofile = true                           -- Persistent undo
vim.o.undodir = vim.fn.expand("~/.vim/undodir") -- Undo directory
vim.o.updatetime = 300                          -- Faster completion
vim.o.timeoutlen = 500                          -- Key timeout duration
vim.o.ttimeoutlen = 0                           -- Key code timeout
vim.o.autoread = true                           -- Auto reload files changed outside vim
vim.o.autowrite = false                         -- Don't auto save

-- Behavior settings
vim.o.hidden = true                     -- Allow hidden buffers
vim.o.errorbells = false                -- No error bells
vim.o.backspace = "indent,eol,start"    -- Better backspace behavior
vim.o.autochdir = false                 -- Don't auto change directory
vim.opt.iskeyword:append("-")           -- Treat dash as part of word
vim.opt.path:append("**")               -- include subdirectories in search
vim.opt.clipboard:append("unnamedplus") -- Use system clipboard
vim.o.modifiable = true                 -- Allow buffer modifications
vim.o.encoding = "UTF-8"                -- Set encoding


-- Folding settings
vim.o.foldmethod = "expr"                           -- Use expression for folding
vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- Use treesitter for folding
vim.o.foldlevel = 99                                -- Start with all folds open

-- Split behavior
vim.o.splitbelow = true -- Horizontal splits go below
vim.o.splitright = true -- Vertical splits go right


-- Better diff options
vim.opt.diffopt:append("linematch:60")

-- Performance improvements
vim.o.redrawtime = 10000
vim.o.maxmempattern = 20000


-- Key mappings
vim.g.mapleader = " "      -- Set leader key to space
vim.g.maplocalleader = " " -- Set local leader key (NEW)

-- Normal mode mappings
vim.keymap.set("n", "<esc>", ":nohlsearch<CR>", { desc = "Clear search highlights" })

-- Center screen when jumping
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

-- Delete without yanking
vim.keymap.set({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete without yanking" })

-- Buffer navigation
-- vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
-- vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<S-l>", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-h>", ":bprevious<CR>", { desc = "Previous buffer" })

-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Splitting & Resizing
-- vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", { desc = "Split window vertically" })
-- vim.keymap.set("n", "<leader>sh", ":split<CR>", { desc = "Split window horizontally" })
vim.keymap.set("n", "|", ":vsplit<CR>", { desc = "Split window vertically" })
vim.keymap.set("n", "_", ":split<CR>", { desc = "Split window horizontally" })

vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

-- Move lines up/down
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Better indenting in visual mode
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Better J behavior
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" })

-- Quick config editing
vim.keymap.set("n", "<leader>rc", ":e ~/.config/nvim/init.lua<CR>", { desc = "Edit config" })


-- ============================================================================
-- USEFUL FUNCTIONS
-- ============================================================================

-- Copy Full File-Path
vim.keymap.set("n", "<leader>pa", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  print("file:", path)
end, { desc = "Copy file path" })

-- Basic autocommands
local augroup = vim.api.nvim_create_augroup("UserConfig", {})

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup,
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Return to last edit position when opening files
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup,
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Set filetype-specific settings
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = { "lua", "python" },
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = { "javascript", "typescript", "json", "html", "css" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
})

-- Auto-resize splits when window is resized
vim.api.nvim_create_autocmd("VimResized", {
  group = augroup,
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- Create directories when saving files
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup,
  callback = function()
    local dir = vim.fn.expand('<afile>:p:h')
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, 'p')
    end
  end,
})


-- Create undo directory if it doesn't exist
local undodir = vim.fn.expand("~/.vim/undodir")
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, "p")
end


-- ============================================================================
-- TABS
-- ============================================================================

-- Tab display settings
vim.opt.showtabline = 1 -- Always show tabline (0=never, 1=when multiple tabs, 2=always)
vim.opt.tabline = ''    -- Use default tabline (empty string uses built-in)

-- Transparent tabline appearance
vim.cmd([[
  hi TabLineFill guibg=NONE ctermfg=242 ctermbg=NONE
]])

-- Alternative navigation (more intuitive)
vim.keymap.set('n', '<leader>tn', ':tabnew<CR>', { desc = 'New tab' })
vim.keymap.set('n', '<leader>tx', ':tabclose<CR>', { desc = 'Close tab' })

-- Tab moving
vim.keymap.set('n', '<leader>tm', ':tabmove<CR>', { desc = 'Move tab' })
vim.keymap.set('n', '<leader>t>', ':tabmove +1<CR>', { desc = 'Move tab right' })
vim.keymap.set('n', '<leader>t<', ':tabmove -1<CR>', { desc = 'Move tab left' })

-- Function to open file in new tab
local function open_file_in_tab()
  vim.ui.input({ prompt = 'File to open in new tab: ', completion = 'file' }, function(input)
    if input and input ~= '' then
      vim.cmd('tabnew ' .. input)
    end
  end)
end

-- Function to duplicate current tab
local function duplicate_tab()
  local current_file = vim.fn.expand('%:p')
  if current_file ~= '' then
    vim.cmd('tabnew ' .. current_file)
  else
    vim.cmd('tabnew')
  end
end

-- Function to close tabs to the right
local function close_tabs_right()
  local current_tab = vim.fn.tabpagenr()
  local last_tab = vim.fn.tabpagenr('$')

  for i = last_tab, current_tab + 1, -1 do
    vim.cmd(i .. 'tabclose')
  end
end

-- Function to close tabs to the left
local function close_tabs_left()
  local current_tab = vim.fn.tabpagenr()

  for i = current_tab - 1, 1, -1 do
    vim.cmd('1tabclose')
  end
end

-- Enhanced keybindings
vim.keymap.set('n', '<leader>tO', open_file_in_tab, { desc = 'Open file in new tab' })
vim.keymap.set('n', '<leader>td', duplicate_tab, { desc = 'Duplicate current tab' })
vim.keymap.set('n', '<leader>tr', close_tabs_right, { desc = 'Close tabs to the right' })
vim.keymap.set('n', '<leader>tL', close_tabs_left, { desc = 'Close tabs to the left' })

-- Function to close buffer but keep tab if it's the only buffer in tab
local function smart_close_buffer()
  local buffers_in_tab = #vim.fn.tabpagebuflist()
  if buffers_in_tab > 1 then
    vim.cmd('bdelete')
  else
    -- If it's the only buffer in tab, close the tab
    vim.cmd('tabclose')
  end
end
vim.keymap.set('n', '<leader>bd', smart_close_buffer, { desc = 'Smart close buffer/tab' })


-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)





-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    "https://github.com/folke/tokyonight.nvim",
    "https://github.com/stevearc/oil.nvim",
    "mason-org/mason.nvim",
    'mason-org/mason-lspconfig.nvim',
    "windwp/nvim-ts-autotag",
    {
      'nvim-telescope/telescope.nvim',
      branch = '0.1.x',
      dependencies = { 'nvim-lua/plenary.nvim' }
    },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    -- 'nullromo/telescope-box-drawing.nvim',
    { "nvim-treesitter/nvim-treesitter",          branch = 'master', lazy = false, build = ":TSUpdate" },
    { 'echasnovski/mini.icons',                   version = '*' },
    { 'echasnovski/mini.snippets',                version = '*' },
    {
      'neovim/nvim-lspconfig',
      dependencies = { 'saghen/blink.cmp' },

      -- example using `opts` for defining servers
      opts = {
        servers = {
          lua_ls = {}
        },
        snippets = { present = "mini_snippets" },
      },
      config = function(_, opts)
        local lspconfig = require('lspconfig')
        for server, config in pairs(opts.servers) do
          -- passing config.capabilities to blink.cmp merges with the capabilities in your
          -- `opts[server].capabilities, if you've defined it
          config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
          lspconfig[server].setup(config)
        end
      end
    },

    {
      'saghen/blink.cmp',
      -- optional: provides snippets for the snippet source
      dependencies = { 'rafamadriz/friendly-snippets' },

      -- use a release tag to download pre-built binaries
      version = '1.*',
      -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
      -- build = 'cargo build --release',
      -- If you use nix, you can build from source using latest nightly rust with:
      -- build = 'nix run .#build-plugin',

      ---@module 'blink.cmp'
      ---@type blink.cmp.Config
      opts = {
        -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
        -- 'super-tab' for mappings similar to vscode (tab to accept)
        -- 'enter' for enter to accept
        -- 'none' for no mappings
        --
        -- All presets have the following mappings:
        -- C-space: Open menu or open docs if already open
        -- C-n/C-p or Up/Down: Select next/previous item
        -- C-e: Hide menu
        -- C-k: Toggle signature help (if signature.enabled = true)
        --
        -- See :h blink-cmp-config-keymap for defining your own keymap
        keymap = {
          preset = 'default',
          ['<CR>'] = { 'accept', 'fallback' },
        },
        completion = {
          -- ghost_text = { enabled = true },
          --
          documentation = { auto_show = true },
          menu = {
            -- Show documentation when selecting a completion item


            draw = {
              padding = { 0, 1 }, -- padding only on right side
              columns = { { 'kind_icon' }, { 'label', 'label_description', gap = 1 }, { "source_id" } },
              components = {
                kind_icon = {
                  text = function(ctx)
                    local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
                    return kind_icon
                  end,
                  -- (optional) use highlights from mini.icons
                  highlight = function(ctx)
                    local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                    return hl
                  end,
                },
              }
            }
          },
        },

        appearance = {
          -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
          -- Adjusts spacing to ensure icons are aligned
          nerd_font_variant = 'mono'
        },

        cmdline = { enabled = true },





        -- Default list of enabled providers defined so that you can extend it
        -- elsewhere in your config, without redefining it, due to `opts_extend`
        -- 'buffer' by default it's only enabled when LSP returns no items
        sources = {
          default = { 'lsp', 'path', 'snippets', 'buffer' },

          per_filetype = {
            -- sql = { 'dadbod' },
            -- optionally inherit from the `default` sources
            -- lua = { inherit_defaults = true, 'lazydev' }
          },

          providers = {
            path = {
              opts = {
                get_cwd = function(_)
                  return vim.fn.getcwd()
                end,
              },
            },
          },
        },

        -- Use a preset for snippets, check the snippets documentation for more information
        -- snippets = { preset = 'default' | 'luasnip' | 'mini_snippets' },
        snippets = { preset = 'default' },

        -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
        -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
        -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
        --
        -- See the fuzzy documentation for more information
        fuzzy = {
          implementation = "prefer_rust_with_warning"
        }
      },
      opts_extend = { "sources.default" }
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
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "tokyonight" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})



vim.keymap.set('n', '<leader>w', ':write<CR>')


-- vim.keymap.set({ 'n', 'v', 'x' }, '<leader>y', '"+y<CR>')
-- vim.keymap.set({ 'n', 'v', 'x' }, '<leader>d', '"+d<CR>')


-- vim.pack.add({
--   { src = "https://github.com/folke/tokyonight.nvim" },
--   { src = "https://github.com/stevearc/oil.nvim" },
--   { src = "https://github.com/echasnovski/mini.pick" },
--   { src = "https://github.com/echasnovski/mini.completion" },
--   { src = "https://github.com/neovim/nvim-lspconfig" },
--   { src = "https://github.com/folke/lazydev.nvim" },
-- })

require("oil").setup()
require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

require("mason-lspconfig").setup()




local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader><space>', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
-- Searches for the string under your cursor or selection in your current working directory
vim.keymap.set('n', '<leader>fp', builtin.grep_string, { desc = 'Telescope grep string' })
vim.keymap.set('n', '<leader>fi', builtin.oldfiles, { desc = 'Telescope grep string' })
vim.keymap.set('n', '<leader>fu', builtin.jumplist, { desc = 'Telescope grep string' })


vim.keymap.set('n', '<leader>fh', ":Pick help<CR>")
vim.keymap.set('n', '<leader>e', ":Oil<CR>")

vim.cmd.colorscheme("tokyonight-night")


vim.keymap.set('n', '<leader>fo', vim.lsp.buf.format)


-- Diagnostic signs
vim.diagnostic.config({
  virtual_text = false,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  -- virtual_text = { prefix = '●' },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "✗",
      [vim.diagnostic.severity.WARN] = "⚠",
      [vim.diagnostic.severity.INFO] = "ℹ",
      [vim.diagnostic.severity.HINT] = "💡",
    },
    -- highlight entire line
    linehl = {
      [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
    },
    -- highlight the line number
    numhl = {
      [vim.diagnostic.severity.WARN] = 'WarningMsg',
    },
  },
})

-- LSP keymaps
-- grn => rename
-- gra => code_action
-- grr => references
-- gf => gotofile
-- Diagnostics
-- ]d, [d => next,prev diagnostic
-- ]D, [D => last,first diagnostic
--
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
    local opts = { buffer = event.buf }

    -- Navigation
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gs', vim.lsp.buf.declaration, opts)
    -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)

    -- Information
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    -- vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)

    -- -- Code actions
    -- vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)

    -- Diagnostics
    vim.keymap.set('n', 'gl', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)
  end,
})



--
require('mini.snippets').setup({
  -- Array of snippets and loaders (see |MiniSnippets.config| for details).
  -- Nothing is defined by default. Add manually to have snippets to match.
  snippets = {},

  -- Module mappings. Use `''` (empty string) to disable one.
  mappings = {
    -- Expand snippet at cursor position. Created globally in Insert mode.
    expand = '<C-j>',

    -- Interact with default `expand.insert` session.
    -- Created for the duration of active session(s)
    jump_next = '<C-l>',
    jump_prev = '<C-h>',
    stop = '<C-c>',
  },

  -- Functions describing snippet expansion. If `nil`, default values
  -- are `MiniSnippets.default_<field>()`.
  expand = {
    -- Resolve raw config snippets at context
    prepare = nil,
    -- Match resolved snippets at cursor position
    match = nil,
    -- Possibly choose among matched snippets
    select = nil,
    -- Insert selected snippet
    insert = nil,
  },
})
local gen_loader = require('mini.snippets').gen_loader
require('mini.snippets').setup({
  snippets = {
    -- Load custom file with global snippets first (adjust for Windows)
    gen_loader.from_file('~/.config/nvim/snippets/global.json'),

    -- Load snippets based on current language by reading files from
    -- "snippets/" subdirectories from 'runtimepath' directories.
    gen_loader.from_lang(),
  },
})


-- TreeSitter
--
require("nvim-treesitter.configs").setup {
  textobjects = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn", -- set to `false` to disable one of the mappings
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  indent = {
    enable = true
  },
  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  ensure_installed = "all",

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (or "all")
  ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { "c", "rust" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}


require('nvim-ts-autotag').setup({
  opts = {
    -- Defaults
    enable_close = true,          -- Auto close tags
    enable_rename = true,         -- Auto rename pairs of tags
    enable_close_on_slash = false -- Auto close on trailing </
  },
  -- Also override individual filetype configs, these take priority.
  -- Empty by default, useful if one of the "opts" global settings
  -- doesn't work well in a specific filetype
  per_filetype = {
    ["html"] = {
      enable_close = false
    }
  }
})




require('telescope').setup({
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<C-h>"] = "which_key"
      }
    }
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
    fzf = {
      fuzzy = true,                   -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true,    -- override the file sorter
      case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
  },

})
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
local telescope = require('telescope')
telescope.load_extension('fzf')



-- telescope.load_extension('box-drawing')
--
--
