-- Modern Neovim Options Configuration (Neovim 0.11+)
-- These settings are optimized for frontend development

local options = {
  -- completeopt = { "menuone", "noselect", "noinsert" },
  -- completeopt = "menu,menuone,noselect",
  completeopt = 'menu,menuone,noselect,noinsert',
  backup = false,            -- creates a backup file
  clipboard = "unnamedplus", -- allows neovim to access the system clipboard
  cmdheight = 2,             -- more space in the neovim command line for displaying messages
  -- completeopt = { "menuone", "noselect" }, -- mostly just for cmp
  conceallevel = 0,          -- so that `` is visible in markdown files
  fileencoding = "utf-8",    -- the encoding written to a file
  hlsearch = true,           -- highlight all matches on previous search pattern
  ignorecase = true,         -- ignore case in search patterns
  mouse = "a",               -- allow the mouse to be used in neovim
  -- mousemodel = "", -- the mouse will extend selection
  pumheight = 10,            -- pop up menu height
  showmode = false,          -- we don't need to see things like -- INSERT -- anymore
  showtabline = 2,           -- always show tabs
  smartcase = true,          -- smart case
  smartindent = true,        -- make indenting smarter again
  splitbelow = true,         -- force all horizontal splits to go below current window
  splitright = true,         -- force all vertical splits to go to the right of current window
  swapfile = false,          -- creates a swapfile
  termguicolors = true,      -- set term gui colors (most terminals support this)
  timeoutlen = 400,          -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true,           -- enable persistent undo
  updatetime = 300,          -- faster completion (4000ms default)
  writebackup = false,       -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  expandtab = true,          -- convert tabs to spaces
  shiftwidth = 2,            -- the number of spaces inserted for each indentation
  tabstop = 2,               -- insert 2 spaces for a tab
  cursorline = true,         -- highlight the current line
  number = true,             -- set numbered lines
  relativenumber = true,     -- set relative numbered lines
  numberwidth = 2,           -- set number column width to 2 {default 4}
  signcolumn = "yes",        -- always show the sign column, otherwise it would shift the text each time
  wrap = false,              -- display lines as one long line
  scrolloff = 10,            -- keep 10 lines above/below cursor
  sidescrolloff = 10,        -- keep 10 lines to left/right of cursor
  synmaxcol = 300,           -- limit syntax highlighting column range
  guifont = "monospace:h17", -- the font used in graphical neovim applications

  breakindent = true,





  --	spell = true,
  -- spelllang = { "en_us" },

  -- folding based on treesitter
  -- foldmethod = "expr",
  -- foldexpr = "nvim_treesitter#foldexpr()",
  -- foldlevel = 20,
}
-- Apply all options
for k, v in pairs(options) do
  vim.opt[k] = v
end

-- Shorter messages
vim.opt.shortmess:append("c")

-- Allow cursor to wrap to next/previous line
vim.opt.whichwrap:append("<,>,[,],h,l")

-- Treat dash-separated words as single word
vim.opt.iskeyword:append("-")

-- Prevent auto-commenting new lines
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
  desc = "Disable auto-commenting on new lines",
})

-- Highlight on yank (built-in since Neovim 0.5)
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
  desc = "Highlight yanked text",
})

-- Restore last cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    if vim.o.diff then
      return
    end
    local last_pos = vim.api.nvim_buf_get_mark(0, '"')
    local last_line = vim.api.nvim_buf_line_count(0)
    local row = last_pos[1]
    if row < 1 or row > last_line then
      return
    end
    pcall(vim.api.nvim_win_set_cursor, 0, last_pos)
  end,
  desc = "Restore last cursor position",
})

-- Wrap, linebreak for markdown, gitcommit
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "gitcommit" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
  end,
  desc = "Enable wrap for markdown/gitcommit",
})
