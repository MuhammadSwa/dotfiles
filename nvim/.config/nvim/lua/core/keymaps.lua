local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

local keymap = vim.keymap.set

keymap('n', '<Esc>', ":if &hlsearch | :nohlsearch | :else | :echomsg 'No highlights to clear' | :endif<CR>",
  { noremap = true, silent = true })

keymap("", "f", ":HopChar1CurrentLine<cr>", opts)
keymap("", ",", ":HopChar2<cr>", opts)
keymap("n", ";", ":HopLine<cr>", opts)

keymap("n", "<leader>e", ":NvimTreeToggle<cr>", opts)

-- Telescope
local builtin = require("telescope.builtin")
keymap("n", "<leader>ff", builtin.find_files, {})
keymap("n", "<leader>fg", builtin.live_grep, {})
keymap("n", "<leader>fb", builtin.buffers, {})
keymap("n", "<leader>fh", builtin.help_tags, {})
keymap('n', '<leader>fd', builtin.diagnostics, {})



keymap("n", "<leader>w", ":w<cr>", opts)
keymap("n", "<leader>fo", ":lua vim.lsp.buf.format()<cr>", opts)

-- horizontal and vertical split
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

keymap("n", "<leader>e", ":NvimTreeToggle<cr>", opts)
keymap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize +2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize -2<CR>", opts)

--- bufferline
-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)
keymap("n", "gb", ":BufferLinePick<CR>", opts)

-- Delete buffers
keymap("n", "<c-w>", "<cmd>bdelete<cr>", opts)
keymap("n", "<A-w>", "<cmd>bdelete!<cr>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- half page
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)

-- split and join
keymap("n", "<leader>m", require("treesj").toggle)


------------------------- Trouble
--      desc = "Diagnostics (Trouble)",
keymap("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", opts)
--      desc = "Buffer Diagnostics (Trouble)",
keymap("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", opts)
--      desc = "Symbols (Trouble)",
keymap("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", opts)
--      desc = "LSP Definitions / references / ... (Trouble)",
keymap("n", "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", opts)
--      desc = "Location List (Trouble)",
keymap("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", opts)
--      desc = "Quickfix List (Trouble)",
keymap("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", opts)
