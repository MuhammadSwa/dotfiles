local options = {
  completeopt = "menu,menuone,noselect,noinsert",
  clipboard = "unnamedplus",
  cmdheight = 2,
  conceallevel = 0,
  hlsearch = true,
  ignorecase = true,
  mouse = "a",
  pumheight = 10,
  showmode = false,
  showtabline = 2,
  smartcase = true,
  smartindent = true,
  splitbelow = true,
  splitright = true,
  swapfile = false,
  termguicolors = true,
  timeoutlen = 400,
  undofile = true,
  updatetime = 300,
  writebackup = false,
  expandtab = true,
  shiftwidth = 2,
  tabstop = 2,
  cursorline = true,
  number = true,
  relativenumber = true,
  numberwidth = 2,
  signcolumn = "yes",
  wrap = false,
  scrolloff = 10,
  sidescrolloff = 10,
  synmaxcol = 300,
  guifont = "monospace:h17",
  breakindent = true,

  -- Treesitter-based folding
  foldmethod = "expr",
  foldexpr = "v:lua.vim.treesitter.foldexpr()",
  foldlevel = 20,
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.opt.shortmess:append("c")
vim.opt.whichwrap:append("<,>,[,],h,l")
vim.opt.iskeyword:append("-")

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
  desc = "Disable auto-commenting on new lines",
})

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
  desc = "Highlight yanked text",
})

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

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "gitcommit" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
  end,
  desc = "Enable wrap for markdown/gitcommit",
})
