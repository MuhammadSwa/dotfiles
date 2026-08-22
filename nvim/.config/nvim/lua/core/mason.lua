require("mason").setup({
  ui = {
    check_outdated_packages_on_open = true,
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
    border = "none",
    backdrop = 60,
    width = 0.8,
    height = 0.9,
    keymaps = {
      toggle_package_expand = "<CR>",
      install_package = "i",
      update_package = "u",
      check_package_version = "c",
      update_all_packages = "U",
      check_outdated_packages = "C",
      uninstall_package = "X",
      cancel_installation = "<C-c>",
      apply_language_filter = "<C-f>",
      toggle_package_install_log = "<CR>",
      toggle_help = "g?",
    },
  },
  max_concurrent_installers = 4,
  pip = {
    upgrade_pip = false,
  },
})

require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls",
    "gopls",
    "jsonls",
    "zls",
    "bashls",
    "emmet_ls",
    "astro",
    "lemminx",
  },
  automatic_enable = {
    exclude = { "ts_ls", "astro" },
  },
})

local mason_registry_ok, mason_registry = pcall(require, "mason-registry")
if mason_registry_ok then
  local tools = {
    "oxfmt",
    "oxlint",
    "prettierd",
    "stylua",
  }
  for _, tool in ipairs(tools) do
    local pkg = mason_registry.get_package(tool)
    if not pkg:is_installed() then
      pkg:install()
    end
  end
end
