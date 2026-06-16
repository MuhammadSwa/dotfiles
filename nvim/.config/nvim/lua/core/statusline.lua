-- Custom statusline (no plugin needed)
local cached_branch = ""
local last_check = 0
local function git_branch()
  local now = vim.uv.now()
  if now - last_check > 5000 then
    cached_branch = vim.fn.system("git branch --show-current 2>/dev/null | tr -d '\n'")
    last_check = now
  end
  if cached_branch ~= "" then
    return " " .. cached_branch .. " "
  end
  return ""
end

local function file_type()
  local ft = vim.bo.filetype
  local icons = {
    lua = " ",
    zig = " ",
    python = " ",
    javascript = " ",
    typescript = " ",
    javascriptreact = " ",
    typescriptreact = " ",
    html = " ",
    css = " ",
    json = " ",
    markdown = " ",
    vim = " ",
    sh = " ",
    bash = " ",
    zsh = " ",
    rust = " ",
    go = " ",
    c = " ",
    cpp = " ",
    php = " ",
    kotlin = " ",
    dart = " ",
    sql = " ",
    yaml = " ",
    toml = " ",
    xml = " ",
    dockerfile = " ",
    gitcommit = " ",
    gitconfig = " ",
    vue = " ",
    svelte = " ",
    astro = " ",
  }
  if ft == "" then
    return " "
  end
  return (icons[ft] or " ") .. ft
end

_G.git_branch = git_branch
_G.file_type = file_type

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
  callback = function()
    vim.opt_local.statusline = table.concat({
      " ",
      "%f %h%m%r",
      "%{v:lua.git_branch()}",
      " ",
      "%{v:lua.file_type()}",
      "%=",
      " %l:%c  %P ",
    })
  end,
})

vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
  callback = function()
    vim.opt_local.statusline = " %f %h%m%r %{v:lua.git_branch()} %= %l:%c %P "
  end,
})
