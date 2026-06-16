-- Treesitter configuration is now in plugins/init.lua (nvim-treesitter v1.0+ API)

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

