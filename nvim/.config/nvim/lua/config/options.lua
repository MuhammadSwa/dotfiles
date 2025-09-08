local options = {
number = true ,-- line numbers
relativenumber = true,  -- relative line numbers
cursorline = true, -- highlight current number
wrap = false      ,-- don't wrap lines
scrolloff = 10    ,-- keep 10 lines about/below cursor
sidescrolloff = 8 ,-- keep 8 columns left/right of cursor

-- Indentation
tabstop = 2        ,-- Tab width
shiftwidth = 2     ,-- Indent width
softtabstop = 2    ,-- Soft tab stop
expandtab = true   ,-- Use spaces instead of tabs
smartindent = true ,-- Smart auto-indenting
autoindent = true  ,-- Copy indent from current line

-- Search settings
ignorecase = true ,-- Case insensitive search
smartcase = true  ,-- Case sensitive if uppercase in search
hlsearch = false                           ,-- Don't highlight search results
incsearch = true  ,-- Show matches as you type

-- Visual settings
termguicolors = true                      ,-- Enable 24-bit colors
signcolumn = "yes"                        ,-- Always show sign column
showmatch = true                          ,-- Highlight matching brackets
matchtime = 2                             ,-- How long to show matching bracket
cmdheight = 1                             ,-- Command line height
completeopt = "menuone,noinsert,noselect" ,-- Completion options
showmode = false                          ,-- Don't show mode in command line
pumheight = 10                            ,-- Popup menu height
pumblend = 10                             ,-- Popup menu transparency
winblend = 0                              ,-- Floating window transparency
conceallevel = 0                          ,-- Don't hide markup
concealcursor = ""                        ,-- Don't hide cursor line markup
lazyredraw = true                         ,-- Don't redraw during macros
synmaxcol = 300                           ,-- Syntax highlighting limit
winborder = "rounded",

-- File handling
backup = false                            ,-- Don't create backup files
writebackup = false                       ,-- Don't create backup before writing
swapfile = false                          ,-- Don't create swap files
undofile = true                           ,-- Persistent undo
undodir = vim.fn.expand("~/.vim/undodir") ,-- Undo directory
updatetime = 300                          ,-- Faster completion
timeoutlen = 500                          ,-- Key timeout duration
ttimeoutlen = 0                           ,-- Key code timeout
autoread = true                           ,-- Auto reload files changed outside vim
autowrite = false                         ,-- Don't auto save

-- Behavior settings
hidden = true                     ,-- Allow hidden buffers
errorbells = false                ,-- No error bells
backspace = "indent,eol,start"    ,-- Better backspace behavior
autochdir = false                 ,-- Don't auto change directory
modifiable = true                 ,-- Allow buffer modifications
encoding = "UTF-8"                ,-- Set encoding


-- Folding settings
foldmethod = "expr"                           ,-- Use expression for folding
foldexpr = "v:lua.vim.treesitter.foldexpr()" ,-- Use treesitter for folding
foldlevel = 99                                ,-- Start with all folds open

-- Spit behavior
splitbelow = true ,-- Horizontal splits go below
splitright = true ,-- Vertical splits go right



-- Performance improvements
redrawtime = 10000,
maxmempattern = 20000,
}

-- k is key , v value
-- vim.opt[key] = value
--
for k, v in pairs(options) do
  vim.opt[k] = v
end


-- so when we comment -- and go to the second line doesn't comment

vim.cmd([[
    autocmd BufWinEnter * :set formatoptions-=cro
]])
--
-- Key mappings
vim.g.mapleader = " "      -- Set leader key to space
vim.g.maplocalleader = " " -- Set local leader key (NEW)

-- Better diff options
vim.opt.diffopt:append("linematch:60")


vim.opt.iskeyword:append("-")           -- Treat dash as part of word
vim.opt.path:append("**")               -- include subdirectories in search
vim.opt.clipboard:append("unnamedplus") -- Use system clipboard

--
-- vim.o.number = true -- line numbers
-- vim.o.relativenumber = true  -- relative line numbers
-- vim.o.cursorline = true -- highlight current number
-- vim.o.wrap = false      -- don't wrap lines
-- vim.o.scrolloff = 10    -- keep 10 lines about/below cursor
-- vim.o.sidescrolloff = 8 -- keep 8 columns left/right of cursor
--
-- -- -- Indentation
-- vim.o.tabstop = 2        -- Tab width
-- vim.o.shiftwidth = 2     -- Indent width
-- vim.o.softtabstop = 2    -- Soft tab stop
-- vim.o.expandtab = true   -- Use spaces instead of tabs
-- vim.o.smartindent = true -- Smart auto-indenting
-- vim.o.autoindent = true  -- Copy indent from current line
--
-- -- Search settings
-- vim.o.ignorecase = true -- Case insensitive search
-- vim.o.smartcase = true  -- Case sensitive if uppercase in search
-- -- vim.o.hlsearch = false                           -- Don't highlight search results
-- vim.o.incsearch = true  -- Show matches as you type
--
-- -- Visual settings
-- vim.o.termguicolors = true                      -- Enable 24-bit colors
-- vim.o.signcolumn = "yes"                        -- Always show sign column
-- vim.o.showmatch = true                          -- Highlight matching brackets
-- vim.o.matchtime = 2                             -- How long to show matching bracket
-- vim.o.cmdheight = 1                             -- Command line height
-- vim.o.completeopt = "menuone,noinsert,noselect" -- Completion options
-- vim.o.showmode = false                          -- Don't show mode in command line
-- vim.o.pumheight = 10                            -- Popup menu height
-- vim.o.pumblend = 10                             -- Popup menu transparency
-- vim.o.winblend = 0                              -- Floating window transparency
-- vim.o.conceallevel = 0                          -- Don't hide markup
-- vim.o.concealcursor = ""                        -- Don't hide cursor line markup
-- vim.o.lazyredraw = true                         -- Don't redraw during macros
-- vim.o.synmaxcol = 300                           -- Syntax highlighting limit
-- vim.o.winborder = "rounded"
--
-- -- File handling
-- vim.o.backup = false                            -- Don't create backup files
-- vim.o.writebackup = false                       -- Don't create backup before writing
-- vim.o.swapfile = false                          -- Don't create swap files
-- vim.o.undofile = true                           -- Persistent undo
-- vim.o.undodir = vim.fn.expand("~/.vim/undodir") -- Undo directory
-- vim.o.updatetime = 300                          -- Faster completion
-- vim.o.timeoutlen = 500                          -- Key timeout duration
-- vim.o.ttimeoutlen = 0                           -- Key code timeout
-- vim.o.autoread = true                           -- Auto reload files changed outside vim
-- vim.o.autowrite = false                         -- Don't auto save
--
-- -- Behavior settings
-- vim.o.hidden = true                     -- Allow hidden buffers
-- vim.o.errorbells = false                -- No error bells
-- vim.o.backspace = "indent,eol,start"    -- Better backspace behavior
-- vim.o.autochdir = false                 -- Don't auto change directory
-- vim.o.modifiable = true                 -- Allow buffer modifications
-- vim.o.encoding = "UTF-8"                -- Set encoding
--
--
-- -- Folding settings
-- vim.o.foldmethod = "expr"                           -- Use expression for folding
-- vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- Use treesitter for folding
-- vim.o.foldlevel = 99                                -- Start with all folds open
--
-- -- Split behavior
-- vim.o.splitbelow = true -- Horizontal splits go below
-- vim.o.splitright = true -- Vertical splits go right
--
--
-- -- Better diff options
--
-- -- Performance improvements
-- vim.o.redrawtime = 10000
-- vim.o.maxmempattern = 20000
--
--
