-- ═══════════════════════════════════════════════════════════════════
-- Neovim Keymaps Configuration
-- Leader key: Space (set in lazy.lua)
-- ═══════════════════════════════════════════════════════════════════

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Helper function for keymap with description
local function map(mode, lhs, rhs, desc)
  keymap(mode, lhs, rhs, { noremap = true, silent = true, desc = desc })
end

-- ═══════════════════════════════════════════════════════════════════
-- General Keymaps
-- ═══════════════════════════════════════════════════════════════════

-- Clear search highlights with Escape
map("n", "<Esc>", "<cmd>nohlsearch<CR>", "Clear search highlights")

-- Save file
map("n", "<leader>w", "<cmd>w<CR>", "Save file")

-- Better half-page scrolling (center cursor)
map("n", "<C-d>", "<C-d>zz", "Scroll down half page")
map("n", "<C-u>", "<C-u>zz", "Scroll up half page")

-- Keep cursor centered when searching
map("n", "n", "nzzzv", "Next search result")
map("n", "N", "Nzzzv", "Previous search result")

-- Wrap-aware j/k movement
vim.keymap.set("n", "j", function()
  return vim.v.count == 0 and "gj" or "j"
end, { expr = true, silent = true, desc = "Down (wrap-aware)" })
vim.keymap.set("n", "k", function()
  return vim.v.count == 0 and "gk" or "k"
end, { expr = true, silent = true, desc = "Up (wrap-aware)" })

-- Move lines up/down in normal mode
map("n", "<A-j>", ":m .+1<CR>==", "Move line down")
map("n", "<A-k>", ":m .-2<CR>==", "Move line up")

-- Clipboard: delete without yanking
map("x", "<leader>p", '"_dP', "Paste without yanking")
map({ "n", "v" }, "<leader>x", '"_d', "Delete without yanking")
map({ "n", "v" }, "x", '"_x', "Delete char without yanking")

-- Yank and keep cursor at end of selection
map("v", "y", "ygv<Esc>", "Yank and keep cursor at end")

-- ═══════════════════════════════════════════════════════════════════
-- Window Navigation & Splits
-- ═══════════════════════════════════════════════════════════════════
map("n", "<C-h>", "<C-w>h", "Move to left window")
map("n", "<C-j>", "<C-w>j", "Move to bottom window")
map("n", "<C-k>", "<C-w>k", "Move to top window")
map("n", "<C-l>", "<C-w>l", "Move to right window")

-- Split shortcuts
map("n", "<leader>sv", "<cmd>vsplit<CR>", "Split vertically")
map("n", "<leader>sh", "<cmd>split<CR>", "Split horizontally")

-- Window resizing
map("n", "<C-Up>", "<cmd>resize +2<CR>", "Increase window height")
map("n", "<C-Down>", "<cmd>resize -2<CR>", "Decrease window height")
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", "Increase window width")
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", "Decrease window width")

-- ═══════════════════════════════════════════════════════════════════
-- Buffer Navigation (Bufferline)
-- ═══════════════════════════════════════════════════════════════════
map("n", "<S-l>", "<cmd>bnext<CR>", "Next buffer")
map("n", "<S-h>", "<cmd>bprevious<CR>", "Previous buffer")
map("n", "gb", "<cmd>BufferLinePick<CR>", "Pick buffer")
map("n", "<C-w>", "<cmd>bdelete<CR>", "Close buffer")
map("n", "<A-w>", "<cmd>bdelete!<CR>", "Force close buffer")

-- ═══════════════════════════════════════════════════════════════════
-- Visual Mode
-- ═══════════════════════════════════════════════════════════════════
-- Stay in indent mode
map("v", "<", "<gv", "Indent left")
map("v", ">", ">gv", "Indent right")

-- Move selected lines
map("v", "J", ":m '>+1<CR>gv=gv", "Move selection down")
map("v", "K", ":m '<-2<CR>gv=gv", "Move selection up")

-- ═══════════════════════════════════════════════════════════════════
-- File Explorer (nvim-tree)
-- ═══════════════════════════════════════════════════════════════════
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", "Toggle file explorer")

-- ═══════════════════════════════════════════════════════════════════
-- Motion (Hop)
-- ═══════════════════════════════════════════════════════════════════
map("", "f", "<cmd>HopChar1CurrentLine<CR>", "Hop to char (line)")
map("", ",", "<cmd>HopChar2<CR>", "Hop to 2 chars")
map("n", ";", "<cmd>HopLine<CR>", "Hop to line")

-- ═══════════════════════════════════════════════════════════════════
-- Fzf-lua (Fuzzy Finder)
-- ═══════════════════════════════════════════════════════════════════
local function fzf_map(lhs, command, desc)
  map("n", lhs, function()
    require("fzf-lua")[command]()
  end, desc)
end

-- File finding
fzf_map("<leader>ff", "files", "Find files")
fzf_map("<leader>fg", "live_grep", "Live grep")
fzf_map("<leader>fb", "buffers", "Find buffers")
fzf_map("<leader>fh", "help_tags", "Help tags")
fzf_map("<leader>fw", "grep_string", "Grep word under cursor")
fzf_map("<leader>fo", "oldfiles", "Recent files")

-- LSP with Fzf
fzf_map("<leader>fd", "diagnostics_workspace", "Find diagnostics")
fzf_map("<leader>fr", "lsp_references", "Find references")
fzf_map("<leader>fs", "lsp_document_symbols", "Document symbols")

-- Git with Fzf
fzf_map("<leader>gc", "git_commits", "Git commits")
fzf_map("<leader>gs", "git_status", "Git status")
fzf_map("<leader>gb", "git_branches", "Git branches")

-- ═══════════════════════════════════════════════════════════════════
-- Diagnostics
-- ═══════════════════════════════════════════════════════════════════
map("n", "gl", vim.diagnostic.open_float, "Show diagnostics")
map("n", "[d", vim.diagnostic.goto_prev, "Previous diagnostic")
map("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
map("n", "<leader>q", vim.diagnostic.setloclist, "Diagnostics to loclist")

-- ═══════════════════════════════════════════════════════════════════
-- Formatting
-- ═══════════════════════════════════════════════════════════════════
map("n", "<leader>cf", function()
  local conform_ok, conform = pcall(require, "conform")
  if conform_ok then
    conform.format({ async = true, lsp_fallback = true })
  else
    vim.lsp.buf.format({ async = true })
  end
end, "Format file")

map("v", "<leader>cf", function()
  local conform_ok, conform = pcall(require, "conform")
  if conform_ok then
    conform.format({ async = true, lsp_fallback = true })
  else
    vim.lsp.buf.format({ async = true })
  end
end, "Format selection")

-- ═══════════════════════════════════════════════════════════════════
-- TypeScript Tools (Frontend Specific)
-- ═══════════════════════════════════════════════════════════════════
map("n", "<leader>to", "<cmd>TSToolsOrganizeImports<CR>", "TS: Organize imports")
map("n", "<leader>ts", "<cmd>TSToolsSortImports<CR>", "TS: Sort imports")
map("n", "<leader>tu", "<cmd>TSToolsRemoveUnused<CR>", "TS: Remove unused")
map("n", "<leader>tf", "<cmd>TSToolsFixAll<CR>", "TS: Fix all")
map("n", "<leader>ti", "<cmd>TSToolsAddMissingImports<CR>", "TS: Add missing imports")
map("n", "<leader>tr", "<cmd>TSToolsRenameFile<CR>", "TS: Rename file")
map("n", "<leader>td", "<cmd>TSToolsGoToSourceDefinition<CR>", "TS: Go to source definition")

-- ═══════════════════════════════════════════════════════════════════
-- Development Commands (Terminal)
-- ═══════════════════════════════════════════════════════════════════
map("n", "<leader>dn", function() floating_term_exec("npm run dev") end, "npm run dev")
map("n", "<leader>dp", function() floating_term_exec("pnpm dev") end, "pnpm dev")
map("n", "<leader>db", function() floating_term_exec("npm run build") end, "npm run build")
map("n", "<leader>pk", "<cmd>edit package.json<CR>", "Open package.json")

-- ═══════════════════════════════════════════════════════════════════
-- Trouble (Diagnostics Panel)
-- ═══════════════════════════════════════════════════════════════════
map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", "Toggle diagnostics")
map("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", "Buffer diagnostics")
map("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=false<CR>", "Toggle symbols")
map("n", "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<CR>", "LSP definitions")
map("n", "<leader>xL", "<cmd>Trouble loclist toggle<CR>", "Location list")
map("n", "<leader>xQ", "<cmd>Trouble qflist toggle<CR>", "Quickfix list")
