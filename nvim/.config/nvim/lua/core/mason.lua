require("mason").setup({
  ui = {
    check_outdated_packages_on_open = true,

    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    },
    -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
    border = "none",

    -- The backdrop opacity. 0 is fully opaque, 100 is fully transparent.
    backdrop = 60,

    -- Width of the window. Accepts:
    -- - Integer greater than 1 for fixed width.
    -- - Float in the range of 0-1 for a percentage of screen width.
    width = 0.8,

    -- Height of the window. Accepts:
    -- - Integer greater than 1 for fixed height.
    -- - Float in the range of 0-1 for a percentage of screen height.
    height = 0.9,

    keymaps = {
      ---@since 1.0.0
      -- Keymap to expand a package
      toggle_package_expand = "<CR>",
      ---@since 1.0.0
      -- Keymap to install the package under the current cursor position
      install_package = "i",
      ---@since 1.0.0
      -- Keymap to reinstall/update the package under the current cursor position
      update_package = "u",
      ---@since 1.0.0
      -- Keymap to check for new version for the package under the current cursor position
      check_package_version = "c",
      ---@since 1.0.0
      -- Keymap to update all installed packages
      update_all_packages = "U",
      ---@since 1.0.0
      -- Keymap to check which installed packages are outdated
      check_outdated_packages = "C",
      ---@since 1.0.0
      -- Keymap to uninstall a package
      uninstall_package = "X",
      ---@since 1.0.0
      -- Keymap to cancel a package installation
      cancel_installation = "<C-c>",
      ---@since 1.0.0
      -- Keymap to apply language filter
      apply_language_filter = "<C-f>",
      ---@since 1.1.0
      -- Keymap to toggle viewing package installation log
      toggle_package_install_log = "<CR>",
      ---@since 1.8.0
      -- Keymap to toggle the help view
      toggle_help = "g?",
    },

  },


  -- Limit for the maximum amount of packages to be installed at the same time. Once this limit is reached, any further
  -- packages that are requested to be installed will be put in a queue.
  max_concurrent_installers = 4,


  pip = {
    -- Whether to upgrade pip to the latest version in the virtual environment before installing packages.
    upgrade_pip = false,
  },


})
require("mason-lspconfig").setup({
  -- Automatically install these LSPs
  ensure_installed = {
    'lua_ls',      -- Lua
    'ts_ls',       -- TypeScript/JavaScript
    'gopls',       -- Go
    'jsonls',      -- JSON
    'html',        -- HTML
    'cssls',       -- CSS
    'tailwindcss', -- Tailwind CSS
    'bashls',      -- Bash
  },
  automatic_installation = true,
})

require("mason-lspconfig").setup_handlers {
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function(server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup {}
  end,
  -- Next, you can provide a dedicated handler for specific servers.
  -- For example, a handler override for the `rust_analyzer`:
  -- ["rust_analyzer"] = function ()
  --     require("rust-tools").setup {}
  -- end
}
