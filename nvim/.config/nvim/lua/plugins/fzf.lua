return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = "FzfLua",
  config = function()
    require("fzf-lua").setup({
      files = {
        fd_opts = "--color=never --type f --hidden --follow --exclude .git --exclude node_modules --exclude dist --exclude build",
      },
    })
  end,
}
