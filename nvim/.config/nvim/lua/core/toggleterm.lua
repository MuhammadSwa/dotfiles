local cmp_status_ok, toggleterm = pcall(require, "toggleterm")
if not cmp_status_ok then
  vim.notify("toggleterm could not be loaded", vim.log.levels.ERROR)
  return
end

toggleterm.setup({
  size = 20,
  open_mapping = [[<c-\>]],
  hide_numbers = true,
  shade_filetypes = {},
  shade_terminals = true,
  autochdir = true, -- when neovim changes it current directory the terminal will change it's own when next it's opened
  shading_factor = 2,
  start_in_insert = true,
  insert_mappings = true,
  persist_size = true,
  direction = "float",
  close_on_exit = true,
  shell = 'zsh',
  float_opts = {
    border = "curved",
    winblend = 0,
    highlights = {
      border = "Normal",
      background = "Normal",
    },
  },
})

-- local gitTerminal = require("toggleterm.terminal").Terminal
-- local lazygit = gitTerminal:new({ cmd = "lazygit", hidden = true })
-- function _LAZYGIT_TOGGLE()
-- 	lazygit:toggle()
-- end
-- vim.keymap.set("n", "<leader>gg", "<cmd>lua _lazygit_toggle()<CR>", { noremap = true, silent = true })
--
-- local wuzzTerminal = require("toggleterm.terminal").Terminal
-- local wuzz = wuzzTerminal:new({ cmd = "wuzz", hidden = true })
-- function _wuzz_toggle()
-- 	wuzz:toggle()
-- end
-- vim.keymap.set("n", "<leader>gh", "<cmd>lua _wuzz_toggle()<CR>", { noremap = true, silent = true })
-- command! -count=1 TermGitPush  lua require'toggleterm'.exec("git push",    <count>, 12)
-- command! -count=1 TermGitPushF lua require'toggleterm'.exec("git push -f", <count>, 12)
