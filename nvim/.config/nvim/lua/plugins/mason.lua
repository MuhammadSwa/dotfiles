-- Mason (deferred to VeryLazy — keeps LSP/formatter installer off the
-- critical startup path; vim.lsp.enable() in core/lsp/init.lua attaches on
-- FileType regardless of when Mason loads)
return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    event = "VeryLazy",
    opts = {
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
    },
    config = function(_, opts)
      require("mason").setup(opts)

      -- Ensure non-LSP tools are installed
      local ok, mason_registry = pcall(require, "mason-registry")
      if not ok then
        return
      end
      local tools = {
        "oxfmt",
        "oxlint",
        "prettierd",
        "stylua",
      }
      for _, tool in ipairs(tools) do
        local pkg_ok, pkg = pcall(mason_registry.get_package, tool)
        if pkg_ok and not pkg:is_installed() then
          pkg:install()
        end
      end
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    event = "VeryLazy",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
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
    },
  },
}
