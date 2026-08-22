-- nvim-ts-autotag for auto-closing HTML/JSX tags
-- Updated for nvim-treesitter main branch (0.12+)
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

-- Blueprint: manually managed parser (not in nvim-treesitter main-branch registry)
-- Parser .so lives in ~/.local/share/nvim/site/parser/blueprint.so
vim.api.nvim_create_autocmd("FileType", {
  pattern = "blueprint",
  callback = function(args)
    pcall(vim.treesitter.start, args.buf, "blueprint")
  end,
})

-- ts-context-commentstring for proper JSX/TSX comments
local ok, ts_context_commentstring = pcall(require, "ts_context_commentstring")
if ok then
  ts_context_commentstring.setup({
    enable_autocmd = false,
  })
  local get_option = vim.filetype.get_option
  vim.filetype.get_option = function(filetype, option)
    return option == "commentstring"
        and require("ts_context_commentstring.internal").calculate_commentstring()
        or get_option(filetype, option)
  end
end
