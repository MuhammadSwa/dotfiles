-- Dart / Flutter development
--
-- flutter-tools.nvim manages `dartls` itself (from the Flutter SDK on PATH).
-- Do NOT configure dartls via vim.lsp.config — it would conflict with this
-- plugin's setup (it adds flutter-specific handlers, dev log, hot reload...).
return {
  {
    "nvim-flutter/flutter-tools.nvim",
    lazy = false, -- registers :Flutter* commands at startup
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- ensure blink.cmp is set up first so we can pull LSP capabilities
      "saghen/blink.cmp",
    },
    opts = {
      ui = {
        border = "rounded",
      },
      decorations = {
        statusline = {
          app_version = true,
          device = true,
        },
      },
      widget_guides = { enabled = true },
      closing_tags = {
        highlight = "Comment",
        prefix = " // ",
        enabled = true,
      },
      dev_log = {
        enabled = true,
        open_cmd = "botright 15split",
        focus_on_open = false,
      },
      lsp = {
        settings = {
          showTodos = true,
          completeFunctionCalls = true,
          enableSnippets = true,
          updateImportsOnRename = true,
          renameFilesWithClasses = "prompt",
          lineLength = 80,
        },
      },
      debugger = {
        -- Requires nvim-dap (loaded below); registers dart/flutter adapters
        -- from the Flutter SDK automatically (`dart/flutter debug_adapter`)
        enabled = true,
        run_via_dap = true, -- :FlutterRun launches through DAP (breakpoints work)
        exception_breakpoints = {
          uncaught = true,
          all = false,
        },
        register_configurations = function(paths)
          local dap = require("dap")
          dap.configurations.dart = dap.configurations.dart or {}
          if #dap.configurations.dart == 0 then
            table.insert(dap.configurations.dart, {
              type = "flutter",
              request = "launch",
              name = "Launch flutter",
              program = "${workspaceFolder}/lib/main.dart",
              cwd = "${workspaceFolder}",
              toolArgs = { "--dart-define-from-file=config.json" },
            })
          end
          dap.adapters.flutter = dap.adapters.flutter
            or {
              type = "executable",
              command = "flutter",
              args = { "debug_adapter" },
            }
          dap.adapters.dart = dap.adapters.dart
            or {
              type = "executable",
              command = "dart",
              args = { "debug_adapter" },
            }
        end,
      },
    },
    config = function(_, opts)
      opts.lsp.capabilities = require("blink.cmp").get_lsp_capabilities()
      require("flutter-tools").setup(opts)
    end,
  },

  -- Debug Adapter Protocol UI (breakpoints, scopes, repl)
  {
    "mfussenegger/nvim-dap",
    lazy = true,
    keys = {
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint" },
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Condition: ")) end, desc = "Conditional breakpoint" },
      { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Step into" },
      { "<leader>do", function() require("dap").step_over() end, desc = "Step over" },
      { "<leader>dO", function() require("dap").step_out() end, desc = "Step out" },
      { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate debug session" },
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    lazy = true,
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    keys = {
      { "<leader>du", function() require("dapui").toggle({}) end, desc = "Toggle DAP UI" },
    },
    opts = {},
  },
}
