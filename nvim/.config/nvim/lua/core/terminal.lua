-- Custom floating terminal (no plugin needed)
local term_buf = nil
local term_win = nil

local function toggle_terminal(cmd)
  -- Close if already open
  if term_win and vim.api.nvim_win_is_valid(term_win) then
    vim.api.nvim_win_close(term_win, true)
    term_win = nil
    return
  end

  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.75)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  -- Create new buffer if needed
  if not term_buf or not vim.api.nvim_buf_is_valid(term_buf) then
    term_buf = vim.api.nvim_create_buf(false, true)
    vim.bo[term_buf].buflisted = false
    vim.bo[term_buf].bufhidden = "hide"
  end

  term_win = vim.api.nvim_open_win(term_buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
  })

  if cmd then
    vim.fn.jobstart(cmd, { term = true })
  elseif vim.bo[term_buf].buftype ~= "terminal" then
    vim.cmd("terminal zsh")
  end
  vim.bo[term_buf].buflisted = false
  vim.cmd("startinsert")
end

local function term_exec(cmd)
  toggle_terminal()
  vim.defer_fn(function()
    if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
      vim.fn.jobstart(cmd, { term = true })
      vim.cmd("startinsert")
    end
  end, 100)
end

_G.floating_terminal = toggle_terminal
_G.floating_term_exec = term_exec

vim.keymap.set("n", [[<C-\>]], function() toggle_terminal() end, { desc = "Toggle terminal" })
vim.keymap.set("t", [[<C-\>]], function() toggle_terminal() end, { desc = "Toggle terminal" })

-- Keep terminal buffer unlisted
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "term://*",
  callback = function()
    vim.bo.buflisted = false
  end,
})
